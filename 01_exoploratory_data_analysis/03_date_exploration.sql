/*
==================== Date Exploration ====================
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