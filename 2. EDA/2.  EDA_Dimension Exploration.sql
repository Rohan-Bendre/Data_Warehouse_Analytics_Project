-- 2. Dimension Exploration

SELECT * FROM gold.customer_dimention;
SELECT * FROM gold.product_dimention;
SELECT * FROM gold.orders_fact;

-- List all unique product categories and subcategories. 
SELECT DISTINCT category , sub_category  FROM gold.product_dimention ORDER BY category;

-- How many customers belong to each region/state?
SELECT DISTINCT(country) , COUNT(DISTINCT(customer_id)) AS customers FROM gold.customer_dimention 
GROUP BY country;

-- Customer count by category.
SELECT DISTINCT pd.category AS Product_Category, COUNT(DISTINCT(oo.customer_key)) AS Customers 
FROM gold.orders_fact oo 
LEFT JOIN gold.product_dimention pd ON oo.product_key=pd.product_key GROUP BY  pd.category
ORDER BY  pd.category;

-- Product count by category and subcategory.
SELECT DISTINCT category , sub_category , COUNT(DISTINCT(product_name)) AS products 
FROM gold.product_dimention
GROUP BY category , sub_category ORDER BY category;

-- Country-level customer distribution.
SELECT DISTINCT Country , COUNT(DISTINCT(customer_id)) AS customers FROM gold.customer_dimention 
GROUP BY Country;

-- Top 3 Country by customer count.
SELECT DISTINCT Country , COUNT(DISTINCT(customer_id)) AS customers FROM gold.customer_dimention 
GROUP BY Country LIMIT 3;

-- Yearly count of active customers.
SELECT EXTRACT (YEAR FROM order_date ) AS Years ,
		COUNT (DISTINCT (customer_key)) AS customers
FROM gold.orders_fact GROUP BY EXTRACT (YEAR FROM order_date );

-- What are the top 5 cities by number of orders?
SELECT DISTINCT cst.country , COUNT(oo.order_number) AS ORDERS FROM gold.orders_fact oo
LEFT JOIN gold.customer_dimention cst ON oo.customer_key=cst.customer_key 
GROUP BY cst.country LIMIT 5;

-- How many orders were placed by customers from each country?
SELECT DISTINCT cst.country , COUNT(oo.order_number) AS ORDERS FROM gold.orders_fact oo
LEFT JOIN gold.customer_dimention cst ON oo.customer_key=cst.customer_key 
GROUP BY cst.country;

-- Which product categories are most popular by SALE?
SELECT DISTINCT pd.category, SUM(oo.sales) AS Sale_Amount FROM gold.orders_fact oo
LEFT JOIN gold.product_dimention pd ON oo.product_key=pd.product_key GROUP BY pd.category 
ORDER BY Sale_Amount DESC;

-- What is the distribution of customers across different Sub_Category?
SELECT DISTINCT pd.Sub_Category , COUNT(distinct(OO.customer_key)) AS customers 
FROM gold.orders_fact oo LEFT JOIN  gold.product_dimention PD
ON oo.product_key=pd.product_key GROUP BY pd.Sub_Category;

--How many different Product_lines are used in orders?
SELECT DISTINCT pd.Product_line FROM gold.orders_fact oo LEFT JOIN  gold.product_dimention PD
ON oo.product_key=pd.product_key;

--What is the most frequently ordered product?
SELECT DISTINCT pd.product_name , COUNT(pd.product_name) AS product_no FROM gold.orders_fact oo 
LEFT JOIN gold.product_dimention PD ON oo.product_key=pd.product_key 
GROUP BY pd.product_name ORDER BY product_no DESC LIMIT 1;

-- Use `RANK()` to rank regions by customer count within each category.
SELECT cst.country , pd.category , COUNT( oo.Customer_key) AS customer,
RANK() OVER ( PARTITION BY CST.COUNTRY ORDER BY COUNT(oo.Customer_key) DESC) AS Rank_ 
FROM gold.orders_fact oo  
LEFT JOIN gold.product_dimention PD ON oo.product_key=pd.product_key
LEFT JOIN gold.customer_dimention cst ON oo.customer_key=cst.customer_key 
GROUP BY cst.country ,  pd.category ;

-- Use `DENSE_RANK()` to assign ranks to categories based on product volume.
SELECT pd.category , pd.product_name , SUM(oo.Sales) ,
DENSE_RANK() OVER (PARTITION BY pd.category ORDER BY SUM(oo.Sales) DESC ) AS RANK_
FROM gold.orders_fact oo 
LEFT JOIN gold.product_dimention PD ON oo.product_key=pd.product_key GROUP BY
pd.category , pd.product_name;

