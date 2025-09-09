-- 5. Data Segmentation

--Segment customers by sales volume.
SELECT pd.category , cst.firstname , cst.lastname , 
	SUM(oo.sales) AS volume 
FROM gold.orders_fact oo           LEFT JOIN gold.product_dimention pd
ON oo.product_key = pd.product_key LEFT JOIN gold.customer_dimention cst
ON oo.customer_key = cst.customer_key
GROUP BY pd.category , cst.firstname , cst.lastname ORDER BY pd.category , volume DESC;

 --Segment products by revenue.
 SELECT pd.sub_category , pd.product_name ,
 	SUM(oo.sales) AS revenue
FROM gold.orders_fact oo  LEFT JOIN gold.product_dimention pd
ON oo.product_key = pd.product_key
GROUP BY pd.sub_category , pd.product_name ORDER BY revenue DESC;

 --Group customers by frequency.
 SELECT cst.firstname , cst.lastname ,
 COUNT(order_number) AS oeders,
 CASE 
 	WHEN COUNT(order_number)>=50 THEN 'Greater than 50'
	WHEN COUNT(order_number)<50 AND COUNT(order_number)>=10 THEN 'Less than 50 and greater than 10'
ELSE 'less than 10' END AS frequency
FROM gold.orders_fact oo  LEFT JOIN gold.customer_dimention cst
ON oo.customer_key = cst.customer_key
GROUP BY cst.firstname , cst,lastname ORDER BY oeders DESC;

 --Categorize regions based on Quantity.
 
 SELECT pd.category , SUM(Quantity) AS Quantity
 FROM gold.orders_fact oo  LEFT JOIN gold.product_dimention pd
ON oo.product_key = pd.product_key 
GROUP BY pd.category ORDER BY Quantity DESC;
 
--Use `RANK()` on customers within each region.

 SELECT RANK() OVER (PARTITION BY pd.category ORDER BY pd.category , SUM(oo.sales) DESC) ,
 	pd.category , 
 	cst.firstname , cst.lastname ,
 	SUM(oo.sales) AS sales 
 FROM gold.orders_fact oo           LEFT JOIN gold.product_dimention pd
ON oo.product_key = pd.product_key  LEFT JOIN gold.customer_dimention cst
ON oo.customer_key = cst.customer_key
GROUP BY pd.category , cst.firstname , cst,lastname;

--Segment products based on Quantity with categories.
SELECT pd.category , pd.product_name , SUM(oo.Quantity) AS quantity 
FROM gold.orders_fact oo  LEFT JOIN gold.product_dimention pd
ON oo.product_key = pd.product_key 
GROUP BY pd.category , pd.product_name ORDER BY pd.category , quantity DESC ;


