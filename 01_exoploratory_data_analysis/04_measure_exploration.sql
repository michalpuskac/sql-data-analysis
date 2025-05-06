/*
==================== Measures Exploration (Key Metrics) ====================
Purpose: To calculate aggregated metrics (e.g., totals, averages) for quick insights.
         To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), AVG()
============================================================================
*/

 -- Find to Total Sales
SELECT 
sum(sales_amounts) AS total_sales
FROM gold.fact_sales;

-- Find how many items are sold
SELECT 
COUNT(product_key) AS items_sold
FROM gold.fact_sales;

-- Find the average selling price
SELECT 
AVG(price) AS avg_price
FROM gold.fact_sales;

-- Find the Total number of Orders
SELECT COUNT(order_number) as total_orders FROM gold.fact_sales;
SELECT COUNT(DISTINCT(order_number)) as total_orders FROM gold.fact_sales;

-- Find the total number of Products
SELECT 
COUNT(product_key) as total_orders
FROM gold.dim_products;

-- Find the total number of customers
SELECT 
COUNT(customer_key) as total_orders
FROM gold.dim_customers;

-- Find the total number of customers that has placed an order
SELECT 
COUNT(DISTINCT(customer_key)) AS total_customers 
FROM gold.fact_sales

-- Generate a Report that show all key metrics of the bussiness
SELECT
'Total Sales' as measure_name, SUM(sales_amounts) AS  measure_value  FROM gold.fact_sales
UNION ALL
SELECT 'Total Quantity' AS measure_name, SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr.Orders', COUNT(DISTINCT(order_number)) as total_orders FROM gold.fact_sales
UNION ALL
SELECT 'Total Nr.Products',COUNT(product_key) as total_orders FROM gold.dim_products
UNION ALL 
SELECT 'Total Nr. Cursomers', COUNT(customer_key) as total_orders FROM gold.dim_customers;