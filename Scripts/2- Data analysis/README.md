# 📈 Exploratory Data Analysis & Business Intelligence

## 🎯 Goal of This Phase

The purpose of this phase is to transform cleaned data into **business insights** that support strategic decision-making. Using SQL, I conducted an extensive **exploratory data analysis (EDA)** and created **reporting views** for customers and products that highlight key behaviors, trends, and performance metrics.

---

## 🔍 Phase 1: Exploratory Data Analysis (EDA)

This stage focused on **exploring the core metrics** of the business to understand the current state of sales, customer activity, and product performance.

### ✅ Business Questions Answered:

1. **Find the Total Sales**  
2. **Determine How Many Items Were Sold**
3. **Calculate the Average Selling Price**
4. **Count the Total Number of Orders**
5. **Find the Total Number of Products**
6. **Find the Total Number of Customers**
7. **Count Customers Who Placed an Order**
8. **Top 5 Products Generating the Highest Revenue**
9. **Bottom 5 Products in Terms of Sales**
10. **Top 10 Customers by Revenue**
11. **3 Customers with the Fewest Orders**
12. **Flexible Product Ranking Using SQL Window Functions**

> 📊 These questions helped build a baseline understanding of the dataset and revealed which products, customers, and behaviors drive revenue.

---

## 📊 Phase 2: Analytical Segmentation

Moving beyond basic statistics, I performed **segmentation and time-based analysis** to uncover trends and patterns.

### 🔍 Advanced Analyses Performed:

1. **Product Cost Segmentation**:
   - Grouped products into cost-based ranges
   - Counted products in each price segment

2. **Year-over-Year Product Performance**:
   - Compared annual sales per product
   - Benchmarked against average performance
   - Evaluated change compared to previous year

3. **Customer Spending Segmentation**:
   - Clustered customers into:
     - **High Spenders (VIP)**
     - **Mid Spenders**
     - **Low Spenders**
   - Useful for personalized marketing and promotions

> 🧠 These analyses help stakeholders make **data-driven decisions** on pricing, inventory, customer targeting, and retention strategies.

---

## 📋 Phase 3: Analytical Reports (Views)

To make the data accessible for non-technical users and business analysts, I created two **analytical views** that consolidate key performance indicators.

### 👤 Customer Report View

**Objective**: Provide a comprehensive profile of each customer.

**Highlights**:
- Captures demographics and transaction history
- Segments by:
  - **Customer Type**: VIP, Regular, New
  - **Age Group**
- Aggregates metrics:
  - Total orders
  - Total sales
  - Total quantity purchased
  - Number of distinct products purchased
  - Customer lifespan (in months)
- Calculates KPIs:
  - **Recency**: Months since last order
  - **Average Order Value (AOV)**
  - **Average Monthly Spend**

> 📈 This report is designed to support retention strategies, loyalty programs, and customer lifetime value (CLV) estimation.

---

### 📦 Product Report View

**Objective**: Summarize performance of each product.

**Highlights**:
- Includes product metadata: name, category, subcategory, and cost
- Segments products by:
  - Revenue performance (High, Mid, Low)
- Aggregates metrics:
  - Total orders
  - Total revenue
  - Quantity sold
  - Number of unique customers
  - Product lifespan (months)
- KPIs:
  - **Recency**: Months since last sale
  - **Average Order Revenue (AOR)**
  - **Average Monthly Revenue**

> 📦 This report helps guide inventory optimization, product bundling, and marketing efforts.

---

## 🧠 Business Value Delivered

- Identified **top-performing products** and **key customer segments**
- Supported **strategic decision-making** with real-world KPIs
- Created **ready-to-query reports** for business teams and dashboards
- Demonstrated full analytical flow from **data discovery to insight delivery**

---

## 🧰 Tools & Techniques

- **SQL**: All analysis and views were developed using advanced SQL techniques.
- **Window Functions**: For flexible ranking and time-based calculations.
- **PostgreSQL + DBeaver**: Used for query development, testing, and view creation.

---


