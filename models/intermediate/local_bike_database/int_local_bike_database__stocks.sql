WITH sales_quantity AS (
    SELECT
        store_id,
        product_id,
        SUM(quantity) AS total_quantity_sold,
        DATE_DIFF(
            (SELECT MAX(order_date) FROM {{ ref('int_local_bike_database__order_items') }}),
            MIN(order_date),
            MONTH
        ) + 1 AS nb_months_first_sale
    FROM {{ ref('int_local_bike_database__order_items') }}
    GROUP BY store_id, product_id
),
stock_sales AS (
    SELECT
        s.stock_id,
        s.store_id,
        s.product_id,
        s.quantity AS stock_quantity,
        COALESCE(SAFE_DIVIDE(sq.total_quantity_sold, sq.nb_months_first_sale), 0) AS avg_monthly_sales
    FROM {{ ref('stg_local_bike_database__stocks') }} s
    LEFT JOIN sales_quantity sq
        ON s.store_id = sq.store_id AND s.product_id = sq.product_id
)

SELECT
    s.stock_id,
    s.store_id,
    s.product_id,
    p.product_name,
    p.brand_name,
    p.category_name,
    s.stock_quantity,
    s.avg_monthly_sales,
    SAFE_DIVIDE(s.stock_quantity, s.avg_monthly_sales) AS months_coverage
FROM stock_sales s
LEFT JOIN {{ ref('int_local_bike_database__products') }} p ON
    s.product_id = p.product_id