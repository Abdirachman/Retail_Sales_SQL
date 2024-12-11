-- SQL retail sales analysis
CREATE DATABASE retail_sales;

 CREATE TABLE retail_sales
(
    transactions_id INT PRIMARY KEY,
    sale_date DATE,	
    sale_time TIME,
    customer_id INT,	
    gender VARCHAR(10),
    age INT,
    category VARCHAR(35),
    quantity INT,
    price_per_unit FLOAT,	
    cogs FLOAT,
    total_sale FLOAT
);


								-- 1.Record Count: Determine the total number of records in the dataset.

SELECT count(*)
FROM retail_sales1;

																-- DATA CLEANING
								-- 2.Null Value Check: Check for any null values in the dataset and delete records with missing data.

SELECT *
FROM retail_sales1
WHERE 
		transactions_id IS NULL
	OR 	sale_date IS NULL
	OR 	customer_id IS NULL
	OR 	sale_time IS NULL
	OR 	gender IS NULL	
	OR 	age IS NULL
	OR 	category IS NULL
	OR 	quantiy IS NULL
	OR 	price_per_unit IS NULL
	OR 	cogs IS NULL
	OR 	total_sale IS NULL;
		
        
DELETE FROM retail_sales1
WHERE 
		transactions_id IS NULL
	OR 	sale_date IS NULL
	OR 	customer_id IS NULL
	OR 	sale_time IS NULL
	OR 	gender IS NULL	
	OR 	age IS NULL
	OR 	category IS NULL
	OR 	quantiy IS NULL
	OR 	price_per_unit IS NULL
	OR 	cogs IS NULL
	OR 	total_sale IS NULL;
    
    
    
																	-- DATA EXPLORATION
											-- 1. Customer Count: Find out how many unique customers are in the dataset.

SELECT COUNT(DISTINCT(customer_id))
FROM retail_sales1;

											-- 2.Category Count: Identify all unique product categories in the dataset.

SELECT DISTINCT(category)
FROM retail_sales1; 
    
														-- Data Analysis & Buisness Key Problems & Answers
    
--- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:

    
    SELECT*
    FROM retail_sales1
    WHERE sale_date = '2022-11-05';
     
	
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
    
SELECT*
FROM retail_sales1
WHERE category = 'Clothing'
AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
AND quantiy >= 4;

    -- 3. Write a SQL query to calculate the total sales (total_sale) for each category:
    SELECT category, sum(total_sale), count(total_orders)
    FROM retail_sales1
    GROUP BY 1;
    
    -- 4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
    
    SELECT 
			ROUND(AVG (age),2) as avg_age
     FROM retail_sales1
     WHERE category = 'beauty';
    
    
    -- 5. Write a SQL query to find all transactions where the total_sale is greater than 1000
    
    
    SELECT *
    FROM retail_sales1
    WHERE total_sale > 1000;
    
    -- 6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category
    
    SELECT category, gender, COUNT(transactions_id) AS transactions_per_gender
      FROM retail_sales1
      GROUP BY category, gender
      ORDER BY 1;
    
    -- 7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
    SELECT *
    FROM(
    SELECT 
    YEAR(sale_date ) as year,
    MONTH(sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK()OVER(PARTITION BY year(sale_date) order by AVG(total_sale) desc) as ranking
      FROM retail_sales1
    GROUP BY 1,2
    )t1
    WHERE ranking = 1;
    
    
    
    SELECT *
FROM retail_sales1;
    -- Write a SQL query to find the top 5 customers based on the highest total sales 
    
    SELECT customer_id,
    sum(total_sale) as total_sale1
    FROM  retail_sales1
    GROUP BY customer_id
    ORDER BY total_sale1 desc
    LIMIT 5;
    
    
  -- Write a SQL query to find the number of unique customers who purchased items from each category  
    
    
    SELECT count(DISTINCT customer_id) as unique_customers, category
    FROM retail_sales1
    GROUP BY category;
    
    -- Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
    
    SELECT count(quantiy) as no_of_orders,
    HOUR(sale_time) as shift_time
    FROM retail_sales1
    GROUP BY sale_time
    ORDER BY shift_time;
    
  WITH cte
  AS(
		SELECT *,
		CASE 
			WHEN HOUR(sale_time) <12 THEN 'morning'
			WHEN HOUR (sale_time)  BETWEEN 12 AND 17 THEN'afternoon'
			ELSE 'evening'
	END as shift
		from retail_sales1
	)
    SELECT 
    count(transactions_id) as total_orders,
shift
    FROM cte
    GROUP BY shift;
    
    -- End of project
    
    
    
    