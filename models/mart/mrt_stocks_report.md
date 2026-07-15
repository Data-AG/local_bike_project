{% docs mrt_stocks_report %}
## mrt_stocks_report

Stock status table, grain: 1 row = 1 store/product (`stock_id` => `store_id`, `product_id`).

Exposition layer on top of `int_local_bike_database__stocks`: a single parent, no join. Computes stock flags: `is_stock_out` (stock at zero), `overstock_risk` (stock present
but never sold, or coverage above 6 months) and `stock_value` (stock on hand × `list_price`, the cash tied up in inventory). Rounds the measures for display.

No time dimension: the source `stocks` table is a snapshot of the current state.

**Join key for the dashboard:**

| Key | Source | Cardinality |
| --- | --- | --- |
| `stock_id` | `mrt_orders_report` | 1 → n |

{% enddocs %}