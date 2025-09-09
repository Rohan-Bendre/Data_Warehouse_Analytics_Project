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

TRUNCATE TABLE silver.src_prd_crm;
INSERT INTO silver.src_prd_crm (
	prd_id,
    cat_id,
	prd_key,
    prd_nm,
    prd_cost,
    prd_line,
    prd_start_dt,
    prd_end_dt  
) 
SELECT 
	prd_id, 
	REPLACE(SUBSTRING(prd_key ,1,5),'-','_') AS cat_id,  -- Derived Column
	SUBSTRING(prd_key ,7,LENGTH(prd_key)) AS prd_key,  -- Derived Column
	TRIM(prd_nm) AS prd_nm, -- Removing Unwanted Space
	COALESCE (prd_cost , 0 ) as prd_cost , -- Handle Null Values
	CASE 
		WHEN UPPER(TRIM(prd_line))='S' THEN 'Other Sales'  --Standardization
		WHEN UPPER(TRIM(prd_line))='M' THEN 'Mountain'  --Standardization
		WHEN UPPER(TRIM(prd_line))='R' THEN 'Road'  --Standardization
		WHEN UPPER(TRIM(prd_line))='T' THEN 'Touring'  --Standardization
		ELSE 'n/a'
	END AS prd_line,
	prd_start_dt,
	LEAD(PRD_START_DT) OVER (PARTITION BY PRD_KEY ORDER BY PRD_START_DT)-1  AS PRD_END_DT  -- Data Enrichment
FROM bronze.src_prd_crm ;

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

SELECT * FROM silver.src_prd_crm;