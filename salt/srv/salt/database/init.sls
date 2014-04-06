database:
  pkg.installed:
    - names:
      - mysql-server
      - mysql-client
  service:
    - running
    - name: mysql
    - require:
      - pkg: database
