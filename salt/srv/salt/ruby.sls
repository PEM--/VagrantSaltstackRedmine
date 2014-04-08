python-software-properties:
  pkg.installed

ruby-brightbox:
  pkgrepo.managed:
    - ppa: brightbox/ruby-ng
  pkg.latest:
    - names:
      - ruby1.9.3
      - passenger-common1.9.1
    - refresh: True
