{% if grains['os_family'] == 'RedHat' %}
  {% set mysql_client = 'mysql' %}
  {% set mysql_python = 'MySQL-python' %}
  {% set mysql_java = 'mysql-connector-java' %}

{% elif grains['os_family'] == 'Debian' %}
  {% set mysql_client = 'mysql-client' %}
  {% set mysql_python = 'python-mysqldb' %}
  {% set mysql_java = 'libmysql-java' %}

{% endif %}

mysql_install:
  pkg:
    - installed
    - pkgs:
      - {{ mysql_client }}
      - mysql-server
      - {{ mysql_java }}
      - {{ mysql_python }}
{% if grains['os_family'] == 'RedHat' %}
    - enablerepo: "remi,remi-test"
{% endif %}
    - requisite_in:
      - file: /etc/my.cnf


/etc/my.cnf:
  file.append:
    - name: /etc/my.cnf
    - text:
      - "[client]"
      - "default-character-set=utf8"

mysql_reload_modules:
  module.run:
    - name: saltutil.refresh_modules
    - order: last
