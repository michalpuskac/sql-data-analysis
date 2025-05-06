/*
==================== Cumulative Analysis ====================

Purpose: To calculate running totals or moving averages for key metrics.
         To track performance over time cumulatively.
         Useful for growth analysis or identifying long-term trends.

SQL Functions Used:
    - Window Functions: SUM() OVER(), AVG() OVER()
==================================================================
*/

-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
order_date,
total_sales,
-- window function
SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales
FROM
(
SELECT 
DATETRUNC(month, order_date) AS order_date,
SUM(sales_amounts) AS total_sales
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(month, order_date)
)t;


SELECT
order_date,
total_sales,
-- window function
SUM(total_sales) OVER (ORDER BY order_date) AS running_total_sales_by_year,
AVG(avg_price) OVER(ORDER BY order_date) AS moving_avg_price
FROM
(
SELECT 
DATETRUNC(year, order_date) AS order_date,
SUM(sales_amounts) AS total_sales,
AVG(price) AS avg_price
FROM gold.fact_sales
WHERE order_date IS NOT NULL
GROUP BY DATETRUNC(year, order_date)
)t;