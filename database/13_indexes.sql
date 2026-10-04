/* =========================================================
   BANKING DATABASE MANAGEMENT SYSTEM
   FILE: 13_indexes.sql
   PURPOSE: SQL Indexes
   MySQL 8.0+
   ========================================================= */

USE banking_system;


-- =========================================================
-- 1. INDEX ON CUSTOMER EMAIL
-- Useful for searching customers by email
-- =========================================================

CREATE INDEX idx_customer_email
ON customer(email);


-- =========================================================
-- 2. INDEX ON CUSTOMER PHONE
-- Useful for searching customers by phone
-- =========================================================

CREATE INDEX idx_customer_phone
ON customer(phone);


-- =========================================================
-- 3. INDEX ON ACCOUNT CUSTOMER ID
-- Useful for finding accounts belonging to a customer
-- =========================================================

CREATE INDEX idx_account_customer
ON account(customer_id);


-- =========================================================
-- 4. INDEX ON ACCOUNT BRANCH ID
-- Useful for finding accounts in a branch
-- =========================================================

CREATE INDEX idx_account_branch
ON account(branch_id);


-- =========================================================
-- 5. INDEX ON ACCOUNT TYPE
-- Useful for filtering by account type
-- =========================================================

CREATE INDEX idx_account_type
ON account(account_type);


-- =========================================================
-- 6. INDEX ON ACCOUNT STATUS
-- Useful for finding active/inactive accounts
-- =========================================================

CREATE INDEX idx_account_status
ON account(status);


-- =========================================================
-- 7. INDEX ON TRANSACTION ACCOUNT ID
-- Useful for finding transactions of an account
-- =========================================================

CREATE INDEX idx_transaction_account
ON `transaction`(account_id);


-- =========================================================
-- 8. INDEX ON TRANSACTION TYPE
-- Useful for filtering deposits, withdrawals and transfers
-- =========================================================

CREATE INDEX idx_transaction_type
ON `transaction`(transaction_type);


-- =========================================================
-- 9. INDEX ON TRANSACTION DATE
-- Useful for date-based transaction searches
-- =========================================================

CREATE INDEX idx_transaction_date
ON `transaction`(transaction_date);


-- =========================================================
-- 10. INDEX ON TRANSACTION STATUS
-- Useful for filtering successful/failed transactions
-- =========================================================

CREATE INDEX idx_transaction_status
ON `transaction`(status);


-- =========================================================
-- 11. INDEX ON LOAN CUSTOMER ID
-- Useful for finding loans of a customer
-- =========================================================

CREATE INDEX idx_loan_customer
ON loan(customer_id);


-- =========================================================
-- 12. INDEX ON LOAN TYPE
-- Useful for filtering loans by type
-- =========================================================

CREATE INDEX idx_loan_type
ON loan(loan_type);


-- =========================================================
-- 13. INDEX ON LOAN STATUS
-- Useful for filtering active/closed/defaulted loans
-- =========================================================

CREATE INDEX idx_loan_status
ON loan(loan_status);


-- =========================================================
-- 14. INDEX ON LOAN PAYMENT LOAN ID
-- Useful for finding payments of a particular loan
-- =========================================================

CREATE INDEX idx_payment_loan
ON loan_payment(loan_id);


-- =========================================================
-- 15. INDEX ON LOAN PAYMENT DATE
-- Useful for date-based payment searches
-- =========================================================

CREATE INDEX idx_payment_date
ON loan_payment(payment_date);


-- =========================================================
-- 16. COMPOSITE INDEX
-- Customer ID + Account Status
-- Useful for finding active accounts of a customer
-- =========================================================

CREATE INDEX idx_account_customer_status
ON account(customer_id, status);


-- =========================================================
-- 17. COMPOSITE INDEX
-- Account ID + Transaction Date
-- Useful for finding transactions of an account
-- in date order/filtering
-- =========================================================

CREATE INDEX idx_transaction_account_date
ON `transaction`(account_id, transaction_date);


-- =========================================================
-- 18. COMPOSITE INDEX
-- Customer ID + Loan Status
-- Useful for finding active loans of a customer
-- =========================================================

CREATE INDEX idx_loan_customer_status
ON loan(customer_id, loan_status);


-- =========================================================
-- 19. VIEW EXISTING INDEXES
-- =========================================================

SHOW INDEX FROM customer;

SHOW INDEX FROM bank_branch;

SHOW INDEX FROM account;

SHOW INDEX FROM `transaction`;

SHOW INDEX FROM loan;

SHOW INDEX FROM loan_payment;


-- =========================================================
-- 20. EXAMPLE QUERY USING INDEXED COLUMNS
-- =========================================================

SELECT *
FROM customer
WHERE email = 'customer1@gmail.com';


SELECT *
FROM account
WHERE customer_id = 1
AND status = 'ACTIVE';


SELECT *
FROM `transaction`
WHERE account_id = 1
ORDER BY transaction_date;


SELECT *
FROM loan
WHERE customer_id = 1
AND loan_status = 'ACTIVE';
