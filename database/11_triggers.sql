/* =========================================================
   BANKING DATABASE MANAGEMENT SYSTEM
   FILE: 11_triggers.sql
   PURPOSE: SQL Triggers
   MySQL 8.0+
   ========================================================= */

USE banking_system;

DELIMITER //


-- 1. Prevent negative account balance before INSERT
CREATE TRIGGER before_account_insert
BEFORE INSERT ON account
FOR EACH ROW
BEGIN
    IF NEW.balance < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Account balance cannot be negative';
    END IF;
END //


-- 2. Prevent negative account balance before UPDATE
CREATE TRIGGER before_account_update
BEFORE UPDATE ON account
FOR EACH ROW
BEGIN
    IF NEW.balance < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Account balance cannot be negative';
    END IF;
END //


-- 3. Prevent zero or negative transaction amount
CREATE TRIGGER before_transaction_insert
BEFORE INSERT ON `transaction`
FOR EACH ROW
BEGIN
    IF NEW.amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Transaction amount must be greater than zero';
    END IF;
END //


-- 4. Prevent zero or negative loan amount
CREATE TRIGGER before_loan_insert
BEFORE INSERT ON loan
FOR EACH ROW
BEGIN
    IF NEW.loan_amount <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Loan amount must be greater than zero';
    END IF;
END //


-- 5. Prevent zero or negative loan payment
CREATE TRIGGER before_loan_payment_insert
BEFORE INSERT ON loan_payment
FOR EACH ROW
BEGIN
    IF NEW.amount_paid <= 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Payment amount must be greater than zero';
    END IF;
END //


-- 6. Automatically set account status to ACTIVE
--    when a new account is created without a status
CREATE TRIGGER before_account_status_insert
BEFORE INSERT ON account
FOR EACH ROW
BEGIN
    IF NEW.status IS NULL OR NEW.status = '' THEN
        SET NEW.status = 'ACTIVE';
    END IF;
END //


-- 7. Automatically set transaction status to SUCCESS
--    when status is not provided
CREATE TRIGGER before_transaction_status_insert
BEFORE INSERT ON `transaction`
FOR EACH ROW
BEGIN
    IF NEW.status IS NULL OR NEW.status = '' THEN
        SET NEW.status = 'SUCCESS';
    END IF;
END //


-- 8. Automatically set loan status to ACTIVE
--    when status is not provided
CREATE TRIGGER before_loan_status_insert
BEFORE INSERT ON loan
FOR EACH ROW
BEGIN
    IF NEW.loan_status IS NULL OR NEW.loan_status = '' THEN
        SET NEW.loan_status = 'ACTIVE';
    END IF;
END //


-- 9. Automatically set loan payment status to PAID
--    when status is not provided
CREATE TRIGGER before_payment_status_insert
BEFORE INSERT ON loan_payment
FOR EACH ROW
BEGIN
    IF NEW.payment_status IS NULL OR NEW.payment_status = '' THEN
        SET NEW.payment_status = 'PAID';
    END IF;
END //


-- 10. Prevent withdrawal greater than account balance
CREATE TRIGGER before_withdrawal_insert
BEFORE INSERT ON `transaction`
FOR EACH ROW
BEGIN
    DECLARE current_balance DECIMAL(15,2);

    IF NEW.transaction_type = 'WITHDRAWAL' THEN

        SELECT balance
        INTO current_balance
        FROM account
        WHERE account_id = NEW.account_id;

        IF NEW.amount > current_balance THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Insufficient account balance';
        END IF;

    END IF;
END //


DELIMITER ;
