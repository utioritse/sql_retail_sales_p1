

-- Data Cleaning
SELECT * FROM retail_sales
LIMIT 10;


SELECT COUNT (*) FROM retail_sales;

SELECT * FROM retail_sales
WHERE transactions_id IS NULL;

SELECT * FROM retail_sales
WHERE sale_date IS NULL;

SELECT * FROM retail_sales
WHERE sale_time IS NULL;

SELECT * FROM retail_sales
WHERE
    transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantiy IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

DELETE FROM retail_sales
WHERE
	  transactions_id IS NULL
    OR sale_date IS NULL
    OR sale_time IS NULL
    OR gender IS NULL
    OR category IS NULL
    OR quantiy IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;

-- Data Exploration 

-- How many sales we have
SELECT COUNT (*) as total_sales FROM retail_sales;

-- How many unique customers we have 
SELECT COUNT (DISTINCT customer_id) as total_customers FROM retail_sales; 
 
-- How many categories do we have?

SELECT COUNT (DISTINCT category) as total_categories FROM retail_sales; 

-- Categories 

SELECT DISTINCT category FROM retail_sales; 

-- Write an SQL Query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales as november_fifth
WHERE sale_date = '2022-11-05';

-- Write and SQL Query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT * 
	FROM retail_sales
WHERE category = 'Clothing'
AND 
TO_CHAR (sale_date, 'YYYY-MM') = '2022-11'
	AND quantiy >= 4; 

-- Write a SQL Query to calculate the total sales for each category

SELECT 
	category,
	SUM(total_sale) AS total_sales_per_category,
	COUNT (*) AS total_orders
FROM retail_sales
GROUP BY category;

-- Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

SELECT
	ROUND(AVG(age),0) AS avg_beauty_age
FROM retail_sales
	WHERE category = 'Beauty';

-- Write an SQL query to find all transactions where the total_sale id greater than 1000

SELECT *
	FROM retail_sales
WHERE total_sale >= 1000; 

-- Write an SQL query to find the total number of transactions made by each gender in each category

SELECT 
	category,
	gender,
	COUNT (*) as total_trans
FROM retail_sales 
	GROUP BY category, gender
	ORDER BY 1;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year


SELECT year,
		month,
		avg_sales
	FROM 
(
	SELECT 
		EXTRACT (YEAR FROM sale_date) as year,
		 EXTRACT( MONTH FROM sale_date) as month,
		ROUND(AVG(total_sale)) as avg_sales,
		RANK () OVER(PARTITION BY EXTRACT (YEAR FROM sale_date) ORDER BY AVG(total_sale)DESC) as rank
		FROM retail_sales
	GROUP BY 1, 2
	) as t1
WHERE rank = 1 









