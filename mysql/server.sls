{% set os_family = salt['grains.get']('os_family', None) %}

{% if os_family == 'RedHat' %}
mysql_server_install_requirements:
  pkg.installed:
    - pkg_verify: True
    - sources:
      - remi: http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
      - epel: http://dl.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
{% endif %}

mysql_server_install:
  pkg:
    - installed
    - pkgs:
      - mysql
      - mysql-server
{% if os_family == 'RedHat' %}
    - enablerepo:
      - remi
      - remi-test
  require:
    - mysql_server_remi
{% endif %}
