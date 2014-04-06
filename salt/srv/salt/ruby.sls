include:
  - apt.update
  - apt.upgrade

{% set source = '/usr/local/src/' -%}
{% set ruby_version = '1.9.3-p545' -%}
{% set ruby_package = source + 'ruby-' + ruby_version + '.tar.bz2' -%}

ruby:
  cmd.wait:
    - cwd: {{ source + 'ruby-' + ruby_version }}
    - name: ./configure && make && make install
    - watch:
      - cmd: get-ruby
    - require:
      - cmd: get-ruby
      - pkg: remove-pkg-ruby

get-ruby:
  pkg.installed:
      - names:
        - build-essential
        - zlib1g-dev
        - libssl-dev
        - libreadline-dev
        - libyaml-dev
        - libcurl4-openssl-dev
        - curl
        - git-core
        - python-software-properties
  file.managed:
    - name: {{ ruby_package }}
    - source: ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-{{ ruby_version }}.tar.bz2
    - source_hash: 'md5=4743c1dc48491070bae8fc8b423bc1a7'
  cmd.wait:
    - cwd: {{ source }}
    - name: tar xjvf {{ ruby_package }}
    - require:
      - pkg: get-ruby
    - watch:
      - file: get-ruby

remove-pkg-ruby:
  pkg.purged:
    - names:
      - ruby
      - rubygems
      - rake
      - ruby-dev
      - libreadline5
      - libruby
