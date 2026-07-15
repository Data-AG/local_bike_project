SELECT *
FROM {{ ref('int_local_bike_database__orders') }}
WHERE order_status = 4 AND shipped_date IS NULL