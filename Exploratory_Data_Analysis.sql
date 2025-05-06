
-- E X P L O R A T O R Y   D A T A   A N A L Y S I S

/*
==================== Database Exploration ====================

Purpose: To explore the structure of the database, including the list of tables and their schemas.
         To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
================================
*/

-- Retrieve a list of all tables in the database
SELECT 
    TABLE_CATALOG, 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;

-- Retrieve all columns for a specific table (dim_customers)
SELECT 
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'dim_customers';


/*
==================== Dimension Exploration ====================

Purpose: To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================
*/

-- Retrieve a list of unique countries from which customers originate
SELECT DISTINCT 
    country 
FROM gold.dim_customers
ORDER BY country;

-- Retrieve a list of unique categories, subcategories, and products
SELECT DISTINCT 
    category, 
    subcategory, 
    product_name 
FROM gold.dim_products
ORDER BY category, subcategory, product_name;


/*
==================== DAte Exploration ====================
Purpose: To determine the temporal boundaries of key data points.
         To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================
*/

-- Determine the first and last order date and the total duration in months
SELECT 
MIN(order_date) first_order,
max(order_date) latest_order,
DATEDIFF(year ,MIN(order_date), MAX(order_date)) order_range_years
FROM gold.fact_sales;

-- Find the oldes and youngest customer
SELECT
MIN(birthdate) youngest_customer,
MAX(birthdate) olde_customer
FROM gold.dim_customers;


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


/*
==================== Magnitude Analysis ====================

Purpose: To quantify data and group results by specific dimensions.
         For understanding data distribution across categories.

SQL Functions Used:
    - Aggregate Functions: SUM(), COUNT(), AVG()
    - GROUP BY, ORDER BY
============================================================================
*/

-- Find total customers by countries
SELECT 
country,
COUNT(customer_key) AS total_customers FROM gold.dim_customers 
GROUP BY country 
ORDER BY total_customers DESC ;

-- Find total customers by gender
SELECT 'male_customers' AS gender,  COUNT(customer_key) AS customers_count  FROM gold.dim_customers where gender = 'male'
UNION ALL
SELECT 'female_customers',  COUNT(customer_key) AS customers_count  FROM gold.dim_customers where gender = 'female'
UNION ALL 
SELECT 'n/a', COUNT(customer_key) AS customers_count FROM gold.dim_customers WHERE gender !='male' and gender != 'female';

------------------------
SELECT 
gender,
COUNT(customer_key) AS total_customers FROM gold.dim_customers 
GROUP BY gender 
ORDER BY total_customers DESC ;


-- Find total products by category
SELECT 
category, 
COUNT(product_key) AS product_count
 FROM gold.dim_products 
 GROUP BY category
ORDER BY product_count DESC;

-- What is average costs in each category?
SELECT 
category,
AVG(cost) AS avg_cost 
FROM gold.dim_products 
GROUP BY category
ORDER BY avg_cost DESC;

-- What is the total revenue for each category ?
SELECT
p.category,
SUM(f.sales_amounts) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.category
ORDER BY total_revenue DESC;


-- Find total revenue generated by each customer
-- !!! big performance issue if tables are switched for select and join !!!
SELECT
c.customer_key,
c.first_name,
c.last_name,
SUM(s.sales_amounts) AS total_revenue
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c 
ON c.customer_key = s.customer_key
GROUP BY c.customer_key, c.first_name, c.last_name
ORDER BY total_revenue DESC;


-- What is the distribution of sold items accross countries ?
SELECT
c.country,
SUM(s.quantity) AS total_sold_items
FROM gold.fact_sales s
LEFT JOIN gold.dim_customers c 
ON c.customer_key = s.customer_key
GROUP BY c.country
ORDER BY total_sold_items DESC;


/*
==================== RANKING ANALYSIS ====================
Purpose: To rank items (e.g., products, customers) based on performance or other metrics.
         To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: RANK(), DENSE_RANK(), ROW_NUMBER(), TOP
    - Clauses: GROUP BY, ORDER BY
==========================================================
*/

-- Which 5 products generate the highest revenue
-- Simple Ranking
SELECT TOP 5
p.product_name,
SUM(f.sales_amounts) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;

-- Complex but Flexibly Ranking Using Window Functions
SELECT * 
FROM(
    SELECT
    p.product_name,
    SUM(f.sales_amounts) AS total_revenue,
    ROW_NUMBER() OVER (ORDER BY SUM(f.sales_amounts)DESC) AS rank_product
    FROM gold.fact_sales f
    LEFT JOIN gold.dim_products p
    ON p.product_key = f.product_key
    GROUP BY p.product_name
)t
WHERE rank_product <= 5;

-- What are the 5 worst-performing products in terms of sales
SELECT TOP 5
p.product_name,
SUM(f.sales_amounts) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
GROUP BY p.product_name
ORDER BY total_revenue;

-- FIND the top 10 customers who have generated the highest revenue
SELECT TOP 10
c.customer_key,
c.first_name,
c.last_name,
SUM(f.sales_amounts) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY c.customer_key,c.first_name,c.last_name
ORDER BY total_revenue DESC;

-- The 3 customers with the fewest orders placed
SELECT TOP 3
c.customer_key,
c.first_name,
c.last_name,
COUNT(DISTINCT(order_number)) AS nr_of_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
GROUP BY 
c.customer_key,
c.first_name,
c.last_name
ORDER BY nr_of_orders;