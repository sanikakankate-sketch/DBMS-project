# DBMS-project
# 🏦 Banking Database Management System

A complete SQL-based Banking Database Management System developed using MySQL.

This project demonstrates database design, data management, SQL queries, joins, subqueries, aggregate functions, views, stored procedures, triggers, transactions, and indexes.

---

## 📌 Project Overview

The Banking Database Management System is designed to manage important banking operations such as:

- Customer management
- Bank branch management
- Account management
- Transaction management
- Loan management
- Loan payment management

The project demonstrates how a relational database can be designed and managed using SQL.

---

## 🛠️ Technologies Used

- MySQL 8.0+
- SQL
- Relational Database Management System (RDBMS)
- Git
- GitHub

---

## 🗂️ Database Tables

The database contains the following tables:

### 1. Customer

Stores customer information such as:

- Customer ID
- Name
- Email
- Phone
- Address
- Date of Birth
- Age

### 2. Bank Branch

Stores information about bank branches:

- Branch ID
- Branch Name
- Location
- IFSC Code

### 3. Account

Stores customer bank account information:

- Account ID
- Customer ID
- Branch ID
- Account Number
- Account Type
- Balance
- Created Date
- Status

### 4. Transaction

Stores account transaction information:

- Transaction ID
- Account ID
- Transaction Type
- Amount
- Transaction Date
- Status
- Description

### 5. Loan

Stores customer loan information:

- Loan ID
- Customer ID
- Loan Type
- Loan Amount
- Interest Rate
- Start Date
- Loan Status

### 6. Loan Payment

Stores loan payment information:

- Loan ID
- Payment ID
- Amount Paid
- Payment Date
- Payment Status

---

## 📁 Project Structure

```text
DBMS-project/
│
├── 01_create_database.sql
├── 02_create_tables.sql
├── 03_constraints.sql
├── 04_insert_data.sql
├── 05_basic_queries.sql
├── 06_joins.sql
├── 07_subqueries.sql
├── 08_aggregate_queries.sql
├── 09_views.sql
├── 10_stored_procedures.sql
├── 11_triggers.sql
├── 12_transactions.sql
├── 13_indexes.sql
└── README.md
