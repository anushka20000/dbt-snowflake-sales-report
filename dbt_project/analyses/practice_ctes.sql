WITH CTE_product AS
(
SELECT product_sk, category, product_name
FROM {{ ref('bronze_product') }}
),
CTE_customer AS
(
    SELECT customer_sk, customer_code, first_name
    FROM {{ ref('bronze_customer') }}
)

{# SELECT cp.product_name, cp.category, ROUND(SUM(s.net_amount), 2) as total_sales
FROM {{ ref('bronze_sales') }} as s
LEFT JOIN CTE_product as cp
ON s.product_sk = cp.product_sk
GROUP BY cp.product_name, cp.category
ORDER BY total_sales DESC
LIMIT 5 #}


{# SELECT c.customer_code, c.first_name
FROM {{ ref('bronze_sales') }} as s
LEFT JOIN CTE_customer as c
ON c.customer_sk = s.customer_sk
WHERE s.net_amount < 1 #}

SELECT c.customer_code, c.first_name, cp.product_name, ROUND(SUM(s.net_amount), 2) as total_sales
FROM {{ ref('bronze_sales') }} as s
LEFT JOIN CTE_product as cp
ON s.product_sk = cp.product_sk
LEFT JOIN CTE_customer as c
ON c.customer_sk = s.customer_sk
GROUP BY c.customer_code, c.first_name, cp.product_name
WHERE cp.product_name IS NOT NULL
ORDER BY total_sales DESC