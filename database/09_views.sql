/* =========================================================
   BANKING DATABASE MANAGEMENT SYSTEM
   FILE: 09_views.sql
   PURPOSE: SQL Views
   MySQL 8.0+
   ========================================================= */

USE banking_system;


-- 1. View of customer account details
CREATE OR REPLACE VIEW customer_account_view AS
SELECT
    c.customer_id,
    c.name AS customer_name,
    c.email,
    a.account_id,
    a.account_number,
    a.account_type,
    a.balance,
    a.status
FROM customer c
INNER JOIN account a
ON c.customer_id = a.customer_id;


-- Display customer account view
SELECT *
FROM customer_account_view;


-- 2. View of account and branch details
CREATE OR REPLACE VIEW account_branch_view AS
SELECT
    a.account_id,
    a.account_number,
    a.account_type,
    a.balance,
    a.status,
    b.branch_id,
    b.branch_name,
    b.location,
    b.ifsc_code
FROM account a
INNER JOIN bank_branch b
ON a.branch_id = b.branch_id;


-- Display account branch view
SELECT *
FROM account_branch_view;


-- 3. View of customer loan details
CREATE OR REPLACE VIEW customer_loan_view AS
SELECT
    c.customer_id,
    c.name AS customer_name,
    c.email,
    l.loan_id,
    l.loan_type,
    l.loan_amount,
    l.interest_rate,
    l.start_date,
    l.loan_status
FROM customer c
INNER JOIN loan l
ON c.customer_id = l.customer_id;


-- Display customer loan view
SELECT *
FROM customer_loan_view;


-- 4. View of transaction details
CREATE OR REPLACE VIEW transaction_details_view AS
SELECT
    t.transaction_id,
    a.account_number,
    a.account_type,
    c.customer_id,
    c.name AS customer_name,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.status,
    t.description
FROM `transaction` t
INNER JOIN account a
ON t.account_id = a.account_id
INNER JOIN customer c
ON a.customer_id = c.customer_id;


-- Display transaction details
SELECT *
FROM transaction_details_view;


-- 5. View of loan payment details
CREATE OR REPLACE VIEW loan_payment_view AS
SELECT
    l.loan_id,
    c.customer_id,
    c.name AS customer_name,
    l.loan_type,
    l.loan_amount,
    l.loan_status,
    lp.payment_id,
    lp.amount_paid,
    lp.payment_date,
    lp.payment_status
FROM loan l
INNER JOIN customer c
ON l.customer_id = c.customer_id
INNER JOIN loan_payment lp
ON l.loan_id = lp.loan_id;


-- Display loan payment view
SELECT *
FROM loan_payment_view;


-- 6. View of active accounts
CREATE OR REPLACE VIEW active_accounts_view AS
SELECT
    a.account_id,
    a.account_number,
    c.name AS customer_name,
    a.account_type,
    a.balance,
    a.created_date,
    a.status
FROM account a
INNER JOIN customer c
ON a.customer_id = c.customer_id
WHERE a.status = 'ACTIVE';


-- Display active accounts
SELECT *
FROM active_accounts_view;


-- 7. View of active loans
CREATE OR REPLACE VIEW active_loans_view AS
SELECT
    l.loan_id,
    c.customer_id,
    c.name AS customer_name,
    l.loan_type,
    l.loan_amount,
    l.interest_rate,
    l.start_date,
    l.loan_status
FROM loan l
INNER JOIN customer c
ON l.customer_id = c.customer_id
WHERE l.loan_status = 'ACTIVE';


-- Display active loans
SELECT *
FROM active_loans_view;


-- 8. View of successful transactions
CREATE OR REPLACE VIEW successful_transactions_view AS
SELECT
    t.transaction_id,
    c.name AS customer_name,
    a.account_number,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    t.description
FROM `transaction` t
INNER JOIN account a
ON t.account_id = a.account_id
INNER JOIN customer c
ON a.customer_id = c.customer_id
WHERE t.status = 'SUCCESS';


-- Display successful transactions
SELECT *
FROM successful_transactions_view;


-- 9. View of branch account summary
CREATE OR REPLACE VIEW branch_account_summary_view AS
SELECT
    b.branch_id,
    b.branch_name,
    b.location,
    COUNT(a.account_id) AS total_accounts,
    SUM(a.balance) AS total_balance,
    AVG(a.balance) AS average_balance
FROM bank_branch b
LEFT JOIN account a
ON b.branch_id = a.branch_id
GROUP BY
    b.branch_id,
    b.branch_name,
    b.location;


-- Display branch account summary
SELECT *
FROM branch_account_summary_view;


-- 10. View of loan type summary
CREATE OR REPLACE VIEW loan_type_summary_view AS
SELECT
    loan_type,
    COUNT(*) AS total_loans,
    SUM(loan_amount) AS total_loan_amount,
    AVG(loan_amount) AS average_loan_amount,
    MAX(loan_amount) AS maximum_loan_amount,
    MIN(loan_amount) AS minimum_loan_amount
FROM loan
GROUP BY loan_type;


-- Display loan type summary
SELECT *
FROM loan_type_summary_view;
