{% if grains['os_family'] == 'RedHat' %}
  {% set mysql_python = 'MySQL-python' %}

{% elif grains['os_family'] == 'Debian' %}
  {% set mysql_python = 'python-mysqldb' %}
{% endif %}
mysql_server_install:
  pkg:
    - installed
    - pkgs:
      - mysql-server
      - {{ mysql_python }}
{% if grains['os_family'] == 'RedHat' %}
    - enablerepo: "remi,remi-test"
{% endif %}

mysql_reload_modules:
  module.run:
    - name: saltutil.refresh_modules
    - order: last