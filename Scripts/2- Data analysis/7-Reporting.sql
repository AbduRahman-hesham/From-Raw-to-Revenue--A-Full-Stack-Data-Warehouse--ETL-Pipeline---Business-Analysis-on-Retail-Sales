/*
===============================================================================
								Customer Report
===============================================================================
Purpose:
    - This report consolidates key customer metrics and behaviors
*/
WITH customer_aggregation AS(
SELECT
	c.customer_key,
	c.customer_number,
	CONCAT(c.first_name, ' ', c.last_name) AS customer_name,
	EXTRACT(YEAR FROM age(c.birthdate)) AS age,
	COUNT(DISTINCT order_number) AS total_orders,
	SUM(sales_amount) AS total_sales,
	SUM(quantity) AS total_quantity,
	COUNT(DISTINCT product_key) AS total_products,
	MAX(order_date) AS last_order_date,
	EXTRACT(YEAR FROM age(max(order_date), min(order_date))) AS lifespan
FROM
	gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON
	c.customer_key = f.customer_key
WHERE
	order_date IS NOT NULL
	GROUP BY
		c.customer_key,
		c.customer_number,
		customer_name,
		age
		)
SELECT
	customer_key,
	customer_number,
	customer_name,
	age,
	CASE
		WHEN age < 20 THEN 'Under 20'
		WHEN age BETWEEN 20 AND 29 THEN '20-29'
		WHEN age BETWEEN 30 AND 39 THEN '30-39'
		WHEN age BETWEEN 40 AND 49 THEN '40-49'
		ELSE '50 and above'
	END AS age_group,
	CASE
		WHEN lifespan >= 5
		AND total_sales > 5000 THEN 'VIP'
		WHEN lifespan >= 5
		AND total_sales <= 5000 THEN 'Regular'
		ELSE 'New'
	END AS customer_segment,
	last_order_date,
	EXTRACT(MONTH FROM age(last_order_date)) AS recency,
	total_orders,
	total_sales,
	total_quantity,
	total_products
lifespan,
	CASE
		WHEN total_sales = 0 THEN 0
		ELSE total_sales / total_orders
	END AS avg_order_value,
	CASE
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales / lifespan
	END AS avg_monthly_spend
FROM
	customer_aggregation;
/*
===============================================================================
                                Product Report
===============================================================================
Purpose:
    - This report consolidates key product metrics and behaviors.
*/

WITH product_aggregations AS (
SELECT
	p.product_key,
	p.product_name,
	p.category,
	p.subcategory,
	p.COST,
	EXTRACT(MONTH FROM age(max(order_date), min(order_date))) AS lifespan,
	    MAX(order_date) AS last_sale_date,
	    COUNT(DISTINCT order_number) AS total_orders,
		COUNT(DISTINCT customer_key) AS total_customers,
	    SUM(sales_amount) AS total_sales,
	    SUM(quantity) AS total_quantity,
	    round(avg(sales_amount), 1)AS avg_selling_price
FROM
	gold.fact_sales f
LEFT JOIN gold.dim_products p
        ON
	f.product_key = p.product_keys
WHERE
	order_date IS NOT NULL
GROUP BY
	p.product_key,
	product_name,
	category,
	subcategory,
	COST
)
SELECT 
	product_key,
	product_name,
	category,
	subcategory,
	COST,
	last_sale_date,
	EXTRACT(MONTH FROM age(last_sale_date))AS recency_in_months,
	CASE
		WHEN total_sales > 50000 THEN 'High-Performer'
		WHEN total_sales >= 10000 THEN 'Mid-Range'
		ELSE 'Low-Performer'
	END AS product_segment,
	lifespan,
	total_orders,
	total_sales,
	total_quantity,
	total_customers,
	avg_selling_price,
	-- Average Order Revenue (AOR)
	CASE 
		WHEN total_orders = 0 THEN 0
		ELSE total_sales / total_orders
	END AS avg_order_revenue,
	-- Average Monthly Revenue
	CASE
		WHEN lifespan = 0 THEN total_sales
		ELSE total_sales / lifespan
	END AS avg_monthly_revenue
FROM
	product_aggregations ;