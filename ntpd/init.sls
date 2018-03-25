# Meta-state to fully manage ntpd
{% from "ntpd/default.yml" import lookup, rawmap with context %}
{% set lookup = salt['grains.filter_by'](lookup, grain='os', merge=salt['pillar.get']('ntpd:lookup')) %}

include:
    - ntpd.config
    - ntpd.service

{% if lookup.ntpd_service is defined %}
extend:
    ntpd_service:
        service:
            - watch:
                - file: ntpd_config
            - require:
                - file: ntpd_config
{% endif %}
