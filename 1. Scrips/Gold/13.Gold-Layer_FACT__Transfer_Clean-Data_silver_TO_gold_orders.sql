-- Now Create View in Gold Layer " Ordersr_Fact "

-- SELECT * FROM silver.src_sales_details_crm ;
-- SELECT * FROM gold.customer_dimention ;
-- SELECT * FROM gold.product_dimention ;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

CREATE VIEW gold.orders_fact AS 
SELECT 
	ss.sls_ord_num AS Order_Number,
    pd.product_key As product_key, -- Derived Column
    cd.customer_key AS customer_key,  -- -- Derived Column
    ss.sls_order_dt AS Order_date,
    ss.sls_ship_dt AS ship_date,
    ss.sls_due_dt AS due_date,
    ss.sls_sales AS Sales,
    ss.sls_quantity AS quantity,
    ss.sls_price AS price
FROM silver.src_sales_details_crm ss LEFT JOIN gold.customers_dimention cd
ON ss.sls_cust_id=cd.customer_id LEFT JOIN gold.product_dimention pd
ON ss.sls_prd_key=pd.product_number;

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

-- IF you want to see  "Orders_Fact" run only following query...
SELECT * FROM gold.orders_fact;