# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `sql_project_q1`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
CREATE DATABASE sql_project_q1;

USE sql_project_q1;

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

```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
The querry below was used in the data cleaning process
-- Total number of records
SELECT COUNT(*) FROM retail_sales;

-- Total number of unique customers
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;

-- Total number of categories
SELECT COUNT(DISTINCT category) FROM retail_sales;

-- Check the type of categories we have
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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **SQL query to retrieve all columns for sales made on '2022-11-05**:

```sql
SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:

```sql
SELECT * FROM retail_sales
WHERE category = 'Clothing'
AND
quantity >=4
AND
sale_date BETWEEN '2022-11-1' AND '2022-11-30';
```

3. **SQL query to calculate the total sales (total_sale) for each category.**:

```sql
SELECT category, SUM(total_sale) AS total_sales,
COUNT(*) AS toal_orders
FROM retail_sales
GROUP BY category;
```

4. **SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:

```sql
SELECT ROUND(AVG(age),2) AS Average_age
FROM retail_sales
WHERE category = 'Beauty';
```

5. **SQL query to find all transactions where the total_sale is greater than 1000.**:

```sql
SELECT * FROM retail_sales
WHERE total_sale >1000;
```

6. **SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:

```sql
SELECT
	category AS Category,
	gender AS Gender,
	COUNT(transactions_id) AS Total_Transactions
FROM retail_sales
GROUP BY gender, category;
```

7. **SQL query to calculate the average sale for each month. Find out best selling month in each year**:

```sql
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
```

8. **SQL query to find the top 5 customers based on the highest total sales **:

```sql
SELECT customer_id, SUM(total_sale) AS total
FROM retail_sales
GROUP BY customer_id
ORDER BY total DESC
LIMIT 5;
```

9. **SQL query to find the number of unique customers who purchased items from each category.**:

```sql
SELECT COUNT(DISTINCT(customer_id)) AS customers, category
FROM retail_sales
GROUP BY category;
```

10. **SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:

```sql
SELECT
	CASE
		WHEN HOUR(sale_time) <=12 THEN 'Morning Shift'
		WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon Shift'
		ELSE 'Evening'
	END AS shift,
    COUNT(*) AS total_orders
FROM retail_sales
GROUP BY shift;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

## How to Use

1. **Clone the Repository**: Clone this project repository from GitHub.
2. **Set Up the Database**: Run the SQL scripts provided in the `database_setup.sql` file to create and populate the database.
3. **Run the Queries**: Use the SQL queries provided in the `analysis_queries.sql` file to perform your analysis.
4. **Explore and Modify**: Feel free to modify the queries to explore different aspects of the dataset or answer additional business questions.

## Author - Nana Ameyaw

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!
