include:
  - import.apt.update
  - import.apt.upgrade
nginx:
  pkg:
    - installed
  service:
    - running
    - watch:
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-available/default
    - require:
      - pkg: nginx

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://webserver/nginx.conf

/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://webserver/default
