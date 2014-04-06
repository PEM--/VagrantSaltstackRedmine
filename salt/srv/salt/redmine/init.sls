include:
  - ruby
  - gems
  - database

{% set source = '/usr/local/src/' -%}
{% set redmine_version = '2.5.1' -%}
{% set redmine_package = source + 'redmine-' + redmine_version + '.tar.gz' -%}

# Step 1: Get Redmine source files
get-redmine:
  gem.installed:
    - names:
      - bundler
      - rmagick
  file.managed:
    - name: {{ redmine_package }}
    - source: http://www.redmine.org/releases/redmine-{{ redmine_version }}.tar.gz
    - source_hash: 'md5=d88ebfdb565489862fc62b4a2a575517'
  cmd.wait:
    - cwd: {{ source }}
    - name: tar xzvf {{ redmine_package }}
    - require:
      - gem: get-redmine
    - watch:
      - file: get-redmine

# Step 2: Prepare the MySQL database
redmine-db:
  mysql_database.present:
    - name: 'redmine'
    - user: 'root'
    - password: 'Redmine'
    - connection_user: 'root'
    - connection_pass: 'Redmine'
    - character_set: 'utf8'
    - require:
      - cmd: get-redmine

# Step 3: Redmine user in db
redmine-user:
  mysql_user.present:
    - name: 'redmine'
    - host: localhost
    - password: 'Redmine'
    - connection_user: 'root'
    - connection_pass: 'Redmine'
    - character_set: 'utf8'
    - require:
      - mysql_database: redmine-db

# Step 4: Grant priviledges to redmine user
# TODO: Error in Salt's module: Grants do not work but is fixed in dev
#redmine-grant:
  #cmd.run
  #mysql_grants.present:
    #- grant: all privileges
    #- database: redmine.*
    #- user: 'redmine'
    #- host: localhost
    #- password: 'Redmine'
    #- connection_user: 'root'
    #- connection_pass: 'Redmine'
    #- require:
      #- mysql_user: redmine-user

# Step 5: Configure DB access via config file
redmine-config-file:
  file.managed:
    - name: {{ source }}redmine-{{ redmine_version }}/config/database.yml
    - source: salt://redmine/database.yml
    # TODO: Fix this when Step 4 is fixed
    - require:
      - mysql_user: redmine-user

# Step 5: Bundle Redmine
redmine-bundler:
  cmd.run:
    - name: bundle install --without development test
    - cwd: {{ source }}redmine-{{ redmine_version }}
    - require:
      - file: redmine-config-file

# Step 6: Generate a secret token (a session store)
redmine-secret-token:
  cmd.run:
    - name: rake generate_secret_token
    - cwd: {{ source }}redmine-{{ redmine_version }}
    - require:
      - cmd: redmine-bundler

# Step 7: Database schema creation
redmine-schema:
  cmd.run:
    - name: RAILS_ENV=production rake db:migrate
    - cwd: {{ source }}redmine-{{ redmine_version }}
    - require:
      - cmd: redmine-secret-token

# Step8: Database default set
redmine-default-set:
  cmd.run:
    - name: RAILS_ENV=production rake redmine:load_default_data
    - cwd: {{ source }}redmine-{{ redmine_version }}
    - require:
      - cmd: redmine-schema
