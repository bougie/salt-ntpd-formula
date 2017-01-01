{% from "ntpd/default.yml" import lookup, rawmap with context %}
{% set lookup = salt['grains.filter_by'](lookup, grain='os', merge=salt['pillar.get']('ntpd:lookup')) %}

{% if lookup.ntpd_service is defined %}
ntpd_service:
    service.running:
        - name: {{lookup.ntpd_service}}
        - enable: True
{% endif %}

{% if lookup.ntpdate_service is defined %}
ntpdate_service:
    service.enabled:
        - name: {{lookup.ntpdate_service}}
{% endif %}
