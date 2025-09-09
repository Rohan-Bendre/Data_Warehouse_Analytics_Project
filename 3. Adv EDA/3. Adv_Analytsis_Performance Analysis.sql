-- 3. Performance Analysis
SELECT * FROM gold.customer_dimention;
SELECT * FROM gold.product_dimention;
SELECT * FROM gold.orders_fact;

--What are the high-performing product categories by month?
SELECT EXTRACT (MONTH FROM oo.order_date) AS MONTH , 
		pd.category  ,
		SUM(oo.sales) AS Sales
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd 
ON oo.product_key = pd.product_key 
GROUP BY MONTH ,pd.category ORDER BY Sales DESC;

--Which customer segments are most profitable?
SELECT cst.country , 
	SUM(Sales) AS Sales
FROM gold.orders_fact oo LEFT JOIN gold.customer_dimention cst 
ON oo.customer_key = cst.customer_key 
GROUP BY cst.country ORDER BY Sales DESC;

--Which products are low performers?

SELECT pd.product_name  , 
	COUNT(oo.product_key) AS product
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd 
ON oo.product_key = pd.product_key 
GROUP BY pd.product_name  ORDER BY product ;

-- Customer loyalty .
SELECT cst.firstname , 
	cst.lastname , 
	COUNT(oo.order_number) AS Orders
FROM gold.orders_fact oo LEFT JOIN gold.customer_dimention cst 
ON oo.customer_key = cst.customer_key
GROUP BY cst.firstname , cst.lastname  ORDER BY Orders DESC;

-- `RANK()` over products by performance.
SELECT  RANK() OVER (ORDER BY SUM(oo.sales)) AS rank_,
		pd.product_name ,
		SUM(oo.sales) AS sales 
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd 
ON oo.product_key = pd.product_key 
GROUP BY pd.product_name;
		
