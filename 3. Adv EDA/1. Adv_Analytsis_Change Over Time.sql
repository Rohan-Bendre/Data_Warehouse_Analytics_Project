---  1. Change Over Time 
SELECT * FROM gold.customer_dimention AS cd;
SELECT * FROM gold.product_dimention AS pd;
SELECT * FROM gold.orders_fact AS oo;

-- How have monthly sales trended over the past year?
SELECT 
	CASE 
		WHEN EXTRACT (YEAR FROM order_date) = 2013
		THEN date_trunc ('month' , order_date )
	END  AS previous_year_months , 
	SUM(SALES) AS SALES
FROM gold.orders_fact GROUP BY previous_year_months ORDER BY previous_year_months;

--How has the sale changed over quarters?
 SELECT 
 	CASE 
	 	WHEN EXTRACT (YEAR FROM order_date) = 2013 THEN EXTRACT (quarter FROM order_date) 
	END AS quarters_for_2013,
 	SUM(SALES) AS SALES
FROM gold.orders_fact GROUP BY quarters_for_2013 ORDER BY quarters_for_2013;

--Which products show increasing/decreasing demand over time?
SELECT EXTRACT (YEAR FROM oo.order_date) AS years , pd.product_name , COUNT(pd.product_name) AS products
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd 
ON oo.product_key=pd.product_key GROUP BY years, pd.product_name ORDER BY years , products DESC ;

-- What is the monthly trend in sales across the year?
SELECT 
	CASE 
		WHEN EXTRACT (YEAR FROM order_date) = 2013
		THEN date_trunc ('month' , order_date )
	END  AS year_months , 
	SUM(SALES) AS SALES
FROM gold.orders_fact GROUP BY year_months;

-- How does SALES vary month-to-month?
SELECT TO_CHAR(order_date , 'Mon') AS Months ,
	SUM(SALES) AS Sales
FROM gold.orders_fact GROUP BY Months ORDER BY Months;

-- What is the sales trend by category over time?
SELECT EXTRACT (YEAR FROM oo.order_date) AS years , pd.category , SUM(oo.SALES) AS Sales 
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd  ON oo.product_key=pd.product_key 
GROUP BY years , pd.category ORDER BY years , Sales DESC ;

-- Quantity trend over time.
SELECT EXTRACT (YEAR FROM order_date) AS years , COUNT(Quantity) AS Total_Quantity FROM 
Gold.orders_fact GROUP BY years ORDER BY years;

-- Revenue growth over time.
SELECT EXTRACT (YEAR FROM order_date) AS years , SUM(Sales) AS Total_Revenue FROM 
Gold.orders_fact GROUP BY years ORDER BY Total_Revenue ;

