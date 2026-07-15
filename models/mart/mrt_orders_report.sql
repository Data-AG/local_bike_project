SELECT
    order_item_id,
    order_id,
    {{ dbt_utils.generate_surrogate_key(['store_id', 'product_id']) }} as stock_id,

    order_date,
    DATE_TRUNC(order_date, MONTH) AS order_month,
    EXTRACT(YEAR FROM order_date) AS order_year,

    CASE
        WHEN order_status IN (1, 2) THEN 'In progress'
        WHEN order_status = 3 THEN 'Cancelled/Blocked'
        WHEN order_status = 4 THEN 'Shipped'
    END AS order_status_label,
    order_status = 4 AS is_completed,

    store_id, 
    store_name AS store,
    staff_id,
    staff_name AS staff,
    customer_name AS customer,
    customer_state,
    product_id,
    product_name AS product,
    brand_name AS brand,
    category_name AS category,

    quantity,
    discount,
    total_paid AS sales_amount,
    total_discount AS discount_amount
FROM {{ ref('int_local_bike_database__order_items') }}