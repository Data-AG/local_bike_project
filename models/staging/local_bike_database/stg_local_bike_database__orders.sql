SELECT
    order_id,
    customer_id,
    order_status,
    order_date,
    required_date,
    SAFE_CAST(shipped_date AS DATE) as shipped_date,
    store_id,
    staff_id
FROM
    {{ source('local_bike_database','orders') }}