{% if grains['os_family'] == 'RedHat':
  {% set mysql_client = 'mysql' %}
  {% set mysql_python = 'MySQL-python' %}
  {% set mysql_java = 'mysql-connector-java' %}

{% elif grains['os_family'] == 'Debian' %}
  {% set mysql_client = 'mysql-client' %}
  {% set mysql_python = 'python-mysqldb' %}
  {% set mysql_java = 'libmysql-java' %}

{% endif %}

thorn_mysql_install:
  pkg:
    - installed
    - pkgs:
      - {{ mysql_client }}
      - mysql-server
      - {{ mysql_java }}
      - {{ mysql_python }}
{% if grains['os_family'] == 'RedHat' %}
    - enablerepo:
      - remi
      - remi-test
{% endif %}


salt-minion:
  pkg:
    - installed
  service:
    - running
    - require:
      - pkg:
        - salt-minion
        - {{ mysql_python }}
  cmd:
    - wait
    - name: echo service salt-minion restart | at now + 1 minute
    - watch:
      - pkg: salt-minion
