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