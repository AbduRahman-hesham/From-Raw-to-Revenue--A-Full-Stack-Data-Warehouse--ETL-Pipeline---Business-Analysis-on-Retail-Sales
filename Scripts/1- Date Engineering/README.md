# 🛠️ ETL & Data Warehouse Process

## 🌐 Overview

This phase of the project focuses on implementing a robust **ETL pipeline** using the **Bronze-Silver-Gold** architecture—an industry-standard layered approach in modern data warehousing. The purpose is to ensure that data flows in a clean, consistent, and reliable way from raw sources to business-ready insights.

---

## 🧱 ETL Architecture: Bronze → Silver → Gold

### 🥉 Bronze Layer – *Raw Data Ingestion*

- **Purpose**: Serve as a landing zone for raw data exactly as it was received.
- **Actions Taken**:
  - Created **DDL statements** for 6 tables to match the structure of the source CSVs.
  - Loaded raw data **without transformation**, preserving original formatting for traceability.
  - Tables included sales, products (from 2 files), and customers (from 3 files).

> 💡 *Tip: Always keep the raw data intact. This layer is valuable for debugging and audits.*

---

### 🥈 Silver Layer – *Data Cleaning & Transformation*

- **Purpose**: Apply business rules, data cleaning, and schema unification.
- **Actions Taken**:
  - **Handled Nulls**: Replaced, dropped, or flagged incomplete records.
  - **Removed Duplicates**: Ensured record uniqueness using composite keys where needed.
  - **Text Cleaning**:
    - Standardized casing (e.g., all product names to title case).
    - Trimmed whitespace and removed special characters.
  - **Key Splitting**:
    - Created clear **Primary and Foreign Keys** to model relationships properly.
    - Unified customer data from three CSVs and ensured referential integrity.
  - **Date Standardization**:
    - Converted date formats to SQL-compatible timestamps.
    - Extracted year, month, and day for easier analysis.
  - **Naming Convention**:
    - Used consistent snake_case or camelCase (based on SQL standards) for column names.

> 🧹 *This layer turns messy, scattered inputs into clean, analysis-ready datasets.*

---

### 🥇 Gold Layer – *Business-Ready Views*

- **Purpose**: Create unified, optimized, and easily queryable data models.
- **Actions Taken**:
  - Built SQL **views** that join cleaned tables into meaningful datasets.
  - Integrated all entities (sales, products, customers) through primary-foreign key relationships.
  - Designed the views to be:
    - Query-friendly
    - Human-readable
    - Business-aligned

> 🧠 *Gold layer is where business intelligence thrives—data is now ready for exploration and insights.*

---

## 🔁 Summary: Data Flow Diagram

```text
            Raw CSV Files
                 ↓
            [Bronze Layer]
         Load into Raw Tables
                 ↓
            [Silver Layer]
     Clean, Standardize, Transform
                 ↓
            [Gold Layer]
      Create Views for Analytics
