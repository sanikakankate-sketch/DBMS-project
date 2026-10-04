/* =========================================================
   BANKING DATABASE MANAGEMENT SYSTEM
   FILE: 03_constraints.sql
   PURPOSE: Add constraints to database tables
   MySQL 8.0+
   ========================================================= */

USE banking_system;


-- =========================================================
-- 1. CUSTOMER TABLE CONSTRAINTS
-- =========================================================

ALTER TABLE customer
MODIFY name VARCHAR(100) NOT NULL;

ALTER TABLE customer
MODIFY email VARCHAR(100) NOT NULL;

ALTER TABLE customer
MODIFY phone VARCHAR(15) NOT NULL;

ALTER TABLE customer
MODIFY date_of_birth DATE NOT NULL;

ALTER TABLE customer
ADD CONSTRAINT uq_customer_email
UNIQUE (email);


-- =========================================================
-- 2. BANK BRANCH TABLE CONSTRAINTS
-- =========================================================

ALTER TABLE bank_branch
MODIFY branch_name VARCHAR(100) NOT NULL;

ALTER TABLE bank_branch
MODIFY location VARCHAR(100) NOT NULL;

ALTER TABLE bank_branch
MODIFY ifsc_code VARCHAR(11) NOT NULL;

ALTER TABLE bank_branch
ADD CONSTRAINT uq_branch_ifsc
UNIQUE (ifsc_code);


-- =========================================================
-- 3. ACCOUNT TABLE CONSTRAINTS
-- =========================================================

ALTER TABLE account
MODIFY customer_id INT NOT NULL;

ALTER TABLE account
MODIFY branch_id INT NOT NULL;

ALTER TABLE account
MODIFY account_number VARCHAR(16) NOT NULL;

ALTER TABLE account
MODIFY account_type VARCHAR(20) NOT NULL;

ALTER TABLE account
MODIFY balance DECIMAL(15,2) NOT NULL DEFAULT 0;

ALTER TABLE account
MODIFY created_date DATE NOT NULL;

ALTER TABLE account
MODIFY status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE';

ALTER TABLE account
ADD CONSTRAINT uq_account_number
UNIQUE (account_number);

ALTER TABLE account
ADD CONSTRAINT chk_account_type
CHECK (account_type IN ('SAVINGS', 'CURRENT', 'SALARY'));

ALTER TABLE account
ADD CONSTRAINT chk_account_balance
CHECK (balance >= 0);

ALTER TABLE account
ADD CONSTRAINT chk_account_status
CHECK (status IN ('ACTIVE', 'INACTIVE', 'CLOSED'));

ALTER TABLE account
ADD CONSTRAINT fk_account_customer
FOREIGN KEY (customer_id)
REFERENCES customer(customer_id);

ALTER TABLE account
ADD CONSTRAINT fk_account_branch
FOREIGN KEY (branch_id)
REFERENCES bank_branch(branch_id);


-- =========================================================
-- 4. TRANSACTION TABLE CONSTRAINTS
-- =========================================================

ALTER TABLE `transaction`
MODIFY account_id INT NOT NULL;

ALTER TABLE `transaction`
MODIFY transaction_type VARCHAR(15) NOT NULL;

ALTER TABLE `transaction`
MODIFY amount DECIMAL(15,2) NOT NULL;

ALTER TABLE `transaction`
MODIFY transaction_date DATETIME NOT NULL;

ALTER TABLE `transaction`
MODIFY status VARCHAR(10) NOT NULL DEFAULT 'SUCCESS';

ALTER TABLE `transaction`
ADD CONSTRAINT chk_transaction_type
CHECK (transaction_type IN ('DEPOSIT', 'WITHDRAWAL', 'TRANSFER'));

ALTER TABLE `transaction`
ADD CONSTRAINT chk_transaction_amount
CHECK (amount > 0);

ALTER TABLE `transaction`
ADD CONSTRAINT chk_transaction_status
CHECK (status IN ('SUCCESS', 'FAILED', 'PENDING'));

ALTER TABLE `transaction`
ADD CONSTRAINT fk_transaction_account
FOREIGN KEY (account_id)
REFERENCES account(account_id);


-- =========================================================
-- 5. LOAN TABLE CONSTRAINTS
-- =========================================================

ALTER TABLE loan
MODIFY customer_id INT NOT NULL;

ALTER TABLE loan
MODIFY loan_type VARCHAR(20) NOT NULL;

ALTER TABLE loan
MODIFY loan_amount DECIMAL(15,2) NOT NULL;

ALTER TABLE loan
MODIFY interest_rate DECIMAL(5,2) NOT NULL;

ALTER TABLE loan
MODIFY start_date DATE NOT NULL;

ALTER TABLE loan
MODIFY loan_status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE';

ALTER TABLE loan
ADD CONSTRAINT chk_loan_type
CHECK (loan_type IN
('HOME', 'CAR', 'EDUCATION', 'PERSONAL', 'BUSINESS'));

ALTER TABLE loan
ADD CONSTRAINT chk_loan_amount
CHECK (loan_amount > 0);

ALTER TABLE loan
ADD CONSTRAINT chk_interest_rate
CHECK (interest_rate > 0);

ALTER TABLE loan
ADD CONSTRAINT chk_loan_status
CHECK (loan_status IN
('ACTIVE', 'CLOSED', 'DEFAULTED'));

ALTER TABLE loan
ADD CONSTRAINT fk_loan_customer
FOREIGN KEY (customer_id)
REFERENCES customer(customer_id);


-- =========================================================
-- 6. LOAN PAYMENT TABLE CONSTRAINTS
-- =========================================================

ALTER TABLE loan_payment
MODIFY loan_id INT NOT NULL;

ALTER TABLE loan_payment
MODIFY payment_id INT NOT NULL;

ALTER TABLE loan_payment
MODIFY amount_paid DECIMAL(15,2) NOT NULL;

ALTER TABLE loan_payment
MODIFY payment_date DATE NOT NULL;

ALTER TABLE loan_payment
MODIFY payment_status VARCHAR(10) NOT NULL DEFAULT 'PAID';

ALTER TABLE loan_payment
ADD CONSTRAINT chk_payment_amount
CHECK (amount_paid > 0);

ALTER TABLE loan_payment
ADD CONSTRAINT chk_payment_status
CHECK (payment_status IN
('PAID', 'PENDING', 'FAILED'));

ALTER TABLE loan_payment
ADD CONSTRAINT fk_payment_loan
FOREIGN KEY (loan_id)
REFERENCES loan(loan_id)
ON DELETE CASCADE;
