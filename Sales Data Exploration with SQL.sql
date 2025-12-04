-- ***********************************************************************
-- DATA CLEANING
-- ***********************************************************************

    SELECT COUNT(*) as count_dup
FROM sales_info
GROUP BY 
order_id, order_date, ship_date, customer, manufactory, product_id, segment, category, 
subcategory, region, zip, city, state, country, discount, profit,
quantity, sales, profit_margin
HAVING COUNT(*) > 1;

-- ***********************************************************************
-- DATA EXPLORATION
-- ***********************************************************************

-- QUESTIONS NEEDED
	-- total number of customers
    -- Generate total sales 
	-- Generate quantity in each year
	-- Generate total sales in each year
    -- Generate Highest single sales in each year
    -- Total discount and average discount
    -- Total profit and average profit
    -- find customer with highest sales
    -- find customer with lowest sales
    -- year with highest sales 
	-- year with lowest sales 
    -- state with the most customer
	-- state with the least customer
    -- total sales of each customer
    -- product bought by each customer
    -- generate category and subcategory of each customer
    -- categorize each customer based on region
    -- total number of customer in each region
    -- distict manufactory and product name 
    
SELECT *
from sales_info;

-- total number of customers
SELECT
	count(customer)
from sales_info;

-- Generate total sales 
select 
	sum(sales) as total_sales
from sales_info;

-- Generate total quantity in each year

-- total quantitity for year (2019)

SELECT  SUM(quantity) AS total_quantity_2019
FROM sales_info
WHERE YEAR(order_date) = 2019;

-- total quantity for year (2020)
SELECT  SUM(quantity) AS total_quantity_2020
FROM sales_info
WHERE YEAR(order_date) = 2020;

-- total quantities for year (2021)
select sum(quantity)
from sales_info
where Year(order_date) = 2021;

-- total quantity for year (2022)
select 
    sum(quantity) as total_quantity
from sales_info
where year(order_date) = 2022;

-- Generate total sales in each year

-- total sales in 2019
select 
    sum(sales) as total_sales
from sales_info
WHERE YEAR(order_date) = 2019;

-- total sales in 2020
select 
    sum(sales) as total_sales
from sales_info
WHERE YEAR(order_date) = 2020;

-- all total sales in 2021
select 
    sum(sales) as total_sales
from sales_info
where year(order_date) = 2021;

-- all total sales in 2022
select 
    sum(sales) as total_sales
from sales_info
where year(order_date) = 2022;

-- Highest single sales in each year 

-- highest single sales in 2019
select max(sales)
from sales_info
WHERE order_date >= '2019-01-01' 
  AND order_date < '2020-01-01';

-- highest sales in 2020
select max(sales)
from sales_info
where order_date >= '2020-01-01'
and order_date < '2021-01-01';

-- highest single sales in 2021
select 
    max(sales) as total_sales
from sales_info
where year(order_date) = 2021;

-- highest single sales in 2022
select 
    max(sales) as total_sales
from sales_info
where year(order_date) = 2022;

-- Total discount and average discount

select sum(discount) as total_discount, 
avg(discount) as avg_discount
from sales_info;

-- Total profit and average profit

select sum(profit) as total_profit, 
avg(profit) as avg_profit
from sales_info;

-- find customer with highest sales
SELECT customer, 
sales
from sales_info
GROUP BY customer, sales
order by sales desc
LIMIT 1;

-- find customer with lowest sales
SELECT customer, 
sales
from sales_info
GROUP BY customer, sales
order by sales 
LIMIT 1;

-- year with highest sales 
SELECT year(order_date),
 sum(sales) as total_sales
from sales_info
group by year(order_date) 
order by total_sales DESC
LIMIT 1;

-- year with lowest sales 
SELECT year(order_date),
 sum(sales) as total_sales
from sales_info
group by year(order_date) 
order by total_sales 
LIMIT 1;


-- state with the most customer
WITH state_counts AS (
    SELECT state, COUNT(DISTINCT customer) AS total_customers
    FROM sales_info
    GROUP BY state
),
max_count AS (
    SELECT MAX(total_customers) AS max_customers
    FROM state_counts
)
SELECT sc.state, sc.total_customers
FROM state_counts sc
JOIN max_count mc
    ON sc.total_customers = mc.max_customers; -- this allows ties

SELECT state, 
       COUNT(DISTINCT customer) AS total_customers
FROM sales_info
GROUP BY state
ORDER BY total_customers DESC
LIMIT 1;                                   -- this does not

-- state with the least customer
WITH state_counts AS (
    SELECT state, COUNT(DISTINCT customer) AS total_customers
    FROM sales_info
    GROUP BY state
),
min_count AS (
    SELECT MIN(total_customers) AS min_customers
    FROM state_counts
)
SELECT sc.state, sc.total_customers
FROM state_counts sc
JOIN min_count mc
    ON sc.total_customers = mc.min_customers; -- this allows ties
    
SELECT state, 
       COUNT(DISTINCT customer) AS total_customers
FROM sales_info
GROUP BY state
ORDER BY total_customers 
LIMIT 1;                                   -- this does not

-- total sales of each customer
SELECT customer,
 sum(sales) as total_sales
from sales_info
group by customer
order by total_sales desc;

-- product bought by each customer
SELECT DISTINCT 
customer, 
product_id 
from sales_info
group by customer, product_id
order by customer, product_id; -- full list, not aggregated

SELECT customer, GROUP_CONCAT(DISTINCT product_id) AS products_bought
FROM sales_info
GROUP BY customer
ORDER BY customer;           -- full list, aggregated

-- generate category and subcategory of each customer
SELECT 
DISTINCT 
customer, 
category,
 subcategory
from sales_info
GROUP BY customer, category, subcategory
order by customer, category, subcategory;

-- categorize each customer based on region
SELECT
customer,
 region
from sales_info
GROUP BY customer, region
order by customer;

-- total number of customer in each region

SELECT 
region,
 count(distinct customer) as total_customers 
from sales_info
group by region
order by total_customers desc ;

-- distict manufactory and product name 
select 
DISTINCT
manufactory, 
product_id 
FROM sales_info
order by manufactory, product_id;