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

TRUNCATE TABLE silver.src_loc_erp;
INSERT INTO silver.src_loc_erp(
	cid,
	contry
)
SELECT 
	REPLACE(cid , '-','') AS cid,  -- Derived Column
	CASE 
		WHEN TRIM(contry)= 'DE' THEN 'Germany'                     -- Standardization
		WHEN TRIM(contry) IN ('US' , 'USA') THEN 'United States'   --Standardization
		WHEN TRIM(contry) IN ('n/a' , null ,'') THEN NULL          --Handle Null Values
		ELSE contry
	END AS contry
FROM bronze.src_loc_erp;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

SELECT * FROM silver.src_loc_erp;
