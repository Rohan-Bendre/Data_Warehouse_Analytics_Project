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

TRUNCATE TABLE silver.src_cust_erp;
INSERT INTO silver.src_cust_erp(
	cid,
	bdate,
	gen
)
SELECT 
	CASE 
		WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid , 4 , LENGTH(cid))
		ELSE cid
	END AS cid,
	CASE
		WHEN bdate > CURRENT_DATE THEN NULL
		ELSE bdate
	END AS bdate,
	CASE 
		WHEN UPPER(TRIM(gen)) IN ('F' , 'FEMALE') THEN 'Female'
		WHEN UPPER(TRIM(gen)) IN ('M' , 'MALE') THEN 'Male'
		ELSE 'n/a'
	END AS gen
FROM bronze.src_cust_erp;

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

SELECT * FROM silver.src_cust_erp;
