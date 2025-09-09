-- Now Starting To Transfer Data Bronze-Layer To Silver_Layer

/*
	Hey Here we do some Data-Trasformation Methods Like: Data Cleaning
	1] Unwanted Space
	2] Standardization
	3] Normalization
	4] Null Values
	These Techniques Help us to ensure data "Accuracy" , "Consistency" ,"Reliability"
	"leading to better Decision-Making" , "Data Governance".
*/

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

TRUNCATE TABLE silver.src_cust_crm;
INSERT INTO silver.src_cust_crm (
	cst_id,          
    cst_key,          
    cst_firstname,    
    cst_lastname,       
    cst_marital_status,  
    cst_gndr,            
    cst_create_date
)

SELECT 
	cst_id,             
	cst_key,          
	TRIM(cst_firstname) AS cst_firstname,   -- Removing Unwanted Space   
	TRIM(cst_lastname ) AS cst_lastname,    -- Removing Unwanted Space  
	CASE 
		WHEN UPPER(cst_marital_status)='S' THEN 'Single'  -- Standardization
		WHEN UPPER(cst_marital_status)='M' THEN 'Married'  -- Standardization
		ELSE 'n/a'
	END AS cst_marital_status,
	CASE 
		WHEN UPPER(cst_gndr)='F' THEN 'Female'  -- Standardization
		WHEN UPPER(cst_gndr)='M' THEN 'Male'  -- Standardization
		ELSE 'n/a'
	END AS cst_gndr ,         
	cst_create_date 
FROM 
   (SELECT * ,
	ROW_NUMBER() OVER ( PARTITION BY cst_id ORDER BY cst_create_date DESC) AS last_ FROM bronze.src_cust_crm
	WHERE cst_id IS NOT NULL)
WHERE LAST_ = 1;  -- Understanding Null Values

----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------

SELECT * FROM silver.src_cust_crm;