{% from "ntpd/default.yml" import lookup, rawmap with context %}
{% set lookup = salt['grains.filter_by'](lookup, grain='os', merge=salt['pillar.get']('ntpd:lookup')) %}
{% set rawmap = salt['pillar.get']('ntpd', rawmap) %}

ntpd_service:
    service.running:
        - name: {{lookup.service}}

