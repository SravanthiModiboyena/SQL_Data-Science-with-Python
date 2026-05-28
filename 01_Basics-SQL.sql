-- Check all tables Exist 
SELECT table_name
from information_schema.tables
where table_schema = 'public';

-- Checking which tables have data

-- Branches
SELECT 'branches' AS table_name, COUNT(*) FROM branches
UNION ALL

-- Customers
SELECT 'customers', COUNT(*) FROM customers
UNION ALL

-- employees
SELECT 'employees', COUNT(*) FROM employees
UNION ALL

-- accounts
SELECT 'accounts', COUNT(*) FROM accounts
UNION ALL

-- transactions
SELECT 'transactions', COUNT(*) FROM transactions
UNION ALL

-- loans
SELECT 'loans', COUNT(*) FROM loans
UNION ALL

-- loan_payments
SELECT 'loan_payments', COUNT(*) FROM loan_payments
UNION ALL

-- Cards
SELECT 'cards', COUNT(*) FROM cards
UNION ALL

-- Card_transactions
SELECT 'card_transactions', COUNT(*) FROM card_transactions
UNION ALL

-- fraud_alerts
SELECT 'fraud_alerts', COUNT(*) FROM fraud_alerts;

/*
1. Select Clause
*/
-- Select all columns

SELECT * from customers;
-- Select specific columns
SELECT customer_id, first_name, city from customers;

/*
2.Where Clause
*/
-- Numeric Condition
SELECT * from accounts
where current_balance > 50000;
-- Non-Numeric condition
SELECT * from customers
where city = 'New York';

/*
3.Order By
*/
-- Ascending
Select * From accounts
Order by current_balance asc;

-- Descending
Select * from accounts 
order by current_balance Desc;

/*
4.LIMIT
*/
-- Top 5 rows
Select * from customers LIMIT 5;
-- Highest 10 balances
Select * from accounts 
order by current_balance desc
LIMIT 10;

/*
5.Arithmetic Operators
*/
-- Add amount
Select account_id, 
       current_balance, 
	   current_balance + 1000 as updated_balance 
from accounts;

-- Interest calculation
Select loan_id,
       principal_amount,
			  interest_rate,
			  principal_amount * interest_rate as final_amount
from loans;
-- Subtract amount
select account_id,
       current_balance,
	   current_balance - 1000 as remaining_balance
from accounts;
	   
/*
6. Like Operator
*/
-- Names starts with s
Select * from customers
where first_name LIKE 'S%';
-- Names end with a 
Select * from customers 
where last_name Like '%a';

/*
7.IN Operator
*/
Select * from customers
where city IN ('New York','Columbus','Chicago');

/*
8. NOT Operator
*/
Select * from customers 
where NOT city = 'New York';

/*
9.BETWEEN
*/
-- Balance Range
Select * from accounts 
where current_balance BETWEEN 10000 AND 50000;

-- Loan Amount range
Select * from loans
where principal_amount BETWEEN 200000 AND 500000;

/*
10. AND Operator
*/
Select * From customers
where city = 'Chicago' AND credit_score <= 500;

/*
11. OR Operator
*/
Select Customer_id,
       first_name,
	   last_name,
	   city,
	   credit_score
	   from customers 
where city = 'New York' or city ='Chicago';









