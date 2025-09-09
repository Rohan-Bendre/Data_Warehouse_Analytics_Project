--2. Cumulative Analysis

--What is the cumulative revenue generated month-by-month?
SELECT DATE_TRUNC( 'month' , order_date ) AS Months ,
	SUM(sales) AS Sales ,
	SUM(SUM(sales)) OVER 
	(ORDER BY DATE_TRUNC( 'month' , order_date ) ) AS cumulative
FROM gold.orders_fact GROUP BY Months;
	
--What is the cumulative number of orders per customer?

SELECT  
  EXTRACT(YEAR FROM order_date) AS year,
  customer_key,
  COUNT(order_number) OVER (
    PARTITION BY customer_key
    ORDER BY EXTRACT(YEAR FROM order_date)
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_orders
FROM gold.orders_fact
ORDER BY customer_key, year;

--What is the cumulative sales by category over the year?

SELECT  
  EXTRACT(YEAR FROM order_date) AS year,
  pd.category,
  SUM(sales) AS yearly_sales,
  SUM(SUM(sales)) OVER (
    PARTITION BY pd.category 
    ORDER BY EXTRACT(YEAR FROM order_date)
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_sales
FROM gold.orders_fact oo
LEFT JOIN gold.product_dimention pd 
  ON oo.product_key = pd.product_key
GROUP BY EXTRACT(YEAR FROM order_date), pd.category
ORDER BY pd.category, year;

--Which customer accounts for the highest cumulative revenue?
SELECT *
FROM (
    SELECT 
        customer_key,
        SUM(sales) AS total_revenue,
        RANK() OVER (ORDER BY SUM(sales) DESC) AS rnk
    FROM gold.orders_fact
    GROUP BY customer_key
) ranked_customers
WHERE rnk = 1;

--* Cumulative sales per product.
SELECT 
  pd.product_name,
  DATE_TRUNC('month', order_date) AS month,
  SUM(sales) AS monthly_sales,
  SUM(SUM(sales)) OVER (
    PARTITION BY pd.product_name 
    ORDER BY DATE_TRUNC('month', order_date)
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_sales
FROM gold.orders_fact oo
LEFT JOIN gold.product_dimention pd 
  ON oo.product_key = pd.product_key
GROUP BY pd.product_name, DATE_TRUNC('month', order_date)
ORDER BY pd.product_name, month;

--* Cumulative revenue per region.

SELECT 
  cst.country,
  EXTRACT (YEAR FROM order_date) AS year,
  SUM(sales) AS yearly_revenue,
  SUM(SUM(sales)) OVER (
    PARTITION BY cst.country
    ORDER BY EXTRACT (YEAR FROM order_date)
    ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
  ) AS cumulative_revenue
FROM gold.orders_fact oo
JOIN gold.customer_dimention cst
  ON oo.customer_key = cst.customer_key
GROUP BY cst.country, EXTRACT (YEAR FROM order_date)
ORDER BY cst.country, year;

