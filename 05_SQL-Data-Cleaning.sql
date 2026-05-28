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
