/* =========================================================
   BANKING DATABASE MANAGEMENT SYSTEM
   FILE: 12_transactions.sql
   PURPOSE: SQL Transaction Management
   MySQL 8.0+
   ========================================================= */

USE banking_system;


-- =========================================================
-- 1. BASIC TRANSACTION
-- Deposit money into an account
-- =========================================================

START TRANSACTION;

UPDATE account
SET balance = balance + 5000
WHERE account_id = 1;

COMMIT;


-- =========================================================
-- 2. ROLLBACK TRANSACTION
-- Demonstrates cancelling a transaction
-- =========================================================

START TRANSACTION;

UPDATE account
SET balance = balance + 10000
WHERE account_id = 2;

ROLLBACK;


-- =========================================================
-- 3. TRANSFER MONEY BETWEEN TWO ACCOUNTS
-- Using COMMIT
-- =========================================================

START TRANSACTION;

UPDATE account
SET balance = balance - 5000
WHERE account_id = 3;

UPDATE account
SET balance = balance + 5000
WHERE account_id = 4;

COMMIT;


-- =========================================================
-- 4. TRANSFER MONEY WITH ROLLBACK
-- Changes are cancelled
-- =========================================================

START TRANSACTION;

UPDATE account
SET balance = balance - 3000
WHERE account_id = 5;

UPDATE account
SET balance = balance + 3000
WHERE account_id = 6;

ROLLBACK;


-- =========================================================
-- 5. TRANSACTION WITH SAVEPOINT
-- =========================================================

START TRANSACTION;

UPDATE account
SET balance = balance - 2000
WHERE account_id = 7;

SAVEPOINT after_withdrawal;

UPDATE account
SET balance = balance + 2000
WHERE account_id = 8;

ROLLBACK TO SAVEPOINT after_withdrawal;

COMMIT;


-- =========================================================
-- 6. MULTIPLE SAVEPOINTS
-- =========================================================

START TRANSACTION;

UPDATE account
SET balance = balance + 1000
WHERE account_id = 9;

SAVEPOINT point_one;

UPDATE account
SET balance = balance + 2000
WHERE account_id = 10;

SAVEPOINT point_two;

UPDATE account
SET balance = balance + 3000
WHERE account_id = 11;

ROLLBACK TO SAVEPOINT point_two;

COMMIT;


-- =========================================================
-- 7. DEPOSIT TRANSACTION
-- Update account balance and record transaction
-- =========================================================

START TRANSACTION;

UPDATE account
SET balance = balance + 7500
WHERE account_id = 12;

INSERT INTO `transaction`
(
    account_id,
    transaction_type,
    amount,
    transaction_date,
    status,
    description
)
VALUES
(
    12,
    'DEPOSIT',
    7500,
    NOW(),
    'SUCCESS',
    'Cash deposit'
);

COMMIT;


-- =========================================================
-- 8. WITHDRAWAL TRANSACTION
-- =========================================================

START TRANSACTION;

UPDATE account
SET balance = balance - 2500
WHERE account_id = 13;

INSERT INTO `transaction`
(
    account_id,
    transaction_type,
    amount,
    transaction_date,
    status,
    description
)
VALUES
(
    13,
    'WITHDRAWAL',
    2500,
    NOW(),
    'SUCCESS',
    'Cash withdrawal'
);

COMMIT;


-- =========================================================
-- 9. TRANSFER TRANSACTION
-- Debit one account and credit another account
-- =========================================================

START TRANSACTION;

UPDATE account
SET balance = balance - 4000
WHERE account_id = 14;

UPDATE account
SET balance = balance + 4000
WHERE account_id = 15;

INSERT INTO `transaction`
(
    account_id,
    transaction_type,
    amount,
    transaction_date,
    status,
    description
)
VALUES
(
    14,
    'TRANSFER',
    4000,
    NOW(),
    'SUCCESS',
    'Transfer to account 15'
);

COMMIT;


-- =========================================================
-- 10. CHECK ACCOUNT BALANCES
-- =========================================================

SELECT
    account_id,
    account_number,
    balance
FROM account
WHERE account_id IN (1,2,3,4,5,6,7,8,9,10);


-- =========================================================
-- 11. CHECK TRANSACTION RECORDS
-- =========================================================

SELECT
    transaction_id,
    account_id,
    transaction_type,
    amount,
    transaction_date,
    status,
    description
FROM `transaction`
ORDER BY transaction_id DESC;


-- =========================================================
-- 12. TRANSACTION USING READ UNCOMMITTED
-- =========================================================

SET SESSION TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

START TRANSACTION;

SELECT
    account_id,
    account_number,
    balance
FROM account
WHERE account_id = 1;

COMMIT;


-- =========================================================
-- 13. TRANSACTION USING READ COMMITTED
-- =========================================================

SET SESSION TRANSACTION ISOLATION LEVEL READ COMMITTED;

START TRANSACTION;

SELECT
    account_id,
    account_number,
    balance
FROM account
WHERE account_id = 2;

COMMIT;


-- =========================================================
-- 14. TRANSACTION USING REPEATABLE READ
-- =========================================================

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;

START TRANSACTION;

SELECT
    account_id,
    account_number,
    balance
FROM account
WHERE account_id = 3;

COMMIT;


-- =========================================================
-- 15. TRANSACTION USING SERIALIZABLE
-- =========================================================

SET SESSION TRANSACTION ISOLATION LEVEL SERIALIZABLE;

START TRANSACTION;

SELECT
    account_id,
    account_number,
    balance
FROM account
WHERE account_id = 4;

COMMIT;


-- =========================================================
-- 16. RESTORE DEFAULT MYSQL ISOLATION LEVEL
-- =========================================================

SET SESSION TRANSACTION ISOLATION LEVEL REPEATABLE READ;
