include:
  - ruby

mysql2:
  pkg.installed:
    - names:
      - libmysql-ruby
      - libmysqlclient-dev
  gem.installed:
    - ri: False
    - rdoc: False
    - version: 0.3.15
    - require:
      - pkg: mysql2

bundler:
  gem.installed:
    - ri: False
    - rdoc: False

rmagick:
  pkg.installed:
    - names:
      - imagemagick
      - libmagickwand-dev
  gem.installed:
    - ri: False
    - rdoc: False
    - require:
      - pkg: rmagick
      
