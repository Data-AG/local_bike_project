SELECT *
FROM {{ ref('int_local_bike_database__orders') }}
WHERE required_date < order_date