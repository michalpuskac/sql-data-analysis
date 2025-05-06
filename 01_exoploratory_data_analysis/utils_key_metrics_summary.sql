-- ====================================================================
-- Key Metrics Summary Report
-- ====================================================================
-- Description: This query aggregates key business metrics from
--              different tables into a single summary view using
--              UNION ALL. It provides a high-level overview of
--              the business performance.
-- Source Tables: gold.fact_sales, gold.dim_products, gold.dim_customers
-- Granularity: Overall Business
-- ====================================================================

-- Total Sales Revenue
SELECT
'Total Sales' as measure_name,
SUM(sales_amounts) AS  measure_value
FROM gold.fact_sales

UNION ALL

-- Total Quantity Sold
SELECT 
'Total Quantity' AS measure_name,
SUM(quantity)
FROM gold.fact_sales

UNION ALL

-- Total Distinct Orders
SELECT
'Total Nr.Orders',
COUNT(DISTINCT(order_number)) as total_orders
FROM gold.fact_sales

UNION ALL

-- Total Distinct Products Available
SELECT
'Total Nr.Products',
COUNT(product_key) as total_orders
FROM gold.dim_products

UNION ALL

-- Total Registered Customers
SELECT 
'Total Nr.Cursomers',
COUNT(customer_key) as total_orders
FROM gold.dim_customers;