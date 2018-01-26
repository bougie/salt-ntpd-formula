{% from "ntpd/default.yml" import lookup, rawmap with context %}
{% set lookup = salt['grains.filter_by'](lookup, grain='os', merge=salt['pillar.get']('ntpd:lookup')) %}
{% set rawmap = salt['pillar.get']('ntpd', rawmap, merge=True) %}

ntpd_config:
    file.managed:
        - name: {{lookup.config_file}}
        - source: salt://ntpd/files/ntp.conf.j2
        - template: jinja
        - makedirs: True
        - context:
            config: {{rawmap}}

timezone_config:
    file.symlink:
        - name: /etc/localtime
        - target: /usr/share/zoneinfo/{{rawmap.timezone}}
        - force: True

{% if salt['grains.has_value']('systemd') %}
systemd_tz_config:
    file.managed:
        - name: /etc/systemd/system.conf.d/tz.conf
        - source: salt://ntpd/files/tz.conf.j2
        - template: jinja
        - makedirs: True
{% endif %}

