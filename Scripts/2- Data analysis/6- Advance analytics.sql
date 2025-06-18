/*Segment products into cost ranges and 
count how many products fall into each segment*/
WITH product_segments AS (
SELECT
	product_key,
	product_name,
	COST,
	CASE
		WHEN COST < 100 THEN 'Below 100'
		WHEN COST BETWEEN 100 AND 500 THEN '100-500'
		WHEN COST BETWEEN 500 AND 1000 THEN '500-1000'
		ELSE 'Above 1000'
	END AS cost_range
FROM
	gold.dim_products
)
SELECT
	cost_range,
	COUNT(product_key) AS total_products
FROM
	product_segments
GROUP BY
	cost_range
ORDER BY
	total_products DESC;
-- Analyse sales performance over time
SELECT
	to_char(date_trunc('MONTH', order_date), 'yyyy-mm-dd' )AS MONTH,
	sum(sales_amount),
	count(DISTINCT customer_key),
	count(quantity)
FROM
	gold.fact_sales
GROUP BY
	MONTH
ORDER BY
	MONTH;
-- Calculate the total sales per month 
-- and the running total of sales over time 
SELECT
	MONTH,
	total_sales,
	round((total_sales)/ SUM(total_sales) OVER ()* 100, 2) AS percentage,
	SUM(total_sales) OVER (
	ORDER BY MONTH) AS running_total_sales,
	round(AVG(avg_price) OVER (ORDER BY MONTH) , 2)AS moving_average_price
FROM
	(
	SELECT
		to_char(date_trunc('month', order_date), 'yyyy-mm-dd') AS MONTH,
		SUM(sales_amount) AS total_sales,
		AVG(price) AS avg_price
	FROM
		gold.fact_sales
	WHERE
		order_date IS NOT NULL
	GROUP BY
		MONTH
);
--------------------
/*Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales*/
WITH yearly_product_sales AS (
SELECT
	EXTRACT(MONTH FROM f.order_date) AS order_month,
	p.product_name,
	SUM(f.sales_amount) AS current_sales
FROM
	gold.fact_sales f
LEFT JOIN gold.dim_products p
        ON
	f.product_key = p.product_keys
WHERE
	f.order_date IS NOT NULL
GROUP BY
	order_month,
	p.product_name
)
SELECT
	order_month,
	product_name,
	current_sales,
	AVG(current_sales) OVER (PARTITION BY product_name) AS avg_sales,
	current_sales - AVG(current_sales) OVER (PARTITION BY product_name) AS diff_avg,
	CASE
		WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
		WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
		ELSE 'Avg'
	END AS avg_change,
	-- Year-over-Year Analysis
    LAG(current_sales) OVER (PARTITION BY product_name
ORDER BY
	order_month) AS py_sales,
	current_sales - LAG(current_sales) OVER (PARTITION BY product_name
ORDER BY
	order_month) AS diff_py,
	CASE
		WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name
	ORDER BY
		order_month) > 0 THEN 'Increase'
		WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name
	ORDER BY
		order_month) < 0 THEN 'Decrease'
		ELSE 'No Change'
	END AS py_change
FROM
	yearly_product_sales
ORDER BY
	product_name,
	order_month;

--Group customers into three segments based on their spending behavior

WITH customer_spending AS (
SELECT
	c.customer_key,
	SUM(f.sales_amount) AS total_spending,
	MIN(order_date) AS first_order,
	MAX(order_date) AS last_order,
	EXTRACT(MONTH FROM AGE(max(order_date), min(order_date))) AS lifespan
FROM
	gold.fact_sales f
LEFT JOIN gold.dim_customers c
        ON
	f.customer_key = c.customer_key
GROUP BY
	c.customer_key
)
SELECT
	customer_segment,
	COUNT(customer_key) AS total_customers
FROM
	(
	SELECT
		customer_key,
		CASE
			WHEN lifespan >= 5
				AND total_spending > 5000 THEN 'VIP'
				WHEN lifespan >= 5
				AND total_spending <= 5000 THEN 'Regular'
				ELSE 'New'
			END AS customer_segment
		FROM
			customer_spending
) AS segmented_customers
GROUP BY
	customer_segment
ORDER BY
	total_customers DESC;