/*
   Data cleaning means:
  ----------------------
 * fixing incorrect data
 * handling NULL values
 * removing duplicates
 * formatting text properly
 * converting data types
 * standardizing values

 Commonly Used Cleaning Functions

 | Function          | Purpose                  |
| ----------------- | ------------------------ |
| TRIM              | Remove spaces            |
| LOWER             | Lowercase                |
| UPPER             | Uppercase                |
| INITCAP           | Capitalize               |
| LEFT              | Extract left characters  |
| RIGHT             | Extract right characters |
| SUBSTRING         | Extract part of text     |
| SPLIT_PART        | Split string             |
| CONCAT            | Combine text             |
| CAST              | Change datatype          |
| COALESCE          | Handle NULL              |
| POSITION / STRPOS | Find character position  |

*/

/*
   TRIM()
  ---------
  Removes extra spaces
*/
SELECT first_name,
       TRIM(first_name) AS cleaned_name
FROM customers;

-- LOWER()
-- Convert to lowercase
SELECT LOWER(city)
FROM customers;

-- UPPER()
-- Convert to uppercase
SELECT UPPER(city)
FROM customers;

-- INITCAP()
--  Capitalize first letter
SELECT INITCAP(first_name)
FROM customers;

-- LEFT()
-- Extract characters from left
SELECT first_name,
       LEFT(first_name, 3)
FROM customers;

-- RIGHT()
-- Extract characters from right
SELECT phone,
       RIGHT(phone, 4) AS last_digits
FROM customers;

-- SUBSTRING()
-- Extract part of string
SELECT first_name,
       SUBSTRING(first_name FROM 1 FOR 5)
FROM customers;

-- SPLIT_PART()
-- Split string using delimiter

-- Extract username 
SELECT email,
       SPLIT_PART(email, '@', 1) AS username
FROM customers;

-- CONCAT()
-- Combine columns
SELECT CONCAT(first_name, ' ', last_name) AS full_name
FROM customers;

/*
  CAST()
 --------
 Convert datatype
*/

-- string to integer
SELECT CAST(current_balance AS INTEGER)
FROM accounts;

-- Advanced Cleaning functions
-- POSITION()
-- Find character position
SELECT email,
       POSITION('@' IN email)
FROM customers;

-- STRPOS()
-- Same as POSITION
SELECT email,
       STRPOS(email, '@')
FROM customers;

-- COALESCE()
-- Replace NULL values
SELECT first_name,
       COALESCE(email, 'No Email')
FROM customers;

-- Real-World Example
SELECT customer_id,
       COALESCE(phone, 'Not Available')
FROM customers;

-- Standardize City Names
-- Convert all cities properly
SELECT INITCAP(TRIM(city)) AS cleaned_city
FROM customers;

-- Remove Special Characters
SELECT REPLACE(phone, '-', '')
FROM customers;

-- Handle Empty Strings
SELECT *
FROM customers
WHERE TRIM(email) = '';

-- Cleaning Date Formats
SELECT TO_DATE('25-12-2025', 'DD-MM-YYYY');

/*
  Real-World Banking Cleaning Query
 -----------------------------------
Clean customer data
*/
SELECT
    customer_id,
    INITCAP(TRIM(first_name)) AS cleaned_name,
    LOWER(TRIM(email)) AS cleaned_email,
    INITCAP(TRIM(city)) AS cleaned_city,
    COALESCE(phone, 'Not Available') AS phone
FROM customers;

-- CASE with Cleaning
SELECT first_name,
       CASE
           WHEN email IS NULL THEN 'Missing Email'
           ELSE 'Email Available'
       END AS email_status
FROM customers;

-- Length Validation
SELECT first_name,
       LENGTH(first_name)
FROM customers;

-- Check Invalid Phone Numbers
SELECT *
FROM customers
WHERE LENGTH(phone) < 10;

-- Multiple Cleaning Operations Together
SELECT
    customer_id,
    INITCAP(TRIM(first_name)) AS cleaned_name,
    LOWER(email) AS cleaned_email,
    REPLACE(phone, '-', '') AS cleaned_phone,
    COALESCE(city, 'Unknown') AS city
FROM customers;

/*
   Window Functions
  -------------------
  A function that:
* performs calculations over a window (set of rows)
* uses OVER() clause

*/

/*
| Term              | Meaning               |
| ----------------- | --------------------- |
| OVER()            | Defines window        |
| PARTITION BY      | Groups rows logically |
| ORDER BY          | Defines sequence      |
| Window Frame      | Defines row range     |
| Ranking Functions | ROW_NUMBER, RANK      |
| Aggregate Window  | SUM, AVG over window  |

*/

-- Basic Window Function
-- Running total balance
-- calculates total balance but keeps all rows.
SELECT account_id,
       current_balance,
       SUM(current_balance) OVER() AS total_balance
FROM accounts;
/*
 | GROUP BY             | Window Function      |
| -------------------- | -------------------- |
| Collapses rows       | Keeps rows           |
| One result per group | Result for every row |
| Aggregated output    | Detailed output      |
*/

/*
  Group By
------------
Collapses rows

Result: One row per account_type
*/

-- Group by
SELECT account_type,
       SUM(current_balance)
FROM accounts
GROUP BY account_type;

/*
  Window Function
  ----------------
  Keeps All rows

Result: * original rows preserved
        * total shown beside each row 
*/
SELECT account_id,
       account_type,
       current_balance,
       SUM(current_balance) OVER(PARTITION BY account_type)
FROM accounts;

/* Aggregate Window Functions

SUM()
Running Balance by Customer
*/
SELECT customer_id,
       account_id,
       current_balance,
       SUM(current_balance)
       OVER(PARTITION BY customer_id)
       AS total_customer_balance
FROM accounts;

/*
Advanced Window Functions
Multiple Window Functions Together
*/
SELECT customer_id,
       current_balance,

       ROW_NUMBER()
       OVER(ORDER BY current_balance DESC) AS row_num,

       RANK()
       OVER(ORDER BY current_balance DESC) AS rank_num,

       AVG(current_balance)
       OVER() AS avg_balance

FROM accounts;

-- Aliases for Multiple Window Functions
SELECT customer_id,
       current_balance,

       SUM(current_balance)
       OVER customer_window AS total_balance,

       AVG(current_balance)
       OVER customer_window AS avg_balance

FROM accounts

WINDOW customer_window AS
(
    PARTITION BY customer_id
    ORDER BY current_balance DESC
);

