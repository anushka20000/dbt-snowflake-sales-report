WITH CTE_prod AS
(
    SELECT product_sk, product_name, category
    FROM {{ ref('bronze_product') }}
),
CTE_customer AS 
(
    SELECT customer_sk, customer_code, first_name
    FROM {{ ref('bronze_customer') }}
)

SELECT s.customer_sk, s.product_sk, cp.product_name, cp.category, cc.customer_code, cc.first_name,  ROUND(SUM(s.net_amount), 2) as total_sales
FROM {{ ref('bronze_sales') }} as s
LEFT JOIN CTE_prod as cp
on s.product_sk = cp.product_sk
LEFT JOIN CTE_customer as cc
on s.customer_sk = cc.customer_sk
GROUP BY s.customer_sk, s.product_sk, cp.product_name, cp.category, cc.first_name, cc.customer_code
ORDER BY total_sales DESC
LIMIT 10
