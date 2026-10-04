/* =========================================================
   BANKING DATABASE MANAGEMENT SYSTEM
   FILE: 10_stored_procedures.sql
   PURPOSE: Stored Procedures
   MySQL 8.0+
   ========================================================= */

USE banking_system;

DELIMITER //


-- 1. Get all customers
CREATE PROCEDURE GetAllCustomers()
BEGIN
    SELECT *
    FROM customer;
END //


-- 2. Get customer by ID
CREATE PROCEDURE GetCustomerById(IN p_customer_id INT)
BEGIN
    SELECT *
    FROM customer
    WHERE customer_id = p_customer_id;
END //


-- 3. Get all accounts of a customer
CREATE PROCEDURE GetCustomerAccounts(IN p_customer_id INT)
BEGIN
    SELECT
        account_id,
        account_number,
        account_type,
        balance,
        created_date,
        status
    FROM account
    WHERE customer_id = p_customer_id;
END //


-- 4. Get account balance
CREATE PROCEDURE GetAccountBalance(IN p_account_id INT)
BEGIN
    SELECT
        account_id,
        account_number,
        balance,
        status
    FROM account
    WHERE account_id = p_account_id;
END //


-- 5. Get transactions of an account
CREATE PROCEDURE GetAccountTransactions(IN p_account_id INT)
BEGIN
    SELECT
        transaction_id,
        transaction_type,
        amount,
        transaction_date,
        status,
        description
    FROM `transaction`
    WHERE account_id = p_account_id
    ORDER BY transaction_date DESC;
END //


-- 6. Get loans of a customer
CREATE PROCEDURE GetCustomerLoans(IN p_customer_id INT)
BEGIN
    SELECT
        loan_id,
        loan_type,
        loan_amount,
        interest_rate,
        start_date,
        loan_status
    FROM loan
    WHERE customer_id = p_customer_id;
END //


-- 7. Get loan payments
CREATE PROCEDURE GetLoanPayments(IN p_loan_id INT)
BEGIN
    SELECT
        payment_id,
        amount_paid,
        payment_date,
        payment_status
    FROM loan_payment
    WHERE loan_id = p_loan_id
    ORDER BY payment_date;
END //


-- 8. Get accounts by account type
CREATE PROCEDURE GetAccountsByType(IN p_account_type VARCHAR(20))
BEGIN
    SELECT
        account_id,
        customer_id,
        account_number,
        account_type,
        balance,
        status
    FROM account
    WHERE account_type = p_account_type;
END //


-- 9. Get loans by loan type
CREATE PROCEDURE GetLoansByType(IN p_loan_type VARCHAR(20))
BEGIN
    SELECT
        loan_id,
        customer_id,
        loan_type,
        loan_amount,
        interest_rate,
        loan_status
    FROM loan
    WHERE loan_type = p_loan_type;
END //


-- 10. Get active accounts
CREATE PROCEDURE GetActiveAccounts()
BEGIN
    SELECT
        account_id,
        customer_id,
        account_number,
        account_type,
        balance
    FROM account
    WHERE status = 'ACTIVE';
END //


-- 11. Get active loans
CREATE PROCEDURE GetActiveLoans()
BEGIN
    SELECT
        loan_id,
        customer_id,
        loan_type,
        loan_amount,
        interest_rate
    FROM loan
    WHERE loan_status = 'ACTIVE';
END //


-- 12. Get transactions above a given amount
CREATE PROCEDURE GetTransactionsAboveAmount(IN p_amount DECIMAL(15,2))
BEGIN
    SELECT
        transaction_id,
        account_id,
        transaction_type,
        amount,
        transaction_date,
        status
    FROM `transaction`
    WHERE amount > p_amount
    ORDER BY amount DESC;
END //


-- 13. Get customers with balance above a given amount
CREATE PROCEDURE GetCustomersWithHighBalance(
    IN p_balance DECIMAL(15,2)
)
BEGIN
    SELECT
        c.customer_id,
        c.name,
        a.account_number,
        a.balance
    FROM customer c
    INNER JOIN account a
    ON c.customer_id = a.customer_id
    WHERE a.balance > p_balance
    ORDER BY a.balance DESC;
END //


-- 14. Get branch account details
CREATE PROCEDURE GetBranchAccounts(IN p_branch_id INT)
BEGIN
    SELECT
        b.branch_name,
        b.location,
        a.account_id,
        a.account_number,
        a.account_type,
        a.balance,
        a.status
    FROM bank_branch b
    INNER JOIN account a
    ON b.branch_id = a.branch_id
    WHERE b.branch_id = p_branch_id;
END //


-- 15. Get customer complete banking details
CREATE PROCEDURE GetCustomerBankingDetails(
    IN p_customer_id INT
)
BEGIN
    SELECT
        c.customer_id,
        c.name AS customer_name,
        c.email,
        a.account_number,
        a.account_type,
        a.balance,
        a.status,
        l.loan_type,
        l.loan_amount,
        l.loan_status
    FROM customer c
    LEFT JOIN account a
    ON c.customer_id = a.customer_id
    LEFT JOIN loan l
    ON c.customer_id = l.customer_id
    WHERE c.customer_id = p_customer_id;
END //


DELIMITER ;


-- =========================================================
-- PROCEDURE EXECUTION EXAMPLES
-- =========================================================

CALL GetAllCustomers();

CALL GetCustomerById(1);

CALL GetCustomerAccounts(1);

CALL GetAccountBalance(1);

CALL GetAccountTransactions(1);

CALL GetCustomerLoans(1);

CALL GetLoanPayments(1);

CALL GetAccountsByType('SAVINGS');

CALL GetLoansByType('HOME');

CALL GetActiveAccounts();

CALL GetActiveLoans();

CALL GetTransactionsAboveAmount(10000);

CALL GetCustomersWithHighBalance(30000);

CALL GetBranchAccounts(1);

CALL GetCustomerBankingDetails(1);
