SELECT
    order_id,
    order_date,
    required_date,
    shipped_date,
    store_id,
    store_name,
    staff_id,
    staff_name,
    DATE_DIFF(shipped_date, order_date, DAY) AS days_to_ship,
    GREATEST(DATE_DIFF(shipped_date, required_date, DAY), 0) AS days_late,
    CASE
        WHEN shipped_date IS NULL THEN 'To ship'
        WHEN shipped_date > required_date THEN 'Late'
        ELSE 'On time'
    END AS shipping_status
FROM {{ ref('int_local_bike_database__orders') }}
WHERE order_status != 3