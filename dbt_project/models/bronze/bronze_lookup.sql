{# SELECT * 
FROM {{source('default', 'lookup')}} #}


{# {% set relation = ref('lookup') %}
{% set bronze_relation = ref('bronze_lookup') %}

{% set cols = adapter.get_columns_in_relation(bronze_relation) %}
{% set bar = 1 %}
{% set inc_date = 'created_at' %}

INSERT INTO {{ bronze_relation }}
({% for col in cols %}{{ col.name }}{% if not loop.last %}, {% endif %}{% endfor %})
(select *
from {{ relation }}

{% if bar == 1 %}
where {{ inc_date }} >
(
    select coalesce(
        max({{ inc_date }}),
        cast('1900-01-01' as date)
    )
    from {{ bronze_relation }}
)
{% endif %}) #}