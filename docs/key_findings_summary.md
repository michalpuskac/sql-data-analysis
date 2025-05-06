# Key Findings Summary

This document summarizes the key business insights discovered through SQL-based Exploratory Data Analysis (EDA) and Advanced Analytics performed on the Gold Layer data (FactSales, DimCustomers, DimProducts) of the data warehouse.

## Sales Performance & Trends

* **Revenue & Volume:** The business generated approximately $29 Million in total revenue from ~60,000 items sold across ~27,000 distinct orders. (EDA - Measure Exploration)
* **Time Span:** The available sales data covers 4 years, from December 2010 to January 2014. (EDA - Date Exploration)
* **Peak & Decline:** Sales performance peaked in 2013 before experiencing a significant decline in 2014 (based on the data range ending Jan 2014). (Advanced - Changes Over Time)
* **Seasonality:** Sales exhibit strong seasonality, with December being the highest performing month and February the lowest. (Advanced - Changes Over Time)
* **Progression:** Cumulative sales analysis showed the overall growth trajectory of the business revenue over the years. (Advanced - Cumulative Analysis)

## Product Insights

* **Dominant Category:** The 'Bikes' category is the primary revenue driver, accounting for **96% of total sales**. 'Accessories' and 'Clothing' are minor contributors financially. (EDA - Magnitude Analysis & Advanced - Part-to-Whole)
    * *Implication:* Potential business risk due to over-reliance on a single category.
* **Product Count:** The 'Components' category has the highest number of distinct products, followed by 'Bikes'. (EDA - Magnitude Analysis)
* **Pricing:** Bikes have a significantly higher average cost (~$900) compared to accessories (~$13). The overall average selling price across items is ~$486. (EDA - Magnitude & Measure Exploration)
* **Top/Bottom Performers:** Specific high-revenue generating products (all bikes) and low-revenue products were identified using ranking analysis. (EDA - Ranking Analysis)
* **Product Segmentation:** Products were segmented into High, Medium, and Low performers based on their total revenue generation. (Advanced - Data Segmentation / Product Report)

## Customer Insights

* **Customer Base:** The system contains ~18,500 registered customers, all of whom have placed at least one order within the analyzed period. (EDA - Measure Exploration)
* **Geographic Distribution:** Customers are spread across 6 countries, with the highest concentration in the United States, followed by Australia and the UK. (EDA - Dimension & Magnitude Analysis)
* **Demographics:** The customer base is nearly evenly split between Males and Females. The age range of customers is roughly 39 to 109 years (based on data available at the time of analysis). (EDA - Magnitude & Date Exploration)
* **Top Spenders:** A small number of customers contribute significantly to revenue (identified via ranking). (EDA - Ranking Analysis)
* **Customer Segmentation:** Customers were segmented based on their purchasing behavior (lifespan & total spending) into:
    * **New:** Largest group (< 12 months history).
    * **Regular:** Significant group (>= 12 months, lower spending).
    * **VIP:** Significant group (>= 12 months, high spending > $5k). (Advanced - Data Segmentation)
* **Key Metrics:** KPIs like Recency (months since last order), Average Order Value (AOV), and Average Monthly Spend were calculated per customer. (Advanced - Customer Report)

## Data Quality Notes

* Some product records (7) were found with `NULL` category values during EDA.
* Some customer records (337) had `NULL` country information.
* Initial order counts were inflated due to multiple items per order; using `COUNT(DISTINCT OrderNumber)` provided the accurate count of unique orders. (EDA - Measure Exploration)