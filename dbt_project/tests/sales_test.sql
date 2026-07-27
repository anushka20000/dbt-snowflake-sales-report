{% set bar = 0 %}
{% set g_amt = 'gross_amount'%}
{% set n_amt = 'net_amount'%}

select * 
from {{ref('bronze_sales')}}
where {{g_amt}} < {{bar}} and {{n_amt}} < {{bar}}