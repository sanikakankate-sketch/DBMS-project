/* =========================================================
   BANKING DATABASE MANAGEMENT SYSTEM
   FILE: 05_basic_queries.sql
   PURPOSE: Basic SQL Queries
   MySQL 8.0+
   ========================================================= */

USE banking_system;


-- =========================================================
-- 1. DISPLAY ALL CUSTOMERS
-- =========================================================

SELECT *
FROM customer;


-- =========================================================
-- 2. DISPLAY CUSTOMER NAMES AND EMAILS
-- =========================================================

SELECT name, email
FROM customer;


-- =========================================================
-- 3. DISPLAY ALL BANK BRANCHES
-- =========================================================

SELECT *
FROM bank_branch;


-- =========================================================
-- 4. DISPLAY ALL ACTIVE ACCOUNTS
-- =========================================================

SELECT *
FROM account
WHERE status = 'ACTIVE';


-- =========================================================
-- 5. DISPLAY SAVINGS ACCOUNTS
-- =========================================================

SELECT *
FROM account
WHERE account_type = 'SAVINGS';


-- =========================================================
-- 6. DISPLAY ACCOUNTS WITH BALANCE GREATER THAN 30000
-- =========================================================

SELECT account_id, account_number, balance
FROM account
WHERE balance > 30000;


-- =========================================================
-- 7. DISPLAY ACCOUNTS WITH BALANCE BETWEEN 10000 AND 50000
-- =========================================================

SELECT account_id, account_number, balance
FROM account
WHERE balance BETWEEN 10000 AND 50000;


-- =========================================================
-- 8. DISPLAY CUSTOMERS FROM SPECIFIC LOCATIONS
-- =========================================================

SELECT *
FROM customer
WHERE address LIKE '%Pune%';


-- =========================================================
-- 9. DISPLAY CUSTOMERS WHOSE NAME STARTS WITH 'R'
-- =========================================================

SELECT *
FROM customer
WHERE name LIKE 'R%';


-- =========================================================
-- 10. DISPLAY CUSTOMERS WHOSE NAME CONTAINS 'a'
-- =========================================================

SELECT *
FROM customer
WHERE name LIKE '%a%';


-- =========================================================
-- 11. DISPLAY DIFFERENT ACCOUNT TYPES
-- =========================================================

SELECT DISTINCT account_type
FROM account;


-- =========================================================
-- 12. DISPLAY DIFFERENT ACCOUNT STATUSES
-- =========================================================

SELECT DISTINCT status
FROM account;


-- =========================================================
-- 13. DISPLAY ACCOUNTS BELONGING TO BRANCHES 1, 5 AND 10
-- =========================================================

SELECT *
FROM account
WHERE branch_id IN (1, 5, 10);


-- =========================================================
-- 14. DISPLAY TRANSACTIONS GREATER THAN 10000
-- =========================================================

SELECT *
FROM `transaction`
WHERE amount > 10000;


-- =========================================================
-- 15. DISPLAY SUCCESSFUL TRANSACTIONS
-- =========================================================

SELECT *
FROM `transaction`
WHERE status = 'SUCCESS';


-- =========================================================
-- 16. DISPLAY FAILED TRANSACTIONS
-- =========================================================

SELECT *
FROM `transaction`
WHERE status = 'FAILED';


-- =========================================================
-- 17. DISPLAY DEPOSIT TRANSACTIONS
-- =========================================================

SELECT *
FROM `transaction`
WHERE transaction_type = 'DEPOSIT';


-- =========================================================
-- 18. DISPLAY TRANSACTIONS ORDERED BY AMOUNT
-- HIGHEST AMOUNT FIRST
-- =========================================================

SELECT transaction_id, account_id, transaction_type, amount
FROM `transaction`
ORDER BY amount DESC;


-- =========================================================
-- 19. DISPLAY ACCOUNTS ORDERED BY BALANCE
-- LOWEST BALANCE FIRST
-- =========================================================

SELECT account_id, account_number, balance
FROM account
ORDER BY balance ASC;


-- =========================================================
-- 20. DISPLAY TOP 10 HIGHEST ACCOUNT BALANCES
-- =========================================================

SELECT account_id, account_number, balance
FROM account
ORDER BY balance DESC
LIMIT 10;


-- =========================================================
-- 21. DISPLAY CUSTOMERS OLDER THAN 50
-- =========================================================

SELECT customer_id, name, age
FROM customer
WHERE age > 50;


-- =========================================================
-- 22. DISPLAY CUSTOMERS BETWEEN AGE 25 AND 40
-- =========================================================

SELECT customer_id, name, age
FROM customer
WHERE age BETWEEN 25 AND 40;


-- =========================================================
-- 23. DISPLAY HOME AND CAR LOANS
-- =========================================================

SELECT *
FROM loan
WHERE loan_type IN ('HOME', 'CAR');


-- =========================================================
-- 24. DISPLAY ACTIVE LOANS
-- =========================================================

SELECT *
FROM loan
WHERE loan_status = 'ACTIVE';


-- =========================================================
-- 25. DISPLAY LOANS GREATER THAN 30 LAKH
-- =========================================================

SELECT loan_id, customer_id, loan_type, loan_amount
FROM loan
WHERE loan_amount > 3000000;


-- =========================================================
-- 26. DISPLAY LOANS ORDERED BY LOAN AMOUNT
-- =========================================================

SELECT loan_id, customer_id, loan_type, loan_amount
FROM loan
ORDER BY loan_amount DESC;


-- =========================================================
-- 27. DISPLAY PAID LOAN PAYMENTS
-- =========================================================

SELECT *
FROM loan_payment
WHERE payment_status = 'PAID';


-- =========================================================
-- 28. DISPLAY PENDING LOAN PAYMENTS
-- =========================================================

SELECT *
FROM loan_payment
WHERE payment_status = 'PENDING';


-- =========================================================
-- 29. DISPLAY LOAN PAYMENTS GREATER THAN 20000
-- =========================================================

SELECT *
FROM loan_payment
WHERE amount_paid > 20000;


-- =========================================================
-- 30. DISPLAY LOAN TYPES AVAILABLE
-- =========================================================

SELECT DISTINCT loan_type
FROM loan;
