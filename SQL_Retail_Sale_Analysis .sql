-- SQL RETAIL SALES ANALYSIS
CREATE DATABASE sql_project_q1;


USE sql_project_q1;

-- CREATE TABLE
CREATE TABLE retail_sales 
(
	transactions_id	INT PRIMARY KEY,
	sale_date DATE,	
	sale_time TIME,	
	customer_id	INT NULL,
	gender VARCHAR(15),
	age	 INT NULL,
    category VARCHAR(15),
	quantity INT NULL,
	price_per_unit FLOAT,
	cogs FLOAT,
	total_sale FLOAT NULL
);

SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

-- Selecting columns with null values

SELECT *
FROM retail_sales
WHERE quantity = 0;

-- Removing null values from the data
DELETE FROM retail_sales
WHERE transactions_id =679
OR
transactions_id =746
OR
transactions_id =1225;



-- Data Exploration

-- Total number of records
SELECT COUNT(*) FROM retail_sales;

-- Total number of unique customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Total number of categories
SELECT COUNT(DISTINCT category) FROM retail_sales;

-- Check the type of categories we have
SELECT DISTINCT category FROM retail_sales;


-- Data Analysis & Business Key Problems & Answers

-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM retail_sales
WHERE category = 'Clothing'
AND
quantity >=4
AND
sale_date BETWEEN '2022-11-1' AND '2022-11-30';

-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT category, SUM(total_sale) AS total_sales,
COUNT(*) AS toal_orders
FROM retail_sales
GROUP BY category;
  
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT ROUND(AVG(age),2) AS Average_age
FROM retail_sales
WHERE category = 'Beauty';

-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT * FROM retail_sales
WHERE total_sale >1000;

-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT  
	category AS Category, 
	gender AS Gender,
	COUNT(transactions_id) AS Total_Transactions
FROM retail_sales
GROUP BY gender, category;

-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT year, month, average_sale
FROM
(
    SELECT 
        YEAR(sale_date) AS year,
        MONTH(sale_date) AS month,
        AVG(total_sale) AS average_sale,
        RANK() OVER (PARTITION BY YEAR(sale_date) ORDER BY AVG(total_sale) DESC) AS ranking
    FROM retail_sales
    GROUP BY YEAR(sale_date), MONTH(sale_date)
) AS t1
WHERE ranking = 1;

-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
SELECT customer_id, SUM(total_sale) AS total
FROM retail_sales
GROUP BY customer_id
ORDER BY total DESC
LIMIT 5;



-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
SELECT COUNT(DISTINCT(customer_id)) AS customers, category
FROM retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)
SELECT
	CASE
		WHEN HOUR(sale_time) <=12 THEN 'Morning Shift'
		WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon Shift'
		ELSE 'Evening'
	END AS shift,
    COUNT(*) AS total_orders    
FROM retail_sales
GROUP BY shift;

-- End of Analysis







