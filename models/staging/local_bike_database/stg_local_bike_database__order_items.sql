SELECT
    {{ dbt_utils.generate_surrogate_key(['order_id', 'item_id']) }} as order_item_id,
    order_id,
    item_id,
    product_id,
    quantity,
    list_price,
    discount,
    list_price * (1-discount) as paid_price,
    list_price * (discount) as discount_price,
    list_price * (1-discount) * quantity as total_paid,
    list_price * (discount) * quantity as total_discount
FROM
    {{ source('local_bike_database','order_items') }}