database:
  pkg.installed:
    - names:
      - mysql-server
      - mysql-client
      - python-mysqldb
  service:
    - running
    - name: mysql
    - require:
      - file: /etc/mysql/my.cnf
    - watch:
      - file: /etc/mysql/my.cnf
  mysql_user:
    - present
    - name: 'root'
    - password: 'Redmine'

/etc/mysql/my.cnf:
  file.managed:
    - source: salt://database/my.cnf
    - user: root
    - group: root
    - mode: '0600'
    - require:
      - pkg: database
