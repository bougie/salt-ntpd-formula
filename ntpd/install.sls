{% from "ntpd/default.yml" import lookup, rawmap with context %}
{% set lookup = salt['grains.filter_by'](lookup, grain='os', merge=salt['pillar.get']('ntpd:lookup')) %}
{% set rawmap = salt['pillar.get']('ntpd', rawmap) %}

{% if lookup.package is defined %}
ntpd_package:
    pkg.installed:
        - name: {{lookup.package}}
{% endif %}

