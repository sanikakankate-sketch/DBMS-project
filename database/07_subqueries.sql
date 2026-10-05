/* =========================================================
   BANKING DATABASE MANAGEMENT SYSTEM
   FILE: 07_subqueries.sql
   PURPOSE: SQL Subqueries
   MySQL 8.0+
   ========================================================= */

USE banking_system;


-- 1. Customers who have at least one account
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM account
);


-- 2. Customers who have a loan
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM loan
);


-- 3. Accounts with balance greater than average balance
SELECT account_id, account_number, balance
FROM account
WHERE balance > (
    SELECT AVG(balance)
    FROM account
);


-- 4. Accounts with balance less than average balance
SELECT account_id, account_number, balance
FROM account
WHERE balance < (
    SELECT AVG(balance)
    FROM account
);


-- 5. Customer with the highest account balance
SELECT c.customer_id, c.name, a.account_number, a.balance
FROM customer c
INNER JOIN account a
ON c.customer_id = a.customer_id
WHERE a.balance = (
    SELECT MAX(balance)
    FROM account
);


-- 6. Customer with the lowest account balance
SELECT c.customer_id, c.name, a.account_number, a.balance
FROM customer c
INNER JOIN account a
ON c.customer_id = a.customer_id
WHERE a.balance = (
    SELECT MIN(balance)
    FROM account
);


-- 7. Loans greater than average loan amount
SELECT loan_id, customer_id, loan_type, loan_amount
FROM loan
WHERE loan_amount > (
    SELECT AVG(loan_amount)
    FROM loan
);


-- 8. Loans less than average loan amount
SELECT loan_id, customer_id, loan_type, loan_amount
FROM loan
WHERE loan_amount < (
    SELECT AVG(loan_amount)
    FROM loan
);


-- 9. Transactions greater than average transaction amount
SELECT transaction_id, account_id, transaction_type, amount
FROM `transaction`
WHERE amount > (
    SELECT AVG(amount)
    FROM `transaction`
);


-- 10. Transactions equal to the maximum transaction amount
SELECT transaction_id, account_id, transaction_type, amount
FROM `transaction`
WHERE amount = (
    SELECT MAX(amount)
    FROM `transaction`
);


-- 11. Customers who have an account in branch 1
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM account
    WHERE branch_id = 1
);


-- 12. Customers who have savings accounts
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM account
    WHERE account_type = 'SAVINGS'
);


-- 13. Customers who have active loans
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM loan
    WHERE loan_status = 'ACTIVE'
);


-- 14. Accounts belonging to customers who have loans
SELECT account_id, account_number, customer_id, balance
FROM account
WHERE customer_id IN (
    SELECT customer_id
    FROM loan
);


-- 15. Loans belonging to customers who have accounts
SELECT loan_id, customer_id, loan_type, loan_amount
FROM loan
WHERE customer_id IN (
    SELECT customer_id
    FROM account
);


-- 16. Customers whose account balance is greater than 30000
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT customer_id
    FROM account
    WHERE balance > 30000
);


-- 17. Customers who made transactions above 10000
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT a.customer_id
    FROM account a
    INNER JOIN `transaction` t
    ON a.account_id = t.account_id
    WHERE t.amount > 10000
);


-- 18. Customers who made successful transactions
SELECT *
FROM customer
WHERE customer_id IN (
    SELECT a.customer_id
    FROM account a
    INNER JOIN `transaction` t
    ON a.account_id = t.account_id
    WHERE t.status = 'SUCCESS'
);


-- 19. Accounts having balance greater than the average
--    balance of accounts in the same branch
SELECT a1.account_id, a1.account_number,
       a1.branch_id, a1.balance
FROM account a1
WHERE a1.balance > (
    SELECT AVG(a2.balance)
    FROM account a2
    WHERE a2.branch_id = a1.branch_id
);


-- 20. Customers having more than one account
SELECT c.customer_id, c.name
FROM customer c
WHERE (
    SELECT COUNT(*)
    FROM account a
    WHERE a.customer_id = c.customer_id
) > 1;


-- 21. Customers having more than one loan
SELECT c.customer_id, c.name
FROM customer c
WHERE (
    SELECT COUNT(*)
    FROM loan l
    WHERE l.customer_id = c.customer_id
) > 1;


-- 22. Loans whose amount is greater than
--     every personal loan
SELECT loan_id, customer_id, loan_type, loan_amount
FROM loan
WHERE loan_amount > ALL (
    SELECT loan_amount
    FROM loan
    WHERE loan_type = 'PERSONAL'
);


-- 23. Accounts whose balance is greater than
--     every account in branch 1
SELECT account_id, account_number, branch_id, balance
FROM account
WHERE balance > ALL (
    SELECT balance
    FROM account
    WHERE branch_id = 1
);


-- 24. Customers having at least one active loan
SELECT c.customer_id, c.name
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM loan l
    WHERE l.customer_id = c.customer_id
    AND l.loan_status = 'ACTIVE'
);


-- 25. Customers having at least one account
SELECT c.customer_id, c.name
FROM customer c
WHERE EXISTS (
    SELECT 1
    FROM account a
    WHERE a.customer_id = c.customer_id
);
