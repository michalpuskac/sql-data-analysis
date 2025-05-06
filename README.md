# Exploratory Data Analysis And Advance Data Analytics Project
## 📖 Project Overview

This project demonstrates a comprehensive data analysis workflow using SQL, starting from initial data exploration and culminating in the creation of advanced analytical reports. It showcases the application of various SQL techniques to extract meaningful business insights from a structured data warehouse layer.

#### This project builds upon data prepared in a separate [SQL Data Warehouse Project](https://github.com/michalpuskac/sql-data-warehouse-project.git).

## 🎯 Objectives

* Explore and understand the structure and content of the data warehouse's Gold layer.
* Perform Exploratory Data Analysis (EDA) using basic and intermediate SQL to uncover initial patterns and distributions.
* Apply Advanced SQL techniques (Window Functions, CTEs, Subqueries) to conduct deeper analysis, including time-series, performance, and segmentation analysis.
* Develop comprehensive, business-ready analytical reports encapsulated in SQL Views.
* Demonstrate proficiency in SQL for data analysis and transformation in a portfolio context.

## Context & Data Source

The analysis in this project is performed on data prepared and modeled in a separate Data Warehousing project. The source data resides in the **Gold Layer** of that warehouse, structured as a Star Schema :

<div align="center">
  <img src="https://github.com/michalpuskac/sql-data-warehouse-project/blob/main/docs/sales_data_mart.png" width="85%"/> 
</div>

For details on how the data was ingested, cleaned, transformed (using a Medallion Architecture approach), and modeled, please refer to the Data Warehouse project repository: **[SQL Data Warehouse Project](https://github.com/michalpuskac/sql-data-warehouse-project.git)**

## 🛠️ Tools & Technologies

* **Database:** SQL Server
* **Language:** T-SQL
* **IDE:** Azure Data Studio
* **Version Control:** Git & GitHub

## 📊 Analysis Performed

This project is divided into two main analytical phases:

### Phase 1: Exploratory Data Analysis (EDA)

*Goal: Gain a fundamental understanding of the data's characteristics, scope, and quality.*

* **Database Exploration:** Used system tables (`information_schema`) to understand table structures, columns, and data types.
* **Dimension Exploration:** Identified unique values within key dimensions (e.g., Country, Product Category, Subcategory) using `DISTINCT` to understand categorical variety.
* **Date Exploration:** Determined the time span of the data (first/last order dates) using `MIN()`, `MAX()`, and calculated ranges using `DATEDIFF()`.
* **Measure Exploration:** Calculated key aggregate metrics (total sales, total quantity, average price, total orders/customers) using `SUM()`, `AVG()`, `COUNT()`, `COUNT(DISTINCT)` to get high-level business figures.
* **Magnitude Analysis:** Compared measures across different dimension categories (e.g., Sales by Country, Customers by Gender, Products by Category) using `GROUP BY` and `ORDER BY` to identify high/low contributors.
* **Ranking Analysis:** Identified top/bottom performers (e.g., Top 5 Products by Revenue, Bottom 3 Customers by Orders) using `TOP N` with `ORDER BY`, and demonstrated the concept using `ROW_NUMBER()` window function with subqueries.

### Phase 2: Advanced Analytics & Reporting

*Goal: Derive deeper insights, track performance over time, segment data meaningfully, and create reusable reporting structures.*

* **Changes Over Time:** Analyzed trends and seasonality in sales and customer metrics using date functions (`YEAR`, `MONTH`, `DATE_TRUNC`) with `GROUP BY`.
* **Cumulative Analysis:** Calculated running totals and moving averages (e.g., cumulative sales) using aggregate **Window Functions** (`SUM() OVER`, `AVG() OVER`) to track progression.
* **Performance Analysis:** Compared yearly product sales against their average and previous year's sales (Year-over-Year) using **Window Functions** (`AVG() OVER`, `LAG() OVER`) and conditional logic (`CASE WHEN`).
* **Part-to-Whole Analysis:** Determined the percentage contribution of categories (e.g., Product Category %) to the overall total using **Window Functions** (`SUM() OVER ()`).
* **Data Segmentation:** Created meaningful customer segments (VIP, Regular, New) based on calculated lifespan (`DATEDIFF`) and total spending, and product segments based on cost/revenue ranges using complex `CASE WHEN` logic, often leveraging **CTEs** or subqueries.
* **Report Building:** Developed two comprehensive analytical views (`gold.report_customer`, `gold.report_product`) using **CTEs** and combining multiple analytical techniques (aggregations, segmentation, KPIs like Recency, AOV, Monthly Spend) into a single query structure (`CREATE VIEW`).

 <img src="https://github.com/michalpuskac/sql-data-analysis/blob/main/report_customers.png"/> 
*Final view output of customer report.*
 <br>
 <br>
  <img src="https://github.com/michalpuskac/sql-data-analysis/blob/main/report_products.png"/> 
*Final view output of products report.*

## ✨ Key Findings & Insights (Summary)

* **Sales Trends:** Identified peak sales year (2013) and seasonality patterns (Dec high, Feb low).
* **Product Dominance:** 'Bikes' category drives the vast majority (96%) of revenue, indicating potential business concentration risk.

  ```
  | Category    | Total Revenue | Percentage |
  | :---------- | :------------ | ---------: |
  | Bikes       |  $28,316,272  |   96.46%   |
  | Components  |     $700,262  |    2.39%   |
  | Accessories |     $339,716  |    1.16%   |
  ```
  *Illustrative data showing Bike dominance.*

* **Customer Base:** The largest customer group is 'New', but significant 'Regular' and 'VIP' segments exist based on spending and tenure.

  ```
  | Customer Segment | Count |
  | :--------------- | ----: |
  | New              | 14631 |
  | Regular          |  2198 |
  | VIP              |  1655 |
  ```
  *Distribution of customers based on segmentation logic.*

* **Performance Metrics:** Developed KPIs like Recency, Average Order Value, and Monthly Spend per customer/product to enable deeper performance evaluation.


## 🚀 Skills Demonstrated

* **Advanced SQL Proficiency (T-SQL):** Complex querying, including Window Functions, CTEs, Subqueries, Aggregate Functions, Joins, Date Functions, Conditional Logic (`CASE WHEN`).
* **Data Exploration & Profiling:** Techniques to systematically understand new datasets.
* **Analytical Techniques:** Implementation of Time-Series, Performance, Contribution, and Segmentation analysis using SQL.
* **Data Interpretation:** Translating business questions into SQL queries and interpreting the results.
* **Reporting Logic:** Designing and implementing reusable analytical views in a database.
* **Code Organization:** Structuring SQL scripts logically for clarity and maintainability.
* **(Implied Skill):** Understanding of Data Warehousing concepts (by correctly using the Gold Layer Star Schema).

## 🗂 Repository Structure

```
sql-data-analysis-project/
├── 01_exploratory_data_analysis/        # Scripts from the EDA project
│   ├── 01_database_exploration.sql
│   ├── 02_dimension_exploration.sql
│   ├── 03_date_exploration.sql
│   ├── 04_measure_exploration.sql
│   ├── 05_magnitude_analysis.sql
│   ├── 06_ranking_analysis.sql
│   └── utils_key_metrics_summary.sql    # The script combining key metrics
│
├── 02_advanced_analytics/               # Scripts from the Advanced Analytics project
│   ├── 01_changes_over_time.sql
│   ├── 02_cumulative_analysis.sql
│   ├── 03_performance_analysis.sql
│   ├── 04_part_to_whole_analysis.sql
│   ├── 05_data_segmentation.sql
│
└── 03_final_reports/                    # Scripts to CREATE the final report VIEWS
│    ├── report_customer_view.sql
│    └── report_product_view.sql
│
├── docs/                                # contain summary findings
│   └── key_findings_summary.md          
│
├── README.md                            # Project overview (see content below)
├── LICENSE
└── .gitignore
```

## ⚙️ Usage

1.  **Prerequisite:** Ensure you have the database set up and populated from the [SQL Data Warehouse Project](https://github.com/michalpuskac/sql-data-warehouse-project.git).
2.  **Connection:** Connect to the SQL Server database containing the `DataWarehouseAnalytics` database (or your chosen name).
3.  **Execution:** The SQL scripts can be run sequentially within their respective folders (`01_...` then `02_...` then `03_...`) against the Gold Layer tables (`gold.fact_sales`, `gold.dim_customers`, `gold.dim_products`) to replicate the analysis and create the final report views.

## 📄 License
This project is licensed under the MIT License. See the [LICENSE](https://github.com/michalpuskac/sql-data-analysis/blob/main/LICENSE) file for details.


## 👨‍💻 Author - Michal Puškáč
This project is part of my portfolio, showcasing skills and concepts I learned. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!


<div align="left">
   <a href="https://www.linkedin.com/in/michal-pu%C5%A1k%C3%A1%C4%8D-94b925179/">
    <img src="https://img.shields.io/badge/LinkedIn-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white" alt="LinkedIn Badge"/>
  </a>
  <a href="https://github.com/michalpuskac">
    <img src="https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub Badge"/>
  </a>
</div>