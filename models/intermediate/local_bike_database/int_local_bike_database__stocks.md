{% docs int_local_bike_database__stocks %}
## int_local_bike_database__stocks

Stock coverage table, grain: 1 row = 1 store / product pair (`stock_id` => `store_id`, `product_id`).

Joins `stg_local_bike_database__stocks` (current stock on hand) with sales aggregated from `int_local_bike_database__order_items`, and with `int_local_bike_database__products` for readable labels and `list_price`.

Cancelled/Blocked orders (`order_status = 3`) are excluded from the sales aggregation.

`avg_monthly_sales` = total quantity sold in that store / number of months since the first sale of that product in that store. Returns 0 when the product has never been
sold there. `months_coverage` = stock on hand / avg_monthly_sales, NULL when the product has never been sold.
{% enddocs %}