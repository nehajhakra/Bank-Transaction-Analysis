# 📊 Bank Transaction Data Analysis using SQL

## 🔍 Project Overview  
This project performs **SQL-based analysis on bank transaction data** to extract key financial insights, customer behavior, and fraud detection patterns. The queries used help in analyzing **high-value transactions, failed transactions, customer spending trends, and much more**.

## ⚙️ Tech Stack  
- **Database:** MySQL  
- **Query Language:** SQL  
- **Visualization:** Power BI / Tableau *(optional)*

---  
## 📂 Dataset Description  
| Column Name        | Description                                  |
|--------------------|----------------------------------------------|
| `transaction_id`   | Unique ID for each transaction              |
| `customer_id`      | Unique ID for each customer                 |
| `transaction_date` | Date of the transaction                     |
| `amount`          | Transaction amount in ₹                      |
| `transaction_type` | Credit / Debit                              |
| `account_type`    | Savings / Current / Other                    |
| `location`        | City where transaction occurred              |
| `status`          | Success / Failed                             |

---  
## 📝 SQL Queries & Insights  

### 🔹 1. Identifying High-Value Transactions (Above ₹10,000)
```sql
SELECT * FROM bank_transactions
WHERE amount > 10000
ORDER BY amount DESC;
```
**📊 Insight:** Helps identify **big spenders** and flag **suspicious transactions**.

### 🔹 2. Counting Total Transactions  
```sql
SELECT COUNT(*) AS total_transactions FROM bank_transactions;
```
**📊 Insight:** Understand overall transaction volume.

### 🔹 3. Finding Transactions from a Specific Location (e.g., Mumbai)  
```sql
SELECT * FROM bank_transactions WHERE location = 'Mumbai';
```
**📊 Insight:** Helps analyze spending patterns in different cities.

### 🔹 4. Identifying Failed Transactions  
```sql
SELECT * FROM bank_transactions WHERE status = 'Failed';
```
**📊 Insight:** Can be used to **detect transaction failures** due to technical issues or fraud.

### 🔹 5. Monthly Transaction Trends  
```sql
SELECT DATE_FORMAT(transaction_date, '%Y-%m') AS month,
       COUNT(*) AS transaction_count,
       SUM(amount) AS total_amount
FROM bank_transactions
GROUP BY month
ORDER BY month;
```
**📊 Insight:** Helps banks plan for **peak transaction periods**.

### 🔹 6. Customers Transacting from Multiple Cities  
```sql
SELECT customer_id, COUNT(DISTINCT location) AS unique_locations
FROM bank_transactions
GROUP BY customer_id
HAVING unique_locations > 1;
```
**📊 Insight:** Can help detect **traveling customers** or **fraudulent behavior**.

---
## 🌟 How to Use This Project  
1. Clone this repository:
```sh
git clone https://github.com/yourusername/Bank-Transaction-Analysis.git
```
2. Import the SQL file into **MySQL**.
3. Run the queries to explore the dataset.

---  
## 👀 Future Enhancements  
- ✅ **Integrate Power BI / Tableau for better visualization**  
- ✅ **Apply Machine Learning for fraud detection**  
- ✅ **Expand dataset for deeper insights**  

---  

---  


