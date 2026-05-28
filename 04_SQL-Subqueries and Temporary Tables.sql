/*
-----------------------------------------------------------
|       SubQuery           |         JOINS                 |
-----------------------------------------------------------
|  Easier to read          |   Faster for large datasets   |

| Better for filtering     |  Better for combining tables  |

| Can be slower            |  Usually optimized            |

*/

/*
    Basic Subquery
  -------------------
  A query inside another query
*/

-- Find customers having balance greater than average balance 
SELECT *
FROM accounts
WHERE current_balance >
(
    SELECT AVG(current_balance)
    FROM accounts
);

/*
    Scalar Subquery
   ------------------
 Returns only ONE value
*/

-- Highest Loan Amount
SELECT customer_id,
       principal_amount
FROM loans
WHERE principal_amount =
(
    SELECT MAX(principal_amount)
    FROM loans
);

/*
   Nested Subquery
 --------------------
Subquery inside another subquery
*/

-- Customers with highest account balance
SELECT first_name, last_name
FROM customers
WHERE customer_id =
(
    SELECT customer_id
    FROM accounts
    WHERE current_balance =
    (
        SELECT MAX(current_balance)
        FROM accounts
    )
);

/*
    IN Subquery
  ----------------
Customers who took loans 
*/
SELECT *
FROM customers
WHERE customer_id IN
(
    SELECT customer_id
    FROM loans
);

/*
     NOT IN Subquery
   --------------------
 Customers without loans
*/
SELECT *
FROM customers
WHERE customer_id NOT IN
(
    SELECT customer_id
    FROM loans
);

/*
    EXISTS Subquery
  --------------------
   Checks existence
*/
-- Customers having transactions
SELECT *
FROM customers c
WHERE EXISTS
(
    SELECT 1
    FROM accounts a
    WHERE c.customer_id = a.customer_id
);

/*
    Correlated Subquery (Dependent Subquery)
  --------------------------------------------
 Inner query depends on outer query
*/

-- Accounts having balance above customer average
SELECT account_id,
       customer_id,
       current_balance
FROM accounts a1
WHERE current_balance >
(
    SELECT AVG(current_balance)
    FROM accounts a2
    WHERE a1.customer_id = a2.customer_id
);

/*
    Inline Subquery(Derived Table)
   ---------------------------------
  Subquery inside FROM clause
*/

-- Average Balance by branch
SELECT branch_id,
       AVG(total_balance)
FROM
(
    SELECT branch_id,
           Current_balance AS total_balance
    FROM accounts
) AS temp_table
GROUP BY branch_id;

/*
    WITH Clause (CTE)
   -------------------
  Common Table Expression
  
*/

-- HIGH Balance accounts
WITH high_balance_accounts AS
(
    SELECT *
    FROM accounts
    WHERE current_balance < 100000
)
SELECT *
FROM high_balance_accounts;

/*
    Multiple CTEs
*/

WITH customer_accounts AS
(
    SELECT customer_id,
           SUM(current_balance) AS total_balance
    FROM accounts
    GROUP BY customer_id
),
high_value_customers AS
(
    SELECT *
    FROM customer_accounts
    WHERE total_balance > 100000
)
SELECT *
FROM high_value_customers;

/* 
     Real-World Temporary Table 
	-----------------------------
 Fraud detection staging 
*/

CREATE TEMP TABLE suspicious_transactions AS
SELECT *
FROM transactions
WHERE amount > 500000;

/*
    SQL Views
  --------------
 Views are virtual tables
*/

-- Create View
CREATE VIEW customer_account_summary AS
SELECT c.first_name,
       a.account_type,
       a.current_balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id;

-- Query view
SELECT *
FROM customer_account_summary;

/*
   Branch performance view
*/
CREATE VIEW branch_summary AS
SELECT branch_id,
       COUNT(*) AS total_accounts,
       SUM(current_balance) AS total_balance
FROM accounts
GROUP BY branch_id;

/*
    Deep Dive: JOIN + Subquery
   -----------------------------
 Highest balance customer details
*/

SELECT c.first_name,
       a.current_balance
FROM customers c
JOIN accounts a
ON c.customer_id = a.customer_id
WHERE a.current_balance =
(
    SELECT MAX(current_balance)
    FROM accounts
);

/* 
     Aggregate Subquery
    ---------------------
Customers with above-average loan
*/
SELECT *
FROM loans
WHERE principal_amount >
(
    SELECT AVG(principal_amount)
    FROM loans
);

/*
    Detect inactive customers
*/ 
SELECT *
FROM customers
WHERE customer_id NOT IN
(
    SELECT DISTINCT customer_id
    FROM accounts
);

/* Temporary Table + JOIN */
CREATE TEMP TABLE rich_customers AS
SELECT customer_id,
       SUM(current_balance) AS total_balance
FROM accounts
GROUP BY customer_id
HAVING SUM(current_balance) > 500000;

SELECT c.first_name,
       r.total_balance
FROM customers c
JOIN rich_customers r
ON c.customer_id = r.customer_id;
