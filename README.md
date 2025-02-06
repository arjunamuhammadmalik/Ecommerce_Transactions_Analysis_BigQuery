# 📊 E-Commerce Transactions Analysis with Google BigQuery

## 📌 Overview
This project contains SQL queries used to analyze e-commerce transactions using **Google BigQuery**. The dataset includes customer purchases, store performance, product sales, and revenue insights.

## 📂 Dataset
The dataset consists of e-commerce transactions with the following columns:
- `transaction_id` (INT64) – Unique transaction identifier
- `store` (STRING) – Online or offline store type
- `customer_id` (INT64) – Unique customer identifier
- `customer_city` (STRING) – City where the customer resides
- `customer_gender` (STRING) – Gender of the customer (Male/Female)
- `product_id` (INT64) – Unique product identifier
- `product_price` (FLOAT64) – Price per product unit
- `quantity` (INT64) – Number of items purchased
- `total` (FLOAT64) – Total transaction amount
- `created_at` (DATE) – Transaction date

## 📊 SQL Queries
Below are the key SQL queries used for analysis:

### 1️⃣ **Total Transactions Per Store**
```sql
SELECT 
    store,
    COUNT(transaction_id) AS total_transactions,
    ROUND(AVG(total), 2) AS average_total,
    COUNT(DISTINCT customer_id) AS unique_customers
FROM `ecommerce_transaction.sales`
GROUP BY store
ORDER BY total_transactions DESC;
```
🔹 Displays total transactions, average spending, and unique customers per store.

### 2️⃣ **Best-Selling Products by Quantity**
```sql
SELECT 
    product_id,
    SUM(quantity) AS total_quantity,
    ROUND(SUM(total), 2) AS total_revenue
FROM `ecommerce_transaction.sales`
GROUP BY product_id
ORDER BY total_quantity DESC
LIMIT 10;
```
🔹 Identifies top 10 best-selling products by quantity.

### 3️⃣ **Top 10 High-Spending Customers**
```sql
SELECT 
    customer_id,
    customer_city,
    customer_gender,
    COUNT(transaction_id) AS total_transactions,
    ROUND(SUM(total), 2) AS total_spent
FROM `ecommerce_transaction.sales`
GROUP BY customer_id, customer_city, customer_gender
ORDER BY total_spent DESC
LIMIT 10;
```
🔹 Lists the top 10 customers with the highest spending.

### 4️⃣ **Daily Revenue Analysis**
```sql
SELECT 
    DATE(created_at) AS transaction_date,
    ROUND(SUM(total), 2) AS daily_revenue,
    COUNT(transaction_id) AS total_transactions
FROM `ecommerce_transaction.sales`
GROUP BY transaction_date
ORDER BY transaction_date ASC;
```
🔹 Tracks daily revenue trends.

### 5️⃣ **Revenue Distribution by Gender**
```sql
SELECT 
    customer_gender,
    COUNT(transaction_id) AS total_transactions,
    ROUND(SUM(total), 2) AS total_revenue,
    ROUND(AVG(total), 2) AS average_revenue
FROM `ecommerce_transaction.sales`
GROUP BY customer_gender
ORDER BY total_revenue DESC;
```
🔹 Compares transaction volume and revenue contribution by gender.

### 6️⃣ **Average Quantity per Transaction by City**
```sql
SELECT 
    customer_city,
    ROUND(AVG(quantity), 2) AS avg_quantity_per_transaction
FROM `ecommerce_transaction.sales`
GROUP BY customer_city
ORDER BY avg_quantity_per_transaction DESC
LIMIT 10;
```
🔹 Displays the top 10 cities with the highest average product quantity per transaction.

### 7️⃣ **Most Profitable Products**
```sql
SELECT 
    product_id,
    SUM(quantity * (product_price * 0.2)) AS total_profit,
    ROUND(SUM(total), 2) AS total_revenue,
    SUM(quantity) AS total_quantity_sold
FROM `ecommerce_transaction.sales`
GROUP BY product_id
ORDER BY total_profit DESC
LIMIT 10;
```
🔹 Identifies the top 10 products generating the highest profit margin.

### 8️⃣ **Monthly Sales Trends**
```sql
SELECT 
    EXTRACT(YEAR FROM created_at) AS year,
    EXTRACT(MONTH FROM created_at) AS month,
    ROUND(SUM(total), 2) AS total_revenue,
    COUNT(transaction_id) AS total_transactions
FROM `ecommerce_transaction.sales`
GROUP BY year, month
ORDER BY year ASC, month ASC;
```
🔹 Shows revenue and transaction trends on a monthly basis.

### 9️⃣ **Inactive Customers (Single Transaction Only)**
```sql
SELECT 
    customer_id,
    customer_city,
    customer_gender,
    ROUND(SUM(total), 2) AS total_spent,
    COUNT(transaction_id) AS total_transactions
FROM `ecommerce_transaction.sales`
GROUP BY customer_id, customer_city, customer_gender
HAVING total_transactions = 1
ORDER BY total_spent DESC;
```
🔹 Identifies customers who have only made one purchase.

## 🔗 Resources
- **Google BigQuery Docs**: [https://cloud.google.com/bigquery/docs](https://cloud.google.com/bigquery/docs)
- **SQL Reference**: [https://cloud.google.com/bigquery/docs/reference/standard-sql](https://cloud.google.com/bigquery/docs/reference/standard-sql)

---
🔹 **Author:** Arjuna Muhammad Malik  
🔹 **Tools Used:** Google BigQuery 
🔹 **Date:** February 2025
