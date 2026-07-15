{% docs mrt_shipping_report %}
## mrt_shipping_report

Shipping performance table, grain: 1 row = 1 order (`order_id`).

Derives from `int_local_bike_database__orders` only, with no join. Excludes cancelled orders (`order_status = 3`): shipping management is irrelevant for them. Scope therefore differs from `mrt_orders_report`, which keeps all statuses for revenue and cancellation analysis.

Computes `days_to_ship`, `days_late` (negative if shipped early) — both NULL when `shipped_date` is NULL — and `shipping_status` ('To ship', 'Late', 'On time').

Late rate must be computed on shipped orders only: 'Late' / ('Late' + 'On time').
{% enddocs %}