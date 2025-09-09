-- 3. Data Exploration
SELECT * FROM gold.customer_dimention;
SELECT * FROM gold.product_dimention;
SELECT * FROM gold.orders_fact;

--What is the trend in the number of orders over time?
--Year Wise
SELECT EXTRACT (YEAR FROM order_date) AS years ,
	COUNT(order_number) AS Total_Order
FROM gold.orders_fact GROUP BY years ORDER BY years;
-- Month Wise
SELECT DATE_TRUNC ('month', order_date) AS month ,
	COUNT(order_number) AS Total_Order
FROM gold.orders_fact GROUP BY month ORDER BY month;

--Which product categories generate the highest SALES?
SELECT DISTINCT pd.category , SUM(oo.sales) FROM gold.orders_fact oo LEFT JOIN 
gold.product_dimention pd ON pd.product_key=oo.product_key GROUP BY pd.category LIMIT 1;

--What is the average sales value per order?
SELECT DISTINCT order_number AS Orders , SUM(sales) , AVG(sales) AS average_sales_value_per_order
FROM gold.orders_fact GROUP BY Orders;

--Are there customers with significantly higher order frequency?
SELECT DISTINCT CST.customer_id , COUNT(oo.order_number ) AS Orders FROM gold.orders_fact oo LEFT JOIN 
gold.customer_dimention cst ON oo.customer_key=cst.customer_key
GROUP BY cst.customer_id ORDER BY COUNT(oo.order_number) desc;

--What is the overall revenue trend?
SELECT EXTRACT (YEAR FROM order_date) AS years ,
	SUM(sales) AS Total_sales
FROM gold.orders_fact GROUP BY years ORDER BY years;
-- Month Wise
SELECT DATE_TRUNC ('month', order_date) AS month ,
	SUM(sales) AS Total_sales
FROM gold.orders_fact GROUP BY month ORDER BY month;

--How does order quantity vary by region?
SELECT cst.country , SUM(oo.quantity) AS Total_quantity FROM gold.orders_fact oo LEFT JOIN 
gold.customer_dimention cst ON oo.customer_key=cst.customer_key
GROUP BY cst.country ORDER BY Total_quantity DESC;

--What is the total number of orders by customer_Country?
SELECT cst.Country , COUNT(DISTINCT(cst.customer_id)) AS Customers , COUNT(order_number) AS Orders FROM
gold.orders_fact oo LEFT JOIN gold.customer_dimention cst ON oo.customer_key=cst.customer_key
GROUP BY cst.Country ORDER BY Customers DESC;

-- What is the distribution of customer?
SELECT EXTRACT (YEAR FROM order_date) AS Years ,
		COUNT(DISTINCT(customer_key)) AS Customers
FROM gold.orders_fact GROUP BY Years ORDER BY Years;

SELECT DATE_TRUNC ('month', order_date) AS month ,
		COUNT(DISTINCT(customer_key)) AS Customers
FROM gold.orders_fact GROUP BY month ORDER BY month;

-- How many high-revenue orders (Sales > ₹500) exist?
SELECT COUNT(Orders) AS high_revenue_orders_in_NUMBER FROM (SELECT order_number , SUM(sales) FROM gold.orders_fact GROUP BY order_number
HAVING SUM(sales)>500) AS Orders;

--10. Which customer has generated the highest lifetime revenue?
SELECT cst.firstname ,cst.lastname , SUM(oo.sales) AS sales FROM gold.orders_fact oo LEFT JOIN 
gold.customer_dimention cst ON oo.customer_key=cst.customer_key
GROUP BY cst.firstname ,cst.lastname ORDER BY sales DESC LIMIT 1;

--* Total sales and quantity over time.
SELECT EXTRACT (YEAR FROM order_date) AS Years ,
		SUM(sales) AS Total_Sales,
		SUM(quantity) AS Total_quantity
FROM gold.orders_fact GROUP BY Years ORDER BY Years;

SELECT DATE_TRUNC ('month', order_date) AS month ,
		SUM(sales) AS Total_Sales,
		SUM(quantity) AS Total_quantity
FROM gold.orders_fact GROUP BY month ORDER BY month;

--* Avg. sales per product.
SELECT pd.product_name ,SUM(sales) AS Total_sales, AVG(oo.sales) AS Avg_sales_per_product 
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd ON pd.product_key=oo.product_key 
GROUP BY pd.product_name;

--* Highest and lowest selling products.
SELECT pd.product_name AS Highest_product_name,SUM(sales) AS Total_sales 
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd ON pd.product_key=oo.product_key 
GROUP BY pd.product_name ORDER BY Total_sales DESC LIMIT 1;

SELECT pd.product_name AS Lowest_product_name ,SUM(sales) AS Total_sales 
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd ON pd.product_key=oo.product_key 
GROUP BY pd.product_name ORDER BY Total_sales LIMIT 1;

--* Bottom 5 products by sales.
SELECT pd.product_name ,SUM(sales) AS Total_sales 
FROM gold.orders_fact oo LEFT JOIN gold.product_dimention pd ON pd.product_key=oo.product_key 
GROUP BY pd.product_name ORDER BY Total_sales LIMIT 5;

--* `RANK()` customers based on total sales.
SELECT RANK() OVER (ORDER BY SUM(oo.SALES) DESC) AS Rank_ ,
		cst.firstname , cst.lastname, SUM(oo.SALES) FROM gold.orders_fact oo LEFT JOIN 
gold.customer_dimention cst ON oo.customer_key=cst.customer_key
GROUP BY cst.firstname , cst.lastname ORDER BY Rank_;

--* `LAG()` to see previous order quantity/sales by customer.

SELECT customer_key , order_date , quantity AS current_quantity ,
	LAG (quantity) OVER (PARTITION BY customer_key ORDER BY  order_date) AS previous_quantity
FROM gold.orders_fact ORDER BY customer_key , order_date;

SELECT customer_key , order_date , sales AS current_sales ,
	LAG (sales) OVER (PARTITION BY customer_key ORDER BY  order_date) AS previous_sales
FROM gold.orders_fact ORDER BY customer_key , order_date;
