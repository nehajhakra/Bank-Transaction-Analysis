SQL Bank Transactions Analysis 🚀
🔥 Project Overview
This project analyzes bank transactions data using SQL to gain insights into:
✅ High-value transactions above ₹10,000
✅ Customer spending patterns & trends
✅ CTEs & Window Functions for better analysis
✅ Ranking, Running Totals, Monthly Trends

📌 Skills Used: SQL | CTEs | Window Functions | Aggregations | Joins

📌 Database Schema
1️⃣ bank_transactions (Stores transaction data)
Column	Data Type	Description
transaction_id	VARCHAR(20)	Unique transaction ID
customer_id	INT	Customer's ID
transaction_date	DATE	Date of transaction
amount	DECIMAL(10,2)	Transaction amount
transaction_type	VARCHAR(10)	'Credit' or 'Debit'
account_type	VARCHAR(10)	'Savings' or 'Current'
location	VARCHAR(50)	Transaction location
status	VARCHAR(10)	'Success' or 'Failed'
2️⃣ customers (Stores customer details)
Column	Data Type	Description
customer_id	INT	Primary Key
customer_name	VARCHAR(100)	Customer’s Name
email	VARCHAR(100)	Email ID
phone_number	VARCHAR(20)	Contact Number
city	VARCHAR(50)	Customer's City
📌 🔥 SQL Queries & Insights
🔹 1. Identify High-Value Transactions (Above ₹10,000)
sql
Copy
Edit
SELECT * 
FROM bank_transactions 
WHERE amount > 10000 
ORDER BY amount DESC;
🔹 2. Rank Transactions Using RANK()
sql
Copy
Edit
WITH RankedTransactions AS (
    SELECT 
        transaction_id, 
        customer_id, 
        amount, 
        RANK() OVER (ORDER BY amount DESC) AS rank_value
    FROM bank_transactions
)
SELECT * FROM RankedTransactions;
🔹 3. Running Total of Transactions Per Customer
sql
Copy
Edit
SELECT 
    customer_id, 
    transaction_id, 
    amount, 
    SUM(amount) OVER (PARTITION BY customer_id ORDER BY transaction_date) AS running_total
FROM bank_transactions;
🔹 4. Find Customers with the Most Transactions
sql
Copy
Edit
SELECT customer_id, COUNT(*) AS total_transactions
FROM bank_transactions
GROUP BY customer_id
ORDER BY total_transactions DESC
LIMIT 5;
🔹 5. Monthly Transaction Trends
sql
Copy
Edit
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS month, 
       COUNT(*) AS transaction_count, 
       SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY month
ORDER BY month;
🔹 6. Customers Who Made Transactions in Multiple Cities
sql
Copy
Edit
SELECT customer_id, COUNT(DISTINCT location) AS unique_locations
FROM bank_transactions
GROUP BY customer_id
HAVING unique_locations > 1;
🔹 7. Join Customer Data with Transactions
sql
Copy
Edit
SELECT 
    c.customer_id, 
    c.customer_name, 
    b.transaction_id, 
    b.amount,  
    b.transaction_date
FROM customers c
INNER JOIN bank_transactions b ON c.customer_id = b.customer_id
ORDER BY b.transaction_date DESC
LIMIT 1000;
📌 🚀 SQL Features Used
✔ CTEs (WITH statements) – Improve readability and reusability
✔ Window Functions (RANK(), SUM() OVER()) – Advanced analytics
✔ Joins (INNER JOIN, LEFT JOIN) – Combine multiple tables
✔ Aggregations (COUNT(), SUM(), AVG()) – Data summarization
✔ Date Functions (DATE_FORMAT(), DATE_SUB()) – Time-based analysis

📌 🔗 How to Use This Project
1️⃣ Clone the Repo:




🔥 Ready to Transition into Data Analytics?
I built this SQL project to improve my skills in data analytics!
Would love to hear your feedback. 🚀

📢 Drop a comment below if you found this useful! 👇👇
