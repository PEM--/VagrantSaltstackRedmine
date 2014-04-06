include:
  - ruby
  - webserver

bundler:
  gem.installed:
    - ri: False
    - rdoc: False

#passenger:
  #gem.installed:
    #- ri: False
    #- rdoc: False
  #cmd.run:
    #- name: passenger-install-nginx-module
    #- require:
      #- gem: passenger

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
      
