{% docs int_local_bike_database__products %}
## int_local_bike_database__products

Product header dimension, grain: 1 row = 1 product (`product_id`).

Joins `stg_local_bike_database__products` with `stg_local_bike_database__brands` and `stg_local_bike_database__categories` to expose readable labels (`brand_name`, `category_name`).
{% enddocs %}