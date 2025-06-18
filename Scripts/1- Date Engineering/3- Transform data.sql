--Transform crm customer info data from bronze to silver
INSERT
	INTO
	silver.crm_cust_info(
			cst_id, 
			cst_key, 
			cst_firstname, 
			cst_lastname, 
			cst_marital_status, 
			cst_gndr,
			cst_create_date)

SELECT 
		cst_id,
	    cst_key, 
		trim(cst_firstname) AS first_name,
		trim(cst_lastname) AS last_name,
		CASE
		WHEN upper(trim(cst_marital_status)) = 'S' THEN 'Single'
		WHEN cst_marital_status = 'M' THEN 'Married'
		ELSE 'N/A'
	END AS matiral_status,
		CASE
		WHEN upper(trim(cst_gndr)) = 'M' THEN 'Male'
		WHEN cst_gndr = 'F' THEN 'Female'
		ELSE 'N/A'
	END AS cst_gndr,
		cst_create_date
FROM
	(
	SELECT
		*,
		ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date DESC) AS ranking
	FROM
		bronze.crm_cust_info cci 
)
WHERE
	ranking = 1
----Transform crm prodcut info data from bronze to silver

INSERT
	INTO
	silver.crm_prd_info (
 	prd_id ,
	prd_key,
	product_key,
	prd_nm ,
	prd_cost,
	prd_line ,
	prd_start_dt,
	prd_end_dt
)
SELECT
	prd_id,
	REPLACE(substring(prd_key, 1, 5), '-', '_') AS prd_key,
	substring(prd_key, 7, LENGTH(prd_key)) AS product_key,
	prd_nm,
	COALESCE(prd_cost, 0),
	 CASE
		upper(trim(prd_line))
	 WHEN 'R' THEN 'Road'
		WHEN 'M' THEN 'Mountain'
		WHEN 'S' THEN 'other sales'
		WHEN 'T' THEN 'touring'
		ELSE 'N/A'
	END AS prd_cost,
	prd_start_dtt::date,
	COALESCE(
  LEAD(prd_start_dtt) OVER (PARTITION BY prd_key ORDER BY prd_start_dtt) - INTERVAL '1 day',
  CASE 
    WHEN prd_end_dt IS NULL THEN NULL
    ELSE GREATEST(prd_start_dt, prd_end_dt)::date
  END
)AS prd_end_dt
FROM
	(
	SELECT
		prd_id,
		prd_key,
		prd_line,
		prd_nm,
		prd_cost,
		prd_start_dt,
		LEAST(prd_start_dt, prd_end_dt) AS prd_start_dtt,
		prd_end_dt
	FROM
		bronze.crm_prd_info
	ORDER BY
		prd_start_dt 
		);
-- --Transform crm sales info data from bronze to silver
INSERT
	INTO
	silver.crm_sales_details(
    sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	sls_order_dt,
	sls_ship_dt,
	sls_due_dt,
	sls_sales,
	sls_quantity,
	sls_price )
SELECT
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	CASE
		WHEN LENGTH(sls_order_dt::text) != 8 THEN NULL
		ELSE to_date(sls_order_dt::text, 'YYYYMMDD')
	END AS sls_order_dt,
	CASE
		WHEN LENGTH(sls_ship_dt::text) != 8 THEN NULL
		ELSE to_date(sls_ship_dt::text, 'YYYYMMDD')
	END AS sls_ship_dt,
	CASE
		WHEN LENGTH(sls_due_dt::text) != 8 THEN NULL
		ELSE to_date(sls_due_dt::text, 'YYYYMMDD')
	END AS sls_due_dt,
	CASE
		WHEN sls_sales <= 0
		OR sls_sales IS NULL
		OR sls_sales != abs(sls_price) * sls_quantity
THEN abs(sls_price) * sls_quantity
		ELSE 
sls_sales
	END AS sls_sales,
	sls_quantity,
	CASE
		WHEN sls_price <= 0
		OR sls_price IS NULL 
	THEN sls_sales / sls_quantity
		ELSE sls_price
	END AS sls_price
FROM
	bronze.crm_sales_details;
--transform erp_cust_az12  to the silver layer
INSERT
	INTO
	silver.erp_cust_az12(
cid,
	bdate,
	gen)
SELECT
	CASE
		WHEN cid LIKE 'NAS%' THEN substring(cid, 4, length(cid))
		ELSE cid
	END AS cid,
	CASE
		WHEN bdate > current_date THEN NULL
		ELSE bdate
	END AS bdate,
	CASE
		WHEN trim(gen) = '' THEN NULL
		WHEN trim(gen) = 'F' THEN 'Femal'
		WHEN trim(gen) = 'M' THEN 'Male'
		ELSE trim(gen)
	END AS gen
FROM
	bronze.erp_cust_az12;
--transfrom bronze.erp.loc_a101 TO the silver layer
INSERT
	INTO
	silver.erp_loc_a101 (
cid ,
	cntry)
SELECT
	REPLACE(cid, '-', ''),
	CASE
		WHEN trim(cntry) IN('Us' , 'USA') THEN 'United States'
		WHEN trim(cntry) = 'De' THEN 'Germany'
		WHEN trim(cntry) = '' THEN NULL
		ELSE trim(cntry)
	END AS cntry
FROM
	bronze.erp_loc_a101;
--transfrom bronze.erp_px_cat_g1v2 to the silver layer
INSERT
	INTO
	silver.erp_px_cat_g1v2(
id,
	cat,
	subcat,
	maintenance)
SELECT
	trim(id),
	cat,
	trim(subcat),
	maintenance
FROM
	bronze.erp_px_cat_g1v2;
