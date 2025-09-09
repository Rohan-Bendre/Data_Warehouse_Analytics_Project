-- 6.Ranking 
SELECT * FROM gold.customer_dimention;
SELECT * FROM gold.product_dimention;
SELECT * FROM gold.orders_fact;

-- Top 10 customers by revenue.
SELECT cst.firstname , cst.lastname  , SUM(oo.sales) AS revenue FROM  gold.orders_fact oo LEFT JOIN
gold.customer_dimention cst ON cst.customer_key=oo.customer_key GROUP BY cst.firstname , cst.lastname 
ORDER BY revenue DESC LIMIT 10;

-- Top 5 products by quantity sold.
SELECT pd.product_name  , SUM(oo.sales) AS revenue FROM  gold.orders_fact oo LEFT JOIN
gold.product_dimention pd ON pd.product_key=oo.product_key GROUP BY pd.product_name 
ORDER BY revenue DESC LIMIT 5;

-- Top 3 subcategories by sale given.
SELECT pd.sub_category  , SUM(oo.sales) AS revenue FROM  gold.orders_fact oo LEFT JOIN
gold.product_dimention pd ON pd.product_key=oo.product_key GROUP BY pd.sub_category
ORDER BY revenue DESC LIMIT 3;

-- Rank the product_line by usage frequency.
SELECT pd.product_line , COUNT(pd.product_line ) AS FQNCY ,
		RANK() OVER (ORDER BY COUNT(pd.product_line ) DESC ) AS Rank_
FROM  gold.orders_fact oo LEFT JOIN gold.product_dimention pd ON pd.product_key=oo.product_key
GROUP BY pd.product_line ORDER BY Rank_;

-- Rank states by order count.
SELECT ROW_NUMBER () OVER ( ORDER BY COUNT(oo.order_number) DESC) AS Rank_,
	cst.country , COUNT(oo.order_number) AS Orders 
FROM gold.orders_fact oo LEFT JOIN gold.customer_dimention cst ON cst.customer_key=oo.customer_key
GROUP BY cst.country ORDER BY Orders DESC;

-- Use `ROW_NUMBER()` to fetch the most recent order per customer.
SELECT DISTINCT customer_key , order_date , order_number , 
ROW_NUMBER() OVER (PARTITION BY customer_key ORDER BY order_date) AS Rank_
FROM gold.orders_fact ORDER BY customer_key, order_date;

-- Rank sub-categories by total quantity sold.
SELECT pd.sub_category ,SUM(oo.quantity ) AS quantity, RANK() OVER (ORDER BY SUM(oo.quantity ) DESC) FROM 
gold.orders_fact oo LEFT JOIN gold.product_dimention pd ON pd.product_key=oo.product_key
GROUP BY pd.sub_category ;

--Rank the products by quantity sold.
SELECT pd.product_name ,SUM(oo.quantity ) AS quantity, DENSE_RANK() OVER (ORDER BY SUM(oo.quantity ) DESC) FROM 
gold.orders_fact oo LEFT JOIN gold.product_dimention pd ON pd.product_key=oo.product_key
GROUP BY pd.product_name ;
