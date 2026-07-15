{% docs int_local_bike_database__orders %}
## int_local_bike_database__orders

Order header table, grain: 1 row = 1 order (`order_id`).

Joins `stg_local_bike_database__orders` with `stg_local_bike_database__customers`,`stg_local_bike_database__stores` and `stg_local_bike_database__staffs` to expose
readable labels (`customer_name`, `customer_city`, `customer_state`, `store_name`,`staff_name`).
{% enddocs %}