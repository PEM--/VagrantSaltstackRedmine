include:
  - ruby

# Step 0: Ensure old http server removal
old_nginx:
  pkg.removed:
    - pkgs:
      - nginx
      - nginx-common
      - nginx-extras
      - apache2

# Step 1: Enter the Phusion key into apt and ensure secure apt is available
phusion-apt:
  cmd.run:
    - name: apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
    - require:
      - pkg: old_nginx
  pkg.installed:
    - names:
      - apt-transport-https
      - ca-certificates
    - require:
      - cmd: phusion-apt
        
# Step 2: Import Phusion repository
/etc/apt/sources.list.d/passenger.list:
  file.managed:
    - source: salt://webserver/passenger.list
    - require:
      - pkg: phusion-apt

# Step 3: Update Apt using Phusion repository
phusion-update:
  cmd.run:
    - name: apt-get update
    - require:
      - file: /etc/apt/sources.list.d/passenger.list

# Step 4: Upgrade current OS state with the Phusion repository
phusion-upgrade:
  cmd.run:
    - name: apt-get upgrade -y
    - require:
      - cmd: phusion-update

# Step 6: Install NGINX and Passenger
phusion-nginx:
  pkg.installed:
    - names:
      - nginx-extras
      - passenger
    - require:
      - cmd: phusion-upgrade

# Step 7: Start NGINX service
nginx:
  service:
    - running
    - watch:
      - file: /etc/nginx/nginx.conf
      - file: /etc/nginx/sites-available/default
    - require:
      - pkg: phusion-nginx

/etc/nginx/nginx.conf:
  file.managed:
    - source: salt://webserver/nginx.conf
    - require:
      - pkg: phusion-nginx

/etc/nginx/sites-available/default:
  file.managed:
    - source: salt://webserver/default
    - require:
      - pkg: phusion-nginx
