--5 Magnitude 
SELECT * FROM gold.customer_dimention ;
SELECT * FROM gold.product_dimention;
SELECT * FROM gold.orders_fact;

--What are the top 5 products by total sales?
SELECT pd.product_name , SUM(oo.sales) AS Total_Sale FROM gold.orders_fact oo LEFT JOIN
gold.product_dimention pd ON pd.product_key=oo.product_key GROUP BY pd.product_name 
ORDER BY Total_Sale DESC LIMIT 5;

--Which region contributes the most to overall sales?
SELECT cst.country , SUM(oo.sales) AS Total_Sale FROM gold.orders_fact oo LEFT JOIN
gold.customer_dimention cst ON cst.customer_key=oo.customer_key GROUP BY cst.country;

--What are the top 5 customers by revenue?
SELECT cst.firstname , cst.lastname , SUM(oo.sales) AS Total_Sale FROM gold.orders_fact oo LEFT JOIN
gold.customer_dimention cst ON cst.customer_key=oo.customer_key GROUP BY cst.firstname , cst.lastname
ORDER BY Total_Sale DESC LIMIT 5;

-- What is the total revenue (Sales)?
SELECT SUM(sales) AS total_revenue  FROM gold.orders_fact;

-- What is the total quantity across all orders?
SELECT SUM(quantity) AS quantity_across_all_orders FROM gold.orders_fact;

-- What is the total number of distinct products sold?
SELECT COUNT(DISTINCT(product_key)) FROM gold.orders_fact;

-- Highest sale amount per customer.
SELECT FN AS firstname, LNN AS lastname, MAX(Total_Sale) AS  Highest_sale_amount_per_customer FROM 
	(SELECT cst.firstname AS FN, cst.lastname AS LNN, SUM(oo.sales) AS Total_Sale  
	FROM gold.orders_fact oo LEFT JOIN gold.customer_dimention cst ON cst.customer_key=oo.customer_key 
	GROUP BY cst.firstname , cst.lastname ORDER BY Total_Sale) AS TT 
GROUP BY FN , LNN ;

-- Largest single order by quantity.
SELECT * FROM gold.orders_fact ORDER BY quantity DESC LIMIT 1;

-- highest revenue by order.
SELECT * FROM gold.orders_fact ORDER BY sales DESC LIMIT 1;

-- Use to find top 5 customers in terms of sales.
SELECT cst.firstname , cst.lastname , SUM(sales) AS Total_sale,
		RANK () OVER ( ORDER BY SUM(sales) DESC ) AS Rank_
FROM gold.orders_fact oo LEFT JOIN gold.customer_dimention cst ON cst.customer_key=oo.customer_key 
GROUP BY cst.firstname , cst.lastname LIMIT 5 ;

