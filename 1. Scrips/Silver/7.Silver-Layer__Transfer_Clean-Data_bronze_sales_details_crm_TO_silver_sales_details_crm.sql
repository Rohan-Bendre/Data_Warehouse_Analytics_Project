-- Now Starting To Transfer Data Bronze-Layer To Silver_Layer

/*
	Hey Here we do some Data-Trasformation Methods Like: Data Cleaning
	1] Unwanted Space
	2] Standardization
	3] Normalization
	4] Handle Null Values
	5] Data Enrichment
	6] Derived Column
	
	These Techniques Help us to ensure data "Accuracy" , "Consistency" ,"Reliability"
	"leading to better Decision-Making" , "Data Governance" , "Data Quality" , "Better Analysis".
*/

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

TRUNCATE TABLE silver.src_sales_details_crm;
INSERT INTO silver.src_sales_details_crm (
	sls_ord_num,
    sls_prd_key,
    sls_cust_id,
    sls_order_dt,
    sls_ship_dt,
    sls_due_dt,
    sls_sales,
    sls_quantity,
    sls_price
)
SELECT 
	sls_ord_num,
	sls_prd_key,
	sls_cust_id,
	CASE 
		WHEN sls_order_dt <=0 OR LENGTH(CAST(sls_order_dt AS TEXT))<>8 THEN NULL
		ELSE CAST(CAST(sls_order_dt AS TEXT) AS DATE)
	END AS sls_order_dt,
	CASE 
		WHEN sls_ship_dt <=0 OR LENGTH(CAST(sls_ship_dt AS TEXT))<>8 THEN NULL
		ELSE CAST(CAST(sls_ship_dt AS TEXT) AS DATE)
	END AS sls_ship_dt,
	CASE 
		WHEN sls_due_dt <=0 OR LENGTH(CAST(sls_due_dt AS TEXT))<>8 THEN NULL
		ELSE CAST(CAST(sls_due_dt AS TEXT) AS DATE)
	END AS sls_due_dt,
	CASE 
		WHEN sls_sales <> sls_quantity * ABS(sls_price) OR sls_sales IS NULL OR sls_sales <=0
		THEN sls_quantity * ABS(sls_price)
		ELSE sls_sales
	END AS sls_sales,
	sls_quantity,
	CASE 
		WHEN sls_price IS NULL OR sls_price<=0
		THEN sls_sales / sls_quantity
		ELSE sls_price
	END AS sls_price
FROM bronze.src_sales_details_crm ;

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------


SELECT * FROM silver.src_sales_details_crm;