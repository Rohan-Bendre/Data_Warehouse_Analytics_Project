
-- Now Create View in Gold Layer " Product_Dimention "

-- Select * from silver.src_prd_crm;
-- Select * from silver.src_ctg_erp;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

CREATE VIEW gold.product_dimention AS 
SELECT 
	ROW_NUMBER() OVER (ORDER BY prd_start_dt ,  prd_key) AS product_key,  -- Data Enrichment
	prd_id AS product_id,
	prd_key AS product_number,
	prd_nm AS product_name,
	cat_id AS category_id,
	cat AS category,
    subcat AS sub_category,
    maintenance,
    prd_cost AS product_cost,
    prd_line AS product_line,
    prd_start_dt AS start_date
FROM silver.src_prd_crm pc LEFT JOIN silver.src_ctg_erp ce 
ON pc.cat_id=ce.id_ 
WHERE prd_end_dt IS NULL;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- IF you want to see  "product_dimention" run only following query...
SELECT * FROM gold.product_dimention;