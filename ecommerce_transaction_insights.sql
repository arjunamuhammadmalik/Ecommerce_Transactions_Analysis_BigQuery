--Transaction Analysis per Store
--Displays total transactions, average purchase total, and unique customers per store.
SELECT 
    store,
    COUNT(transaction_id) AS total_transactions,
    ROUND(AVG(total), 2) AS average_total,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM 
    `ecommerce_transaction.sales`
GROUP BY 
    store
ORDER BY 
    total_transactions DESC;

-------------------------------------------------------------------------------------------
--Best-Selling Products by Quantity
--Identifies the most sold products based on the quantity.
SELECT 
    product_id,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(total), 2) AS total_revenue
FROM 
    `ecommerce_transaction.sales`
GROUP BY 
    product_id
ORDER BY 
    total_quantity DESC
LIMIT 10;

-------------------------------------------------------------------------------------------
--Active Customer Analysis
--Displays the top 10 customers with the highest spending.
SELECT 
    customer_id,
    customer_city,
    customer_gender,
    COUNT(transaction_id) AS total_transactions,
    ROUND(SUM(total), 2) AS total_spent
FROM 
    `ecommerce_transaction.sales`
GROUP BY 
    customer_id, customer_city, customer_gender
ORDER BY 
    total_spent DESC
LIMIT 10;

-------------------------------------------------------------------------------------------
--Daily Revenue
--Displays daily revenue across all stores.
SELECT 
    DATE(created_at) AS transaction_date,
    ROUND(SUM(total), 2) AS daily_revenue,
    COUNT(transaction_id) AS total_transactions
FROM 
    `ecommerce_transaction.sales`
GROUP BY 
    transaction_date
ORDER BY 
    transaction_date ASC;

-------------------------------------------------------------------------------------------
--Sales Analysis by Gender
--Shows revenue distribution based on customer gender.
SELECT 
    customer_gender,
    COUNT(transaction_id) AS total_transactions,
    ROUND(SUM(total), 2) AS total_revenue,
    ROUND(AVG(total), 2) AS average_revenue
FROM 
    `ecommerce_transaction.sales`
GROUP BY 
    customer_gender
ORDER BY 
    total_revenue DESC;

-------------------------------------------------------------------------------------------
--Average Quantity per Transaction by City
--Analyzes the average quantity of products purchased per transaction in each city.
SELECT 
    customer_city,
    ROUND(AVG(quantity), 2) AS avg_quantity_per_transaction
FROM 
    `ecommerce_transaction.sales`
GROUP BY 
    customer_city
ORDER BY 
    avg_quantity_per_transaction DESC
LIMIT 10;

-------------------------------------------------------------------------------------------
--Most Profitable Products
--Analyzes products with the highest profit margins, assuming a 20% margin on product price.
SELECT 
    product_id,
    ROUND(SUM(quantity * (product_price * 0.2))) AS total_profit,
    ROUND(SUM(total), 2) AS total_revenue,
    SUM(quantity) AS total_quantity_sold
FROM 
    `ecommerce_transaction.sales`
GROUP BY 
    product_id
ORDER BY 
    total_profit DESC
LIMIT 10;

-------------------------------------------------------------------------------------------
--Monthly Sales Trends    
--Analyzes total revenue and transactions by month.
SELECT 
    EXTRACT(YEAR FROM created_at) AS year,
    EXTRACT(MONTH FROM created_at) AS month,
    ROUND(SUM(total), 2) AS total_revenue,
    COUNT(transaction_id) AS total_transactions
FROM 
    `ecommerce_transaction.sales`
GROUP BY 
    year, month
ORDER BY 
    year ASC, month ASC;

-------------------------------------------------------------------------------------------
--Identify Inactive Customers
--Finds customers who have only made a single transaction.
SELECT 
    customer_id,
    customer_city,
    customer_gender,
    ROUND(SUM(total), 2) AS total_spent,
    COUNT(transaction_id) AS total_transactions
FROM 
    `ecommerce_transaction.sales`
GROUP BY 
    customer_id, customer_city, customer_gender
HAVING 
    total_transactions = 1
ORDER BY 
    total_spent DESC;

-------------------------------------------------------------------------------------------
