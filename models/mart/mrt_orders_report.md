{% docs mrt_shipping_report %}
## mrt_shipping_report

Shipping performance table, grain: 1 row = 1 order (`order_id`).

Derives from `int_local_bike_database__orders` only, with no join. Excludes cancelled/blocked orders (`order_status = 3`): shipping management is irrelevant for them. Scope therefore differs from `mrt_orders_report`, which keeps all statuses for revenue and cancellation analysis.

Computes `days_to_ship`, `days_late` (negative if shipped early) — both NULL when `shipped_date` is NULL — and `shipping_status` ('To ship', 'Late', 'On time').

Late rate must be computed on shipped orders only: 'Late' / ('Late' + 'On time').

**Join key for the dashboard:**

| Key | Source | Cardinality |
| --- | --- | --- |
| `order_id` | `mrt_orders_report` | 1 → n |

Feeds: late rate by store and by month; average days to ship; orders pending shipment ('To ship' backlog).
{% enddocs %}