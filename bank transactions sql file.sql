CREATE TABLE bank_transactions (
    transaction_id VARCHAR(20) PRIMARY KEY,
    customer_id INT,
    transaction_date DATE,
    amount DECIMAL(10,2),
    transaction_type VARCHAR(10),
    account_type VARCHAR(10),
    location VARCHAR(50),
    status VARCHAR(10)
);

SHOW VARIABLES LIKE 'secure_file_priv';

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\bank_transactions.csv'
INTO TABLE bank_transactions
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(transaction_id, customer_id, transaction_date, amount, transaction_type, account_type, location, status);

-- 1. to View All Transactions
SELECT * FROM bank_transactions LIMIT 10;

-- 2 . Identify High-Value Transactions (Above ₹10,000)
SELECT * 
FROM bank_transactions 
WHERE amount > 10000 
ORDER BY amount DESC;

-- 3. Count Total Transactions
SELECT COUNT(*) AS total_transactions FROM bank_transactions;

-- 4. Count Unique Customers
SELECT COUNT(DISTINCT customer_id) AS total_customers FROM bank_transactions;

-- 5. Find Transactions from a Specific Location (e.g., Mumbai)
SELECT * 
FROM bank_transactions 
WHERE location = 'Mumbai';

-- 6. Find All ‘Failed’ Transactions
SELECT * 
FROM bank_transactions 
WHERE status = 'Failed';

-- 7. Find Total Transactions for Each Transaction Type (Credit vs Debit)
SELECT transaction_type, COUNT(*) AS transaction_count
FROM bank_transactions
GROUP BY transaction_type;

-- 8. Find the Total Amount Transacted (Credit vs Debit)
SELECT transaction_type, SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY transaction_type;

-- 9. Find Customers with the Most Transactions
SELECT customer_id, COUNT(*) AS total_transactions
FROM bank_transactions
GROUP BY customer_id
ORDER BY total_transactions DESC
LIMIT 5;

-- 10.Find the Top 5 Customers by Total Amount Spent
SELECT customer_id, SUM(amount) AS total_spent
FROM bank_transactions
GROUP BY customer_id
ORDER BY total_spent DESC
LIMIT 5;

-- 11. Identify Customers Who Made Transactions from Multiple Cities
SELECT customer_id, COUNT(DISTINCT location) AS unique_locations
FROM bank_transactions
GROUP BY customer_id
HAVING unique_locations > 1;

-- 12. Monthly Transaction Trends
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS month, 
       COUNT(*) AS transaction_count, 
       SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY month
ORDER BY month;

-- 13. Identify High-Value Transactions (Above ₹10,000)
SELECT * 
FROM bank_transactions 
WHERE amount > 10000 
ORDER BY amount DESC;

-- 14. Customers with No Transactions in the Last 3 Months
SELECT DISTINCT customer_id 
FROM bank_transactions 
WHERE transaction_date < DATE_SUB(CURDATE(), INTERVAL 3 MONTH);

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100),
    phone_number VARCHAR(20),
    address VARCHAR(255),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

SELECT DISTINCT customer_id 
FROM bank_transactions 
WHERE customer_id NOT IN (SELECT customer_id FROM customers);
INSERT INTO customers (customer_id)
SELECT DISTINCT customer_id 
FROM bank_transactions 
WHERE customer_id NOT IN (SELECT customer_id FROM customers);

ALTER TABLE bank_transactions ADD FOREIGN KEY (customer_id) REFERENCES customers(customer_id);

-- 15. Get customer details along with their transactions (INNER JOIN (Basic))
SELECT 
    c.customer_id, 
    c.customer_name, 
    b.transaction_id, 
    b.amount,  -- Use the correct column name
    b.transaction_date
FROM customers c
INNER JOIN bank_transactions b ON c.customer_id = b.customer_id
ORDER BY b.transaction_date DESC
LIMIT 1000;

-- 16 . LEFT JOIN (Include Customers Without Transactions)
SELECT 
    c.customer_id, 
    c.customer_name, 
    b.transaction_id, 
    b.amount, 
    b.transaction_date
FROM customers c
LEFT JOIN bank_transactions b ON c.customer_id = b.customer_id
ORDER BY c.customer_id;



-- 17. RIGHT JOIN (Include Transactions Without a Registered Customer)
SELECT 
    b.customer_id, 
    c.customer_name, 
    b.transaction_id, 
    b.amount, 
    b.transaction_date
FROM bank_transactions b
RIGHT JOIN customers c ON c.customer_id = b.customer_id
ORDER BY b.transaction_date DESC;

-- 18 . Basic CTE – List High-Value Transactions - Find transactions above ₹10,000 (or any threshold)
WITH HighValueTransactions AS (
    SELECT 
        transaction_id, 
        customer_id, 
        amount, 
        transaction_date
    FROM bank_transactions
    WHERE amount > 10000
)
SELECT * FROM HighValueTransactions;
-- 19. Assign a Rank to Transactions Based on Amount
SELECT * FROM (
    SELECT 
        transaction_id, 
        customer_id, 
        amount, 
        RANK() OVER (ORDER BY amount DESC) AS rank_value
    FROM bank_transactions
) AS ranked_results;

-- 20 . COUNT() OVER – Running Count of Transactions Per Customer
SELECT 
    customer_id, 
    transaction_id, 
    COUNT(*) OVER (PARTITION BY customer_id) AS total_transactions
FROM bank_transactions;



