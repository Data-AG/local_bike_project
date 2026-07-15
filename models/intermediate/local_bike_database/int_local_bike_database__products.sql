SELECT distinct
  p.product_id,
  p.product_name,
  b.brand_id,
  b.brand_name,
  c.category_id,
  c.category_name,
  p.model_year,
  p.list_price
FROM {{ ref('stg_local_bike_database__products') }} p
LEFT JOIN {{ ref('stg_local_bike_database__brands') }} b on
  p.brand_id = b.brand_id
LEFT JOIN {{ ref('stg_local_bike_database__categories') }} c on
  p.category_id = c.category_id