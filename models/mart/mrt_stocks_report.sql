SELECT
    s.stock_id,
    s.store_id,
    s.product_id,
    s.product_name,
    s.brand_name,
    s.category_name,
    s.stock_quantity,
    s.list_price,
    ROUND(s.stock_quantity * s.list_price, 2) AS stock_value,
    ROUND(s.avg_monthly_sales, 2) AS avg_monthly_sales,
    ROUND(s.months_coverage, 2) AS months_coverage,
    s.stock_quantity = 0 AS is_stock_out,
    (s.stock_quantity > 0 AND (s.avg_monthly_sales = 0 OR s.months_coverage > 6)) AS overstock_risk
FROM {{ ref('int_local_bike_database__stocks') }} s