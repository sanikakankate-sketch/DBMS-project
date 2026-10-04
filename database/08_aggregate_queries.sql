/* =========================================================
   BANKING DATABASE MANAGEMENT SYSTEM
   FILE: 08_aggregate_queries.sql
   PURPOSE: Aggregate SQL Queries
   MySQL 8.0+
   ========================================================= */

USE banking_system;


-- 1. Count total customers
SELECT COUNT(*) AS total_customers
FROM customer;


-- 2. Count total branches
SELECT COUNT(*) AS total_branches
FROM bank_branch;


-- 3. Count total accounts
SELECT COUNT(*) AS total_accounts
FROM account;


-- 4. Count total loans
SELECT COUNT(*) AS total_loans
FROM loan;


-- 5. Count total transactions
SELECT COUNT(*) AS total_transactions
FROM `transaction`;


-- 6. Find total balance of all accounts
SELECT SUM(balance) AS total_balance
FROM account;


-- 7. Find average account balance
SELECT AVG(balance) AS average_balance
FROM account;


-- 8. Find maximum account balance
SELECT MAX(balance) AS maximum_balance
FROM account;


-- 9. Find minimum account balance
SELECT MIN(balance) AS minimum_balance
FROM account;


-- 10. Find total transaction amount
SELECT SUM(amount) AS total_transaction_amount
FROM `transaction`;


-- 11. Find average transaction amount
SELECT AVG(amount) AS average_transaction_amount
FROM `transaction`;


-- 12. Find maximum transaction amount
SELECT MAX(amount) AS maximum_transaction_amount
FROM `transaction`;


-- 13. Find minimum transaction amount
SELECT MIN(amount) AS minimum_transaction_amount
FROM `transaction`;


-- 14. Find total loan amount
SELECT SUM(loan_amount) AS total_loan_amount
FROM loan;


-- 15. Find average loan amount
SELECT AVG(loan_amount) AS average_loan_amount
FROM loan;


-- 16. Find maximum loan amount
SELECT MAX(loan_amount) AS maximum_loan_amount
FROM loan;


-- 17. Find minimum loan amount
SELECT MIN(loan_amount) AS minimum_loan_amount
FROM loan;


-- 18. Count accounts by account type
SELECT account_type, COUNT(*) AS total_accounts
FROM account
GROUP BY account_type;


-- 19. Find total balance by account type
SELECT account_type, SUM(balance) AS total_balance
FROM account
GROUP BY account_type;


-- 20. Find average balance by account type
SELECT account_type, AVG(balance) AS average_balance
FROM account
GROUP BY account_type;


-- 21. Count accounts by branch
SELECT branch_id, COUNT(*) AS total_accounts
FROM account
GROUP BY branch_id;


-- 22. Find total balance by branch
SELECT branch_id, SUM(balance) AS total_balance
FROM account
GROUP BY branch_id;


-- 23. Find average balance by branch
SELECT branch_id, AVG(balance) AS average_balance
FROM account
GROUP BY branch_id;


-- 24. Count customers by age
SELECT age, COUNT(*) AS total_customers
FROM customer
GROUP BY age
ORDER BY age;


-- 25. Count loans by loan type
SELECT loan_type, COUNT(*) AS total_loans
FROM loan
GROUP BY loan_type;


-- 26. Find total loan amount by loan type
SELECT loan_type, SUM(loan_amount) AS total_loan_amount
FROM loan
GROUP BY loan_type;


-- 27. Find average loan amount by loan type
SELECT loan_type, AVG(loan_amount) AS average_loan_amount
FROM loan
GROUP BY loan_type;


-- 28. Count loans by loan status
SELECT loan_status, COUNT(*) AS total_loans
FROM loan
GROUP BY loan_status;


-- 29. Count transactions by transaction type
SELECT transaction_type, COUNT(*) AS total_transactions
FROM `transaction`
GROUP BY transaction_type;


-- 30. Find total transaction amount by transaction type
SELECT transaction_type, SUM(amount) AS total_amount
FROM `transaction`
GROUP BY transaction_type;


-- 31. Find average transaction amount by transaction type
SELECT transaction_type, AVG(amount) AS average_amount
FROM `transaction`
GROUP BY transaction_type;


-- 32. Count transactions by transaction status
SELECT status, COUNT(*) AS total_transactions
FROM `transaction`
GROUP BY status;


-- 33. Find total transaction amount by status
SELECT status, SUM(amount) AS total_amount
FROM `transaction`
GROUP BY status;


-- 34. Find customers having more than one account
SELECT customer_id, COUNT(*) AS total_accounts
FROM account
GROUP BY customer_id
HAVING COUNT(*) > 1;


-- 35. Find branches having more than five accounts
SELECT branch_id, COUNT(*) AS total_accounts
FROM account
GROUP BY branch_id
HAVING COUNT(*) > 5;


-- 36. Find loan types having total loan amount
--     greater than 10,000,000
SELECT loan_type, SUM(loan_amount) AS total_loan_amount
FROM loan
GROUP BY loan_type
HAVING SUM(loan_amount) > 10000000;


-- 37. Find transaction types having total amount
--     greater than 100,000
SELECT transaction_type, SUM(amount) AS total_amount
FROM `transaction`
GROUP BY transaction_type
HAVING SUM(amount) > 100000;


-- 38. Find branches with average balance
--     greater than 30,000
SELECT branch_id, AVG(balance) AS average_balance
FROM account
GROUP BY branch_id
HAVING AVG(balance) > 30000;


-- 39. Find customers with total account balance
--     greater than 50,000
SELECT customer_id, SUM(balance) AS total_balance
FROM account
GROUP BY customer_id
HAVING SUM(balance) > 50000;


-- 40. Find customers with total loan amount
--     greater than 5,000,000
SELECT customer_id, SUM(loan_amount) AS total_loan_amount
FROM loan
GROUP BY customer_id
HAVING SUM(loan_amount) > 5000000;
