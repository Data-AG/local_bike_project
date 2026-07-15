SELECT *
FROM {{ ref('int_local_bike_database__orders') }}
WHERE shipped_date < order_date