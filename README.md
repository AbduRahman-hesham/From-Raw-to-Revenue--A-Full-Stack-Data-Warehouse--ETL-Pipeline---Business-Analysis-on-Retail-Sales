# 🧠 Sales Data Warehouse Project

## 📊 Project Overview

This project showcases the end-to-end implementation of a **data warehouse solution** using sales data from CSV files. The goal is to transform raw data into valuable business insights by following industry-standard **ETL (Extract, Transform, Load)** practices and leveraging a **Bronze-Silver-Gold** architecture. The final result provides **business intelligence (BI) reports** that support strategic decision-making in areas like customer segmentation, product performance, and sales optimization.

## 🎯 Business Objective

The aim of this project is to:
- Centralize fragmented **sales** and **customer** data into a **structured, queryable data warehouse**.
- Clean and transform raw data to **create valuable business insights**.
- Support decision-making by answering key business questions like:
  - Which products are top-performers?
  - Which customers contribute the most to revenue?
  - How can customer behaviors be segmented for personalized marketing?

By organizing and structuring the data, this project allows for easy exploration, analysis, and reporting, ultimately aiding business stakeholders in **driving strategic actions**.

## 🧱 Dataset Description

The dataset includes:
- **Sales Data**: Transaction-level sales data including quantities, prices, dates, and products sold.
- **Product Data**: Two product-related CSVs with overlapping but distinct attributes.
- **Customer Data**: Split across **three different files**, requiring careful merging and cleaning to unify customer profiles.

## 🔧 Technical Workflow

The technical implementation followed three key phases:

### 1. Data Extraction 
- Loaded data from multiple CSV files using PostgreSQL/DBeaver.
- Inspected and identified inconsistencies, nulls, and structural issues.

### 2. Data Transformation
- Standardized and cleaned the data.
- Merged fragmented product and customer information.
- Applied meaningful data types, renamed fields, and created relational integrity.
- Built SQL **views** to model cleaned and ready-to-query datasets.

### 3. Analysis and Exploration
- Performed **exploratory data analysis (EDA)** to understand trends and anomalies.
- Designed and executed **advanced SQL queries** to answer real-world business questions, such as:
  - Which customers generate the highest revenue?
  - What products are top-performers by region or time period?
  - Are there purchase patterns that suggest loyalty or churn?
  
  ## 📋 Reporting Views

To allow non-technical stakeholders to easily consume the data, I created two **key reports** through SQL views:

1. **Customer Report**:
   - Segments customers into categories (VIP, Regular, New).
   - Aggregates metrics such as total orders, total sales, and average order value.
   - Calculates KPIs like **recency** (months since last order) and **monthly spend**.

2. **Product Report**:
   - Segments products by performance: **High, Mid, Low**.
   - Aggregates metrics like total sales, quantity sold, and total unique customers.
   - Provides KPIs such as **average order revenue** and **recency** (months since last sale).

## 🧰 Tools & Technologies (Skills Demonstrated)

### 🗄️ SQL & Data Warehousing
- Designed and implemented a **multi-layer data warehouse** using the **Bronze → Silver → Gold** architecture.
- Wrote advanced **DDL & DML** SQL scripts to define schemas, load data, and perform transformations.
- Applied **window functions**, **joins**, **aggregations**, and **CTEs** to extract insights from large relational datasets.
- Ensured data **integrity and normalization** through foreign key relationships and key splitting.

### 📊 Data Analysis & Business Intelligence
- Conducted **Exploratory Data Analysis (EDA)** to uncover patterns, trends, and outliers in sales, customer, and product data.
- Created **segmentation strategies** (e.g., customer types, product tiers) based on behavior and KPIs.
- Built **analytical views** that aggregate business metrics like sales totals, order frequency, customer lifetime value, and product performance.

### 🧹 Data Cleaning & Transformation
- Performed robust **data cleaning**: handled missing values, duplicates, inconsistent formats, and text normalization.
- Unified data from **multiple sources** (e.g., three separate customer CSVs) into a coherent model.
- Standardized **date formats**, column naming, and categorical values for consistency and analysis-readiness.

> ✅ This project showcases end-to-end skills in **data engineering**, **SQL analytics**, and **business reporting**, bridging the gap between raw data and decision-ready insights.


