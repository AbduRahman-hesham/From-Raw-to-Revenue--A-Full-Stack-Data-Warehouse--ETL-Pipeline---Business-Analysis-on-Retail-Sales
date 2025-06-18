--create and connect the dimension table of customer
CREATE VIEW gold.dim_customers AS
SELECT
	ROW_NUMBER() OVER (
ORDER BY
	cst_id) AS customer_key,
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	la.cntry AS country,
	ci.cst_marital_status AS marital_status,
	CASE
		WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
		ELSE COALESCE(ca.gen, 'n/a')
	END AS gender,
	ca.bdate AS birthdate,
	ci.cst_create_date AS create_date
FROM
	silver.crm_cust_info ci
LEFT JOIN silver.erp_loc_a101 la
    ON
	ci.cst_key = la.cid
LEFT JOIN silver.erp_cust_az12 ca
    ON
	ci.cst_key = ca.cid;
--create and connect the dimension table of product
CREATE VIEW gold.dim_products AS
SELECT
	ROW_NUMBER() OVER ( ORDER BY pn.prd_start_dt) AS product_key,
	pn.prd_id AS product_id,
	pn.prd_key AS product_number,
	pn.product_key AS product_keys,
	pn.prd_nm AS product_name,
	pc.cat AS category,
	pc.subcat AS subcategory,
	pc.maintenance AS maintenance,
	pn.prd_cost AS COST,
	pn.prd_line AS product_line,
	pn.prd_start_dt AS start_date
FROM
	silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON
	  pn.prd_Key = pc.id;
-- BY this condidtion we took the updated prices
--create and connect the fact table of sales

CREATE VIEW gold.fact_sales AS
SELECT
	sd.sls_ord_num AS order_number,
	pr.product_key AS product_key,
	cu.cst_id AS customer_key,
	sd.sls_order_dt AS order_date,
	sd.sls_ship_dt AS shipping_date,
	sd.sls_due_dt AS due_date,
	sd.sls_sales AS sales_amount,
	sd.sls_quantity AS quantity,
	sd.sls_price AS price
FROM
	silver.crm_sales_details sd
LEFT JOIN silver.crm_cust_info cu
    ON
	sd.sls_cust_id = cu.cst_id
LEFT JOIN silver.crm_prd_info pr
    ON
	sd.sls_prd_key = pr.product_key
;
