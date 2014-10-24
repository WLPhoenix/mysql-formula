{% if grains['os_family'] == 'RedHat' %}
  {% set mysql_client = 'mysql' %}
  {% set mysql_java = 'mysql-connector-java' %}

{% elif grains['os_family'] == 'Debian' %}
  {% set mysql_client = 'mysql-client' %}
  {% set mysql_java = 'libmysql-java' %}
{% endif %}

mysql_client_install:
  pkg:
    - installed
    - pkgs:
      - {{ mysql_client }}
      - {{ mysql_java }}
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