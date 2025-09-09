-- Now Create View in Gold Layer " Customer_Dimention "

/* 
	Hey We are use Different Data Cleaning Proccesses
	1] Handling Invalid Values
	2] Handle Null Values 
	3] Create New Unique Identifiers For Merging Data
	4] Merging Data
	5] Normalization
*/

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

-- SELECT * FROM silver.src_cust_crm;
-- SELECT * FROM silver.src_cust_erp;
-- SELECT * FROM silver.src_loc_erp;


CREATE VIEW gold.customers_dimention AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY cc.cst_id) AS Customer_key,  -- Data Enrichment
	cc.cst_id AS customer_id,
    cc.cst_key AS customer_number,
    cc.cst_firstname AS Firstname,
    cc.cst_lastname AS Lastname,
    cc.cst_marital_status AS Marital_Status,
    CASE 
		WHEN cc.cst_gndr <> 'n/a' THEN cc.cst_gndr
		ELSE COALESCE (ce.gen , 'n/a')
	END AS Gender,
	cl.contry AS Country,
	ce.bdate AS Birth_Date
    
FROM silver.src_cust_crm cc LEFT JOIN silver.src_cust_erp ce
ON cc.cst_key = ce.cid LEFT JOIN silver.src_loc_erp cl
ON cc.cst_key = cl.cid;

--------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------

-- IF you want to see  "customer_dimention" run only following query...
SELECT * FROM gold.customers_dimention;  