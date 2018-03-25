# Meta-state to fully manage ntpd

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
