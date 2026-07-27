WITH CTE_sales AS
(
    SELECT sales_id, product_sk, customer_sk, gross_amount, payment_method
    FROM {{ ref('bronze_sales') }}
),
CTE_prod AS
(
    SELECT product_sk, category
    FROM {{ ref('bronze_product') }}
),
CTE_customer AS 
(
    SELECT customer_sk, gender
    FROM {{ ref('bronze_customer') }}
)

SELECT cp.category, cc.gender, ROUND(SUM(s.gross_amount), 2) as total_sales
FROM CTE_sales as s     
LEFT JOIN CTE_prod as cp ON s.product_sk = cp.product_sk
LEFT JOIN CTE_customer as cc ON s.customer_sk = cc.customer_sk
GROUP BY cp.category, cc.gender
