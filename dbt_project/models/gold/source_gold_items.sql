SELECT * FROM (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY id ORDER BY updated_at DESC) AS row_num
    FROM {{ source('source', 'items') }}
)
WHERE row_num = 1