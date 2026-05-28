/*
     AGGREGATIONS 
*/

-- NULL QUERIES
-- find customers with NULL email
SELECT * from customers
where email IS NULL;

-- find customers with non-NULL email
SELECT * from customers
where email IS NOT NULL;

-- COUNT()
-- Total customers
SELECT COUNT(*) "total_customers" 
from customers;

-- Count customers from New York
SELECT COUNT(*) as New_York_Customers
from customers
where city = 'New York';

-- COUNT with NULL
-- COUNT(column_name) ignores NULL values.
SELECT COUNT(email) from customers;

/*
    SUM()
*/

-- Total account balance
Select SUM(current_balance) as total_balance
from accounts;

-- Totalloan amount
SELECT SUM(principal_amount)
from loans;

/*
    MIN()
*/
--  MINIMUM Balance
SELECT MIN(current_balance) AS minimum_balance
FROM accounts;

-- Lowest Loan amount
Select MIN(principal_amount) from loans;

/*
   MAX()
*/

--  Highest balance
SELECT MAX(current_balance) AS highest_balance
FROM accounts;

-- Maximum Loan amount
SELECT MAX(principal_amount)
FROM loans;

/*
   AVG
*/

--  Average account balance
SELECT AVG(current_balance) AS average_balance
FROM accounts;

-- Average Loan Amount 
Select AVG(principal_amount) from loans;

/*
   DISTINCT
*/
-- Unique cities
SELECT DISTINCT city FROM customers;

-- Unique account types
SELECT DISTINCT account_type
FROM accounts;

/* 
    GROUP BY
*/

-- Count customers city-wise
SELECT city,
       COUNT(*) AS total_customers
FROM customers
GROUP BY city;

-- Total balance by account type
SELECT account_type,
       SUM(current_balance) AS total_balance
FROM accounts
GROUP BY account_type;

-- Average loan by loan type
SELECT loan_type,
       AVG(principal_amount) AS average_loan
FROM loans
GROUP BY loan_type;

/*
    HAVING CLAUSE
** HAVING filters grouped data
*/

-- Cities having more than 5 customers
SELECT city,
       COUNT(*) AS total_customers
FROM customers
GROUP BY city
HAVING COUNT(*) > 5;

-- Account types with total balance > 1 lakh
SELECT account_type,
       SUM(current_balance) AS total_balance
FROM accounts
GROUP BY account_type
HAVING SUM(current_balance) > 100000;

/*
    DATE Functions
*/

-- Current date
Select CURRENT_DATE;

-- Current timestamp
select CURRENT_TIMESTAMP;

-- Extract year from transaction date
SELECT transaction_id,
       EXTRACT(YEAR FROM transaction_timestamp) AS year
FROM transactions;

-- Extract month
SELECT transaction_id,
       EXTRACT(MONTH FROM transaction_timestamp) AS month
FROM transactions;

-- Transactions in 2025
SELECT *
FROM transactions
WHERE EXTRACT(YEAR FROM transaction_timestamp) = 2025;

-- Date difference
SELECT CURRENT_DATE - opened_date AS days_active
FROM accounts;

/*
    CASE Statement
*/
-- Balance category
SELECT account_id,
       current_balance,
       CASE
           WHEN current_balance > 100000 THEN 'High Balance'
           WHEN current_balance BETWEEN 50000 AND 100000 THEN 'Medium Balance'
           ELSE 'Low Balance'
       END AS balance_category
FROM accounts;

-- Loan status category
SELECT loan_id,
       principal_amount,
       CASE
           WHEN principal_amount > 500000 THEN 'Large Loan'
           ELSE 'Small Loan'
       END AS loan_category
FROM loans;

/*
    Aggregations with JOINS
*/
-- Total Balance per customers
SELECT c.first_name,
       SUM(a.current_balance) AS total_balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
GROUP BY c.first_name;

-- Average transaction amount per customer
SELECT c.first_name,
       AVG(t.amount) AS avg_transaction
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
JOIN transactions t
ON a.account_id = t.account_id
GROUP BY c.first_name;

/*
    GROUP BY + HAVING + ORDER BY
*/
-- Top cities by customers
SELECT city,
       COUNT(*) AS total_customers
FROM customers
GROUP BY city
HAVING COUNT(*) > 2
ORDER BY total_customers DESC;

-- Multiple Aggregations Together
SELECT
    COUNT(*) AS total_accounts,
    SUM(current_balance) AS total_balance,
    AVG(current_balance) AS average_balance,
    MIN(current_balance) AS minimum_balance,
    MAX(current_balance) AS maximum_balance
FROM accounts;

/*
   NULL Handling with COALESCE
*/
-- Replace NULL values
SELECT first_name,
       COALESCE(email, 'No Email') AS email
FROM customers;

-- TRANSACTION SUMMARY
SELECT transaction_type,
       COUNT(*) AS total_transactions,
       SUM(amount) AS total_amount,
       AVG(amount) AS average_amount
FROM transactions
GROUP BY transaction_type;

-- BRANCH-WISE Account Summary
SELECT branch_id,
       COUNT(*) AS total_accounts,
       SUM(current_balance) AS total_balance
FROM accounts
GROUP BY branch_id;

-- Loan Summary with CASE
SELECT
    CASE
        WHEN principal_amount > 500000 THEN 'High'
        ELSE 'Low'
    END AS loan_category,
    COUNT(*) AS total_loans
FROM loans
GROUP BY loan_category;