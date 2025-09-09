SELECT * FROM gold.customer_dimention;
SELECT * FROM gold.product_dimention;
SELECT * FROM gold.orders_fact;

-- Each product’s % of total sales.
SELECT pd.product_name ,
	SUM(sales) AS sales ,
	ROUND ( SUM(oo.sales) * 100  / SUM(SUM(oo.sales)) OVER (), 2 ) AS percent_
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd 
ON oo.product_key = pd.product_key 
GROUP BY pd.product_name
ORDER BY percent_ DESC ; 

-- Customer segment’s % of total orders.
SELECT cst.country , 
	COUNT(oo.order_number) AS Orders ,
	ROUND ( COUNT(oo.order_number) * 100  / SUM(COUNT(oo.order_number)) OVER (), 2 ) AS percent_
FROM gold.orders_fact oo LEFT JOIN gold.customer_dimention cst 
ON oo.customer_key = cst.customer_key
GROUP BY cst.country ORDER BY percent_ DESC;

-- State’s % of overall Sales.
SELECT cst.country , 
	SUM(oo.sales) AS Total_Sales ,
	ROUND (  SUM(oo.sales) * 100  / SUM(SUM(oo.sales)) OVER (), 2 ) AS percent_
FROM  gold.orders_fact oo LEFT JOIN gold.customer_dimention cst 
ON oo.customer_key = cst.customer_key
GROUP BY cst.country ORDER BY percent_ DESC;

-- Customer contribution to total sales.
SELECT cst.firstname , cst.lastname ,
		SUM(sales) AS Sales ,
		ROUND (SUM(sales) * 100 / SUM(SUM(sales)) OVER() , 5) AS contribution_in_percent
FROM gold.orders_fact oo LEFT JOIN gold.customer_dimention cst 
ON oo.customer_key = cst.customer_key
GROUP BY cst.firstname , cst.lastname ORDER BY contribution_in_percent DESC;

--- Monthly % contribution to yearly sales.
SELECT EXTRACT (YEAR FROM order_date) AS Years ,
		EXTRACT (MONTH FROM order_date) AS Months ,
		SUM(sales) AS sales ,
		ROUND ( 
		SUM(sales) * 100 / SUM(SUM(sales)) 
		OVER (PARTITION BY EXTRACT (YEAR FROM order_date) )
		, 2) AS Monthly_contribution_in_percent
FROM gold.orders_fact
GROUP BY Years , Months 
ORDER BY Years , Monthly_contribution_in_percent DESC;

-- Order count % by category.
SELECT pd.category ,
	COUNT(oo.order_number) AS orders,
	ROUND ( COUNT(oo.order_number) * 100 / SUM(COUNT(oo.order_number)) 
	OVER () 
	,2) AS Order_count_in_percent
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd 
ON oo.product_key = pd.product_key 
GROUP BY pd.category 
ORDER BY Order_count_in_percent DESC;

-- product_line level contribution.
SELECT pd.product_line ,
	SUM(sales) AS sales , 
	ROUND (  SUM(oo.sales) * 100  / SUM(SUM(oo.sales)) OVER (), 2 ) AS percent_
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd 
ON oo.product_key = pd.product_key 
GROUP BY pd.product_line
ORDER BY percent_ DESC ;

-- What % of sub_category account for < average of sales amount?
SELECT pd.sub_category ,
	SUM(oo.sales) AS saless,
	ROUND ( SUM(oo.sales) * 100 / SUM(SUM(oo.sales)) 
	OVER () 
	,2) AS Order_count_in_percent
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd 
ON oo.product_key = pd.product_key 
WHERE oo.sales >(SELECT AVG(sales) FROM gold.orders_fact)
GROUP BY pd.sub_category 
ORDER BY Order_count_in_percent DESC;

-- What % of quantity comes from top 10 customers?
SELECT cst.firstname , cst.lastname ,
	COUNT(oo.quantity) AS quantity ,
	ROUND (COUNT(oo.quantity) * 100 / SUM(COUNT(oo.quantity)) OVER() 
	,2) AS percent_
FROM gold.orders_fact oo LEFT JOIN gold.customer_dimention cst 
ON oo.customer_key = cst.customer_key
GROUP BY cst.firstname , cst.lastname 
ORDER BY percent_ DESC LIMIT 10 ;

--How much of the total orders < 10% by sub_category?
SELECT pd.sub_category ,
	COUNT(oo.order_number) AS orders,
	ROUND ( COUNT(oo.order_number) * 100/ SUM(COUNT(oo.order_number)) 
	OVER () 
	,2) AS Order_count_in_percent
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd 
ON oo.product_key = pd.product_key 
GROUP BY pd.sub_category
ORDER BY Order_count_in_percent DESC;
	