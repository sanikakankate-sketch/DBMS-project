/* =========================================================
   BANKING DATABASE MANAGEMENT SYSTEM
   FILE: 06_joins.sql
   PURPOSE: SQL JOIN Queries
   MySQL 8.0+
   ========================================================= */

USE banking_system;


-- =========================================================
-- 1. INNER JOIN
-- Display customers and their account details
-- =========================================================

SELECT
    c.customer_id,
    c.name,
    a.account_number,
    a.account_type,
    a.balance
FROM customer c
INNER JOIN account a
    ON c.customer_id = a.customer_id;


-- =========================================================
-- 2. INNER JOIN
-- Display accounts with their branch information
-- =========================================================

SELECT
    a.account_id,
    a.account_number,
    a.account_type,
    a.balance,
    b.branch_name,
    b.location
FROM account a
INNER JOIN bank_branch b
    ON a.branch_id = b.branch_id;


-- =========================================================
-- 3. THREE-TABLE INNER JOIN
-- Customer + Account + Branch
-- =========================================================

SELECT
    c.name,
    a.account_number,
    a.account_type,
    a.balance,
    b.branch_name,
    b.location
FROM customer c
INNER JOIN account a
    ON c.customer_id = a.customer_id
INNER JOIN bank_branch b
    ON a.branch_id = b.branch_id;


-- =========================================================
-- 4. CUSTOMER + LOAN
-- Display customers who have loans
-- =========================================================

SELECT
    c.customer_id,
    c.name,
    l.loan_id,
    l.loan_type,
    l.loan_amount,
    l.interest_rate
FROM customer c
INNER JOIN loan l
    ON c.customer_id = l.customer_id;


-- =========================================================
-- 5. ACCOUNT + TRANSACTION
-- Display account transaction details
-- =========================================================

SELECT
    a.account_number,
    a.account_type,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status
FROM account a
INNER JOIN `transaction` t
    ON a.account_id = t.account_id;


-- =========================================================
-- 6. CUSTOMER + ACCOUNT + TRANSACTION
-- Display customer transaction details
-- =========================================================

SELECT
    c.name,
    a.account_number,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status
FROM customer c
INNER JOIN account a
    ON c.customer_id = a.customer_id
INNER JOIN `transaction` t
    ON a.account_id = t.account_id;


-- =========================================================
-- 7. CUSTOMER + LOAN + LOAN PAYMENT
-- Display loan payment information
-- =========================================================

SELECT
    c.name,
    l.loan_id,
    l.loan_type,
    l.loan_amount,
    lp.payment_id,
    lp.amount_paid,
    lp.payment_date,
    lp.payment_status
FROM customer c
INNER JOIN loan l
    ON c.customer_id = l.customer_id
INNER JOIN loan_payment lp
    ON l.loan_id = lp.loan_id;


-- =========================================================
-- 8. LEFT JOIN
-- Display all customers and their accounts
-- =========================================================

SELECT
    c.customer_id,
    c.name,
    a.account_number,
    a.account_type,
    a.balance
FROM customer c
LEFT JOIN account a
    ON c.customer_id = a.customer_id;


-- =========================================================
-- 9. LEFT JOIN
-- Display all branches and their accounts
-- =========================================================

SELECT
    b.branch_id,
    b.branch_name,
    b.location,
    a.account_number,
    a.account_type
FROM bank_branch b
LEFT JOIN account a
    ON b.branch_id = a.branch_id;


-- =========================================================
-- 10. LEFT JOIN
-- Display all customers and their loans
-- =========================================================

SELECT
    c.customer_id,
    c.name,
    l.loan_type,
    l.loan_amount,
    l.loan_status
FROM customer c
LEFT JOIN loan l
    ON c.customer_id = l.customer_id;


-- =========================================================
-- 11. RIGHT JOIN
-- Display all accounts and their customers
-- =========================================================

SELECT
    c.name,
    a.account_number,
    a.account_type,
    a.balance
FROM customer c
RIGHT JOIN account a
    ON c.customer_id = a.customer_id;


-- =========================================================
-- 12. RIGHT JOIN
-- Display all loans and their customers
-- =========================================================

SELECT
    c.name,
    l.loan_id,
    l.loan_type,
    l.loan_amount,
    l.loan_status
FROM customer c
RIGHT JOIN loan l
    ON c.customer_id = l.customer_id;


-- =========================================================
-- 13. SELF JOIN
-- Find pairs of customers having the same age
-- =========================================================

SELECT
    c1.name AS customer_1,
    c2.name AS customer_2,
    c1.age
FROM customer c1
INNER JOIN customer c2
    ON c1.age = c2.age
    AND c1.customer_id < c2.customer_id;


-- =========================================================
-- 14. JOIN WITH WHERE
-- Display customers having active loans above 30 lakh
-- =========================================================

SELECT
    c.name,
    l.loan_type,
    l.loan_amount,
    l.loan_status
FROM customer c
INNER JOIN loan l
    ON c.customer_id = l.customer_id
WHERE l.loan_amount > 3000000
AND l.loan_status = 'ACTIVE';


-- =========================================================
-- 15. JOIN WITH ORDER BY
-- Display customers ordered by account balance
-- =========================================================

SELECT
    c.name,
    a.account_number,
    a.balance
FROM customer c
INNER JOIN account a
    ON c.customer_id = a.customer_id
ORDER BY a.balance DESC;


-- =========================================================
-- 16. JOIN WITH TRANSACTION FILTER
-- Display successful deposits with customer details
-- =========================================================

SELECT
    c.name,
    a.account_number,
    t.amount,
    t.transaction_date
FROM customer c
INNER JOIN account a
    ON c.customer_id = a.customer_id
INNER JOIN `transaction` t
    ON a.account_id = t.account_id
WHERE t.transaction_type = 'DEPOSIT'
AND t.status = 'SUCCESS';


-- =========================================================
-- 17. JOIN BRANCH AND CUSTOMER
-- Display customers according to their branch
-- =========================================================

SELECT
    b.branch_name,
    b.location,
    c.name,
    a.account_number
FROM bank_branch b
INNER JOIN account a
    ON b.branch_id = a.branch_id
INNER JOIN customer c
    ON a.customer_id = c.customer_id
ORDER BY b.branch_name;


-- =========================================================
-- 18. JOIN LOAN AND PAYMENT
-- Display payments made against each loan
-- =========================================================

SELECT
    l.loan_id,
    l.loan_type,
    l.loan_amount,
    lp.payment_id,
    lp.amount_paid,
    lp.payment_status
FROM loan l
INNER JOIN loan_payment lp
    ON l.loan_id = lp.loan_id;


-- =========================================================
-- 19. JOIN WITH MULTIPLE CONDITIONS
-- Display active accounts having successful transactions
-- =========================================================

SELECT
    c.name,
    a.account_number,
    a.balance,
    t.transaction_type,
    t.amount
FROM customer c
INNER JOIN account a
    ON c.customer_id = a.customer_id
INNER JOIN `transaction` t
    ON a.account_id = t.account_id
WHERE a.status = 'ACTIVE'
AND t.status = 'SUCCESS';


-- =========================================================
-- 20. MULTIPLE TABLE JOIN
-- Complete banking information
-- =========================================================

SELECT
    c.name AS customer_name,
    a.account_number,
    b.branch_name,
    a.balance,
    t.transaction_type,
    t.amount
FROM customer c
INNER JOIN account a
    ON c.customer_id = a.customer_id
INNER JOIN bank_branch b
    ON a.branch_id = b.branch_id
INNER JOIN `transaction` t
    ON a.account_id = t.account_id;
