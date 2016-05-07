{% from "ntpd/default.yml" import lookup, rawmap with context %}
{% set lookup = salt['grains.filter_by'](lookup, grain='os', merge=salt['pillar.get']('ntpd:lookup')) %}
{% set rawmap = salt['pillar.get']('ntpd', rawmap) %}

ntpd_config:
    file.managed:
        - name: {{lookup.config_file}}
        - source: salt://ntpd/files/ntp.conf.j2
        - template: jinja
        - makedirs: True
        - context:
            config: {{rawmap}}

timezone_config:
    file.copy:
        - name: /etc/localtime
        - source: /usr/share/zoneinfo/{{rawmap.timezone}}
        - force: True

