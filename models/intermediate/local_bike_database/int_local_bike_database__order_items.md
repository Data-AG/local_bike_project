{% docs int_local_bike_database__order_items %}
## int_local_bike_database__order_items

Sales (order & items) fact table, grain: 1 row = 1 order item (`order_item_id`).

Joins `stg_local_bike_database__order_items` with `int_local_bike_database__orders` (order-level context and labels) and `int_local_bike_database__products` (product,
brand and category labels).

Exposes the sales measures: `quantity`, `list_price`, `discount`, `total_paid`,`total_discount`.
{% enddocs %}