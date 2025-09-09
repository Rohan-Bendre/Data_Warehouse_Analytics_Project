-- 1. Database Exploration

SELECT * FROM gold.customer_dimention;
SELECT * FROM gold.product_dimention;
SELECT * FROM gold.orders_fact;

-- How many unique customers are in the dataset?
SELECT COUNT(DISTINCT customer_id) FROM gold.customer_dimention;

-- What are the different product categories available in the Products table?
SELECT DISTINCT category FROM gold.product_dimention;

-- How many orders have been placed in total?
SELECT COUNT(order_number) FROM gold.orders_fact;

--  What is the range of order dates (earliest to latest)?
SELECT  MIN(order_date) AS Earliest_Date,
		MAX(order_date) AS Latest_Date ,
		MAX(order_date) - MIN(order_date) AS range_in_days FROM gold.orders_fact;
		
--  How many unique products are listed?
SELECT COUNT(DISTINCT(product_name)) AS Unique_Product FROM gold.product_dimention;

--  How many unique customers and products exist in the Oreders dataset?
SELECT COUNT(DISTINCT(product_key)) AS Product , COUNT(DISTINCT(customer_key)) AS Customer
FROM gold.orders_fact; 
 
-- What are the number of rows and columns in each table?
SELECT COUNT(*) AS ROW_in_Product FROM gold.product_dimention;
SELECT COUNT(*) AS Tables_No FROM  information_schema.columns
			WHERE table_name = 'product_dimention'
			AND table_schema = 'gold';

SELECT COUNT(*) AS ROW_in_Orders FROM gold.orders_fact;
SELECT COUNT(*) AS Tables_in_Orders FROM  information_schema.columns
			WHERE table_name = 'orders_fact'
			AND table_schema = 'gold';

SELECT COUNT(*) AS ROW_in_Customer FROM gold.customer_dimention;
SELECT COUNT(*) AS Tables_in_Customer FROM  information_schema.columns
			WHERE table_name = 'customer_dimention'
			AND table_schema = 'gold';

-- Check for missing/null values in key columns.
SELECT order_number AS Null_Values FROM gold.orders_fact WHERE order_number IS NULL;

-- Show each customer and their number of orders.
SELECT DISTINCT customer_key, COUNT(order_number) AS Orders 
FROM gold.orders_fact GROUP BY customer_key;
