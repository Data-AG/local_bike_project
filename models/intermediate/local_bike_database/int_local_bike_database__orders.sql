SELECT
    o.order_id,
    o.order_status,
    o.order_date,
    o.required_date,
    o.shipped_date,
    o.customer_id,
    c.customer_first_name || ' ' || c.customer_last_name || ' - ' || o.customer_id AS customer_name,
    c.customer_city,
    c.customer_state,
    o.store_id,
    st.store_name,
    o.staff_id,
    sf.staff_first_name || ' ' || sf.staff_last_name || ' - ' || o.staff_id AS staff_name
FROM {{ ref('stg_local_bike_database__orders') }} o
LEFT JOIN {{ ref('stg_local_bike_database__customers') }} c ON
    o.customer_id = c.customer_id
LEFT JOIN {{ ref('stg_local_bike_database__stores') }} st ON
    o.store_id = st.store_id
LEFT JOIN {{ ref('stg_local_bike_database__staffs') }} sf ON
    o.staff_id = sf.staff_id