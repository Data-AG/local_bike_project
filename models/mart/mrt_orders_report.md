{% docs mrt_orders_report %}
## mrt_orders_report

Business-facing sales table, grain: 1 row = 1 order item (`order_item_id`).

Exposition layer on top of `int_local_bike_database__order_items`: a single parent, no
join. Narrows the columns to what the dashboard consumes, translates codes into labels
(`order_status_label`, `is_completed`), renames measures in business terms
(`sales_amount`, `discount_amount`) and derives the analysis axes (`order_month`,
`order_year`).

Business decisions live here, not upstream: the intermediate layer stays exhaustive and
neutral so that `int_local_bike_database__stocks` can reuse it.

**Join keys for the dashboard:**

| Key | Target | Cardinality |
| --- | --- | --- |
| `order_id` | `mrt_shipping_report` | n → 1 |
| `stock_id` | `mrt_stocks_report` | n → 1 |

The stock relation is composite, so it has to be declared as such in the BI tool.

Feeds: total revenue, order count, average basket, full price vs. discounted price —
globally, by store, by staff, and by customer; top products globally and by store.
{% enddocs %}