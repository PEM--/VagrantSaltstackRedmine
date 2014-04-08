nginx:
  pkgrepo.managed:
    - ppa: nginx/stable
  pkg.latest:
    - name: nginx-extras
    - refresh: True
  service.running:
    - require:
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-available/default
    - watch:
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-available/default
/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://webserver/nginx.conf
/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://webserver/default
