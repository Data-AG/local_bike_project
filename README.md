# Local Bike — Analytics Engineering

Final case study — DataBird Analytics Engineering.
Data modelling for Local Bike, a bike shop chain (Santa Cruz, Baldwin, Rowlett).

**Stack**: BigQuery · dbt · Metabase

## Analysis axes

4 axes were selected, each tied to a decision the operations team can act on:

| Axis | Question it answers | Model |
| --- | --- | --- |
| Revenue / CA / Discounts | Which stores, staff and months drive revenue? | `mrt_orders_report` |
| Average basket | Where do customers spend more per order, and why? | `mrt_orders_report` |
| Shipping | Which orders are late, and which stores are responsible? | `mrt_shipping_report` |
| Stock health | Which products are out of stock (lost sales) or sitting idle (tied-up cash)? | `mrt_stocks_report` |

## Architecture

```
sources (local_bike_database)
    │
staging/       1:1 with the source — renaming, casting, line-level computations
    │
intermediate/  joins and enrichment — neutral and exhaustive
    │
mart/          business layer exposed to Metabase
```

| Mart | Grain | Powers |
| --- | --- | --- |
| `mrt_orders_report` | 1 order item | Revenue, average basket, top products, discounts |
| `mrt_shipping_report` | 1 order | Shipping times and delays |
| `mrt_stocks_report` | 1 store × product | Stock-outs, overstock |

Join keys: `order_id` → `mrt_shipping_report`, `stock_id` (store × product surrogate key) → `mrt_stocks_report`.

## Modelling decisions

- Models are organized in staging / intermediate / mart layers (mart being the business-facing layer).
- Materialisation: `view` in staging and intermediate, `table` in the mart.
- Cancelled/blocked orders (`order_status = 3`) are excluded from `mrt_shipping_report` and `mrt_stocks_report`. They remain in `mrt_orders_report` with an explicit `order_status_label`, so the dashboard can filter them (or use `is_completed`).
- The dataset ends in 2018: stock coverage (`avg_monthly_sales`) is computed against `MAX(order_date)`, not `CURRENT_DATE()`.
- Overstock: stock on hand but never sold, or more than 6 months of coverage.

## Known limitations

- `stocks` is a snapshot of the current state, with no history: stock-outs can only be read as of today, not over time.
- `avg_monthly_sales` is computed over the full history, with no rolling window and no seasonality. A 12-month rolling average would be more actionable.
- Data no longer appears reliable from April 2018 onward.

## Tests

- `unique` + `not_null` on every primary key
- `relationships` on every foreign key
- `accepted_values` on `order_status`, `category_name`, `staff_active` and `shipping_status`
- `accepted_range` on `order_items.quantity`, `order_items.discount` and `stocks.quantity`
- singular tests : `assert_required_after_order`, `assert_shipped_after_order` and `assert_shipped_orders_have_shipped_date`

## Link to the explanatory slide deck

[Explanatory PowerPoint about the project](powerpoint/Local_Bike_ppt_v3.pptx)