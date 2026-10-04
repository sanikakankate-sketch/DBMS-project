/* =========================================================
   BANKING DATABASE MANAGEMENT SYSTEM
   FILE: 02_create_tables.sql
   PURPOSE: Create all tables
   MySQL 8.0+
   ========================================================= */

USE banking_system;


-- =========================================================
-- 1. CUSTOMER TABLE
-- =========================================================

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    address VARCHAR(255),
    date_of_birth DATE,
    age INT
);


-- =========================================================
-- 2. BANK BRANCH TABLE
-- =========================================================

CREATE TABLE bank_branch (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(100),
    location VARCHAR(100),
    ifsc_code VARCHAR(11)
);


-- =========================================================
-- 3. ACCOUNT TABLE
-- =========================================================

CREATE TABLE account (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    branch_id INT,
    account_number VARCHAR(16),
    account_type VARCHAR(20),
    balance DECIMAL(15,2),
    created_date DATE,
    status VARCHAR(10)
);


-- =========================================================
-- 4. TRANSACTION TABLE
-- =========================================================

CREATE TABLE `transaction` (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT,
    transaction_type VARCHAR(15),
    amount DECIMAL(15,2),
    transaction_date DATETIME,
    status VARCHAR(10),
    description VARCHAR(255)
);


-- =========================================================
-- 5. LOAN TABLE
-- =========================================================

CREATE TABLE loan (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    loan_type VARCHAR(20),
    loan_amount DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    start_date DATE,
    loan_status VARCHAR(10)
);


-- =========================================================
-- 6. LOAN PAYMENT TABLE
-- =========================================================

CREATE TABLE loan_payment (
    loan_id INT,
    payment_id INT,
    amount_paid DECIMAL(15,2),
    payment_date DATE,
    payment_status VARCHAR(10),

    PRIMARY KEY (loan_id, payment_id)
);
