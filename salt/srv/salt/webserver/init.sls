include:
  - import.apt.update
  - import.apt.upgrade
  - ruby

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

phusion-apt:
  cmd.wait:
    - name: apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
    - require:
      - file: /etc/apt/sources.list.d/passenger.list
  pkg.installed:
    - names:
      - apt-transport-https
      - ca-certificates
    - require:
      - pkg: nginx
      - cmd: phusion-apt

phusion-nginx:
  pkg.installed:
    - names:
      - nginx-extras
      - passenger
    - require:
      - cmd: phusion-apt
      - cmd: apt-get update
      - cmd: apt-get upgrade -y

/etc/apt/sources.list.d/passenger.list:
  file.managed:
    - source: salt://webserver/passenger.list
