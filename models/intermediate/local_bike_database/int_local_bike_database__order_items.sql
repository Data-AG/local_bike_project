SELECT
    oi.order_item_id,
    oi.order_id,
    oi.item_id,
    o.order_date,
    o.order_status,
    o.customer_id,
    o.customer_name,
    o.customer_city,
    o.customer_state,
    o.store_id,
    o.store_name,
    o.staff_id,
    o.staff_name,
    oi.product_id,
    p.product_name,
    p.brand_name,
    p.category_name,
    oi.quantity,
    oi.list_price,
    oi.discount,
    oi.total_paid,
    oi.total_discount
FROM {{ ref('stg_local_bike_database__order_items') }} oi
INNER JOIN {{ ref('int_local_bike_database__orders') }} o ON
    oi.order_id = o.order_id
LEFT JOIN {{ ref('int_local_bike_database__products') }} p ON
    oi.product_id = p.product_id