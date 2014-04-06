include:
  - ruby

bundler:
  gem.installed:
    - ri: False
    - rdoc: False

passenger:
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
      
