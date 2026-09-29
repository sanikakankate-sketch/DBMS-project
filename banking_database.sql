/* =========================================================
   BANKING DATABASE MANAGEMENT SYSTEM
   DBMS PROJECT
   MySQL 8.0+
   ========================================================= */


/* =========================================================
   1. DROP EXISTING TABLES
   ========================================================= */

DROP TABLE IF EXISTS loan_payment;
DROP TABLE IF EXISTS loan;
DROP TABLE IF EXISTS `transaction`;
DROP TABLE IF EXISTS account;
DROP TABLE IF EXISTS bank_branch;
DROP TABLE IF EXISTS customer;


/* =========================================================
   2. CREATE CUSTOMER TABLE
   ========================================================= */

CREATE TABLE customer (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15) NOT NULL,
    address VARCHAR(255),
    date_of_birth DATE NOT NULL,
    age INT
);


/* =========================================================
   3. CREATE BANK BRANCH TABLE
   ========================================================= */

CREATE TABLE bank_branch (
    branch_id INT PRIMARY KEY AUTO_INCREMENT,
    branch_name VARCHAR(100) NOT NULL,
    location VARCHAR(100) NOT NULL,
    ifsc_code VARCHAR(11) NOT NULL UNIQUE
);


/* =========================================================
   4. CREATE ACCOUNT TABLE
   ========================================================= */

CREATE TABLE account (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    branch_id INT NOT NULL,
    account_number VARCHAR(16) NOT NULL UNIQUE,
    account_type VARCHAR(20) NOT NULL,
    balance DECIMAL(15,2) NOT NULL DEFAULT 0,
    created_date DATE NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',

    CONSTRAINT chk_account_type
        CHECK (account_type IN ('SAVINGS','CURRENT','SALARY')),

    CONSTRAINT chk_account_balance
        CHECK (balance >= 0),

    CONSTRAINT chk_account_status
        CHECK (status IN ('ACTIVE','INACTIVE','CLOSED')),

    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id),

    FOREIGN KEY (branch_id)
        REFERENCES bank_branch(branch_id)
);


/* =========================================================
   5. CREATE TRANSACTION TABLE
   ========================================================= */

CREATE TABLE `transaction` (
    transaction_id INT PRIMARY KEY AUTO_INCREMENT,
    account_id INT NOT NULL,
    transaction_type VARCHAR(15) NOT NULL,
    amount DECIMAL(15,2) NOT NULL,
    transaction_date DATETIME NOT NULL,
    status VARCHAR(10) NOT NULL DEFAULT 'SUCCESS',
    description VARCHAR(255),

    CONSTRAINT chk_transaction_type
        CHECK (transaction_type IN ('DEPOSIT','WITHDRAWAL','TRANSFER')),

    CONSTRAINT chk_transaction_amount
        CHECK (amount > 0),

    CONSTRAINT chk_transaction_status
        CHECK (status IN ('SUCCESS','FAILED','PENDING')),

    FOREIGN KEY (account_id)
        REFERENCES account(account_id)
);


/* =========================================================
   6. CREATE LOAN TABLE
   ========================================================= */

CREATE TABLE loan (
    loan_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    loan_type VARCHAR(20) NOT NULL,
    loan_amount DECIMAL(15,2) NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    start_date DATE NOT NULL,
    loan_status VARCHAR(10) NOT NULL DEFAULT 'ACTIVE',

    CONSTRAINT chk_loan_type
        CHECK (loan_type IN
        ('HOME','CAR','EDUCATION','PERSONAL','BUSINESS')),

    CONSTRAINT chk_loan_amount
        CHECK (loan_amount > 0),

    CONSTRAINT chk_interest_rate
        CHECK (interest_rate > 0),

    CONSTRAINT chk_loan_status
        CHECK (loan_status IN
        ('ACTIVE','CLOSED','DEFAULTED')),

    FOREIGN KEY (customer_id)
        REFERENCES customer(customer_id)
);


/* =========================================================
   7. CREATE LOAN PAYMENT TABLE
   Weak Entity:
   Identified by composite key (loan_id, payment_id)
   ========================================================= */

CREATE TABLE loan_payment (
    loan_id INT NOT NULL,
    payment_id INT NOT NULL,
    amount_paid DECIMAL(15,2) NOT NULL,
    payment_date DATE NOT NULL,
    payment_status VARCHAR(10) NOT NULL DEFAULT 'PAID',

    PRIMARY KEY (loan_id, payment_id),

    CONSTRAINT chk_payment_amount
        CHECK (amount_paid > 0),

    CONSTRAINT chk_payment_status
        CHECK (payment_status IN
        ('PAID','PENDING','FAILED')),

    FOREIGN KEY (loan_id)
        REFERENCES loan(loan_id)
        ON DELETE CASCADE
);


/* =========================================================
   8. INSERT 50 CUSTOMERS
   ========================================================= */

INSERT INTO customer
(customer_id, name, email, phone, address, date_of_birth, age)
VALUES
(1,'Rajesh Kulkarni','rajesh.kulkarni1@example.com','9181960013','29, Shivaji Nagar, Nagpur, Maharashtra','1961-12-09',64),
(2,'Meera Nair','meera.nair2@example.com','9637940265','92, Wakad, Nagpur, Maharashtra','1998-01-18',28),
(3,'Sanjay Joshi','sanjay.joshi3@example.com','9559407816','49, FC Road, Mumbai, Maharashtra','1973-06-04',53),
(4,'Pooja Reddy','pooja.reddy4@example.com','9103413164','74, Kothrud, Satara, Maharashtra','1978-11-20',47),
(5,'Yash Chavan','yash.chavan5@example.com','9192832764','27, Baner, Satara, Maharashtra','1983-03-12',43),
(6,'Madhuri Desai','madhuri.desai6@example.com','9305641395','108, MG Road, Satara, Maharashtra','1995-04-22',31),
(7,'Karan Chavan','karan.chavan7@example.com','9238849696','19, Baner, Solapur, Maharashtra','1991-07-21',35),
(8,'Swati Pawar','swati.pawar8@example.com','9122691669','97, MG Road, Mumbai, Maharashtra','1968-09-16',58),
(9,'Yash Nair','yash.nair9@example.com','9845146270','88, FC Road, Pune, Maharashtra','1976-09-28',50),
(10,'Shweta Rane','shweta.rane10@example.com','9489325288','65, FC Road, Nashik, Maharashtra','1976-09-25',50),
(11,'Rahul Kapoor','rahul.kapoor11@example.com','9430391171','119, Hadapsar, Mumbai, Maharashtra','1980-08-01',46),
(12,'Pallavi Reddy','pallavi.reddy12@example.com','9489638346','71, Shivaji Nagar, Solapur, Maharashtra','1968-03-22',58),
(13,'Ganesh Chavan','ganesh.chavan13@example.com','9315098393','16, Kothrud, Solapur, Maharashtra','1983-08-17',43),
(14,'Priya Deshmukh','priya.deshmukh14@example.com','9518347382','116, MG Road, Mumbai, Maharashtra','2000-01-08',26),
(15,'Mihir Singh','mihir.singh15@example.com','9311656670','104, Camp, Solapur, Maharashtra','1996-08-08',30),
(16,'Snehal Chavan','snehal.chavan16@example.com','9133387262','94, Hadapsar, Aurangabad, Maharashtra','2001-02-02',25),
(17,'Sanjay Verma','sanjay.verma17@example.com','9013267736','7, Wakad, Mumbai, Maharashtra','1975-02-15',51),
(18,'Sneha Kadam','sneha.kadam18@example.com','9468723430','119, Aundh, Kolhapur, Maharashtra','1984-01-13',42),
(19,'Varun Rane','varun.rane19@example.com','9978820812','8, MG Road, Satara, Maharashtra','1994-01-24',32),
(20,'Pooja Kapoor','pooja.kapoor20@example.com','9939909169','52, FC Road, Nagpur, Maharashtra','1964-11-28',61),
(21,'Varun Nair','varun.nair21@example.com','9624751079','31, Baner, Satara, Maharashtra','1980-05-07',46),
(22,'Tanvi Kulkarni','tanvi.kulkarni22@example.com','9135427849','17, Hadapsar, Kolhapur, Maharashtra','1964-09-07',62),
(23,'Rajesh Nair','rajesh.nair23@example.com','9241182449','120, FC Road, Kolhapur, Maharashtra','1960-11-27',65),
(24,'Rutuja Desai','rutuja.desai24@example.com','9401640052','65, Aundh, Kolhapur, Maharashtra','1981-04-22',45),
(25,'Rajesh More','rajesh.more25@example.com','9112805982','72, MG Road, Aurangabad, Maharashtra','1970-12-15',55),
(26,'Aarti Joshi','aarti.joshi26@example.com','9331586923','116, Hadapsar, Pune, Maharashtra','1962-05-12',64),
(27,'Arjun Kadam','arjun.kadam27@example.com','9342160733','101, Camp, Satara, Maharashtra','1986-01-06',40),
(28,'Nisha Bhosale','nisha.bhosale28@example.com','9654145868','85, Kothrud, Pune, Maharashtra','1979-04-08',47),
(29,'Manish Sharma','manish.sharma29@example.com','9965569816','5, FC Road, Kolhapur, Maharashtra','1967-05-06',59),
(30,'Tanvi Jadhav','tanvi.jadhav30@example.com','9835615951','1, Wakad, Aurangabad, Maharashtra','1976-01-23',50),
(31,'Mihir Shinde','mihir.shinde31@example.com','9482366299','42, Camp, Aurangabad, Maharashtra','1992-05-22',34),
(32,'Isha Mehta','isha.mehta32@example.com','9995777387','27, Camp, Kolhapur, Maharashtra','1995-01-10',31),
(33,'Mihir Kadam','mihir.kadam33@example.com','9433200379','12, Kothrud, Satara, Maharashtra','2002-02-10',24),
(34,'Pallavi Deshmukh','pallavi.deshmukh34@example.com','9763201632','92, Camp, Nagpur, Maharashtra','1989-07-21',37),
(35,'Siddharth Nair','siddharth.nair35@example.com','9727889579','118, FC Road, Nagpur, Maharashtra','1989-01-18',37),
(36,'Shweta Nair','shweta.nair36@example.com','9743487347','96, Aundh, Nashik, Maharashtra','1987-09-15',39),
(37,'Rohan Desai','rohan.desai37@example.com','9122362316','41, Wakad, Satara, Maharashtra','1978-04-09',48),
(38,'Aarti Gaikwad','aarti.gaikwad38@example.com','9690967054','27, Camp, Pune, Maharashtra','1994-08-14',32),
(39,'Abhishek Mehta','abhishek.mehta39@example.com','9467065627','63, Kothrud, Nagpur, Maharashtra','1986-09-24',40),
(40,'Kavita Kapoor','kavita.kapoor40@example.com','9272046537','11, Camp, Pune, Maharashtra','1994-01-13',32),
(41,'Manish Gaikwad','manish.gaikwad41@example.com','9708053100','33, FC Road, Aurangabad, Maharashtra','1984-05-25',42),
(42,'Meera Jadhav','meera.jadhav42@example.com','9193745299','17, Aundh, Nagpur, Maharashtra','1961-10-05',64),
(43,'Mihir Desai','mihir.desai43@example.com','9496631931','75, MG Road, Mumbai, Maharashtra','1967-03-10',59),
(44,'Ankita Thakur','ankita.thakur44@example.com','9058651850','102, Karve Nagar, Mumbai, Maharashtra','1979-11-20',46),
(45,'Sameer Iyer','sameer.iyer45@example.com','9628498776','91, Shivaji Nagar, Solapur, Maharashtra','1966-07-12',60),
(46,'Shweta Singh','shweta.singh46@example.com','9473799650','107, FC Road, Nagpur, Maharashtra','1977-06-28',49),
(47,'Harsh Gaikwad','harsh.gaikwad47@example.com','9549480831','103, Baner, Satara, Maharashtra','1971-08-07',55),
(48,'Meera Rane','meera.rane48@example.com','9770143634','89, Aundh, Nagpur, Maharashtra','1986-08-18',40),
(49,'Ganesh Singh','ganesh.singh49@example.com','9557444313','55, Wakad, Satara, Maharashtra','1983-08-18',43),
(50,'Shruti Kulkarni','shruti.kulkarni50@example.com','9498941343','28, Aundh, Nagpur, Maharashtra','1994-12-06',31);


/* =========================================================
   9. INSERT 10 BANK BRANCHES
   ========================================================= */

INSERT INTO bank_branch
(branch_id, branch_name, location, ifsc_code)
VALUES
(1,'Pune Main Branch','Pune','BKDB0001001'),
(2,'Kothrud Branch','Pune','BKDB0001002'),
(3,'Hadapsar Branch','Pune','BKDB0001003'),
(4,'Fort Branch','Mumbai','BKDB0001004'),
(5,'Andheri Branch','Mumbai','BKDB0001005'),
(6,'Nashik Road Branch','Nashik','BKDB0001006'),
(7,'Sitabuldi Branch','Nagpur','BKDB0001007'),
(8,'Rajarampuri Branch','Kolhapur','BKDB0001008'),
(9,'Satara Main Branch','Satara','BKDB0001009'),
(10,'Solapur Main Branch','Solapur','BKDB0001010');


/* =========================================================
   10. INSERT 50 ACCOUNTS
   ========================================================= */

INSERT INTO account
(account_id, customer_id, branch_id, account_number, account_type, balance, created_date, status)
VALUES
(1,1,6,'1002003040007919','SAVINGS',15900.00,'2018-12-18','ACTIVE'),
(2,2,3,'1002003040015838','SAVINGS',23000.00,'2018-09-10','ACTIVE'),
(3,3,3,'1002003040023757','CURRENT',5700.00,'2018-10-10','ACTIVE'),
(4,4,8,'1002003040031676','CURRENT',36100.00,'2023-03-02','ACTIVE'),
(5,5,5,'1002003040039595','CURRENT',6300.00,'2019-07-16','ACTIVE'),
(6,6,2,'1002003040047514','SALARY',56400.00,'2018-03-05','ACTIVE'),
(7,7,10,'1002003040055433','SAVINGS',4800.00,'2021-02-18','ACTIVE'),
(8,8,7,'1002003040063352','SALARY',45200.00,'2021-09-13','ACTIVE'),
(9,9,8,'1002003040071271','CURRENT',15700.00,'2024-05-19','INACTIVE'),
(10,10,10,'1002003040079190','SAVINGS',39700.00,'2019-04-21','ACTIVE'),
(11,11,4,'1002003040087109','SAVINGS',34300.00,'2019-03-08','ACTIVE'),
(12,12,3,'1002003040095028','SALARY',20400.00,'2020-01-14','ACTIVE'),
(13,13,8,'1002003040102947','SALARY',24500.00,'2022-01-08','ACTIVE'),
(14,14,5,'1002003040110866','SAVINGS',24300.00,'2025-02-22','ACTIVE'),
(15,15,4,'1002003040118785','SAVINGS',40800.00,'2021-07-04','ACTIVE'),
(16,16,9,'1002003040126704','SAVINGS',17100.00,'2020-05-27','ACTIVE'),
(17,17,3,'1002003040134623','SAVINGS',3500.00,'2020-05-20','ACTIVE'),
(18,18,10,'1002003040142542','SAVINGS',22900.00,'2019-08-23','ACTIVE'),
(19,19,5,'1002003040150461','CURRENT',54400.00,'2022-09-18','ACTIVE'),
(20,20,8,'1002003040158380','CURRENT',100.00,'2018-07-24','ACTIVE'),
(21,21,6,'1002003040166299','SALARY',13300.00,'2018-02-08','ACTIVE'),
(22,22,10,'1002003040174218','SALARY',49100.00,'2018-11-27','ACTIVE'),
(23,23,5,'1002003040182137','SALARY',2500.00,'2020-08-17','ACTIVE'),
(24,24,8,'1002003040190056','SAVINGS',17400.00,'2024-11-27','ACTIVE'),
(25,25,8,'1002003040197975','SAVINGS',24500.00,'2023-07-11','ACTIVE'),
(26,26,6,'1002003040205894','SAVINGS',39600.00,'2020-06-14','ACTIVE'),
(27,27,8,'1002003040213813','SAVINGS',34400.00,'2024-09-02','INACTIVE'),
(28,28,8,'1002003040221732','SAVINGS',14700.00,'2022-06-04','ACTIVE'),
(29,29,7,'1002003040229651','SALARY',54800.00,'2018-11-28','ACTIVE'),
(30,30,9,'1002003040237570','CURRENT',39400.00,'2018-04-17','ACTIVE'),
(31,31,6,'1002003040245489','SALARY',47300.00,'2025-11-15','ACTIVE'),
(32,32,1,'1002003040253408','SAVINGS',14100.00,'2020-05-15','ACTIVE'),
(33,33,8,'1002003040261327','SAVINGS',200.00,'2021-12-06','ACTIVE'),
(34,34,5,'1002003040269246','SALARY',1200.00,'2024-02-08','ACTIVE'),
(35,35,2,'1002003040277165','CURRENT',48900.00,'2019-11-27','ACTIVE'),
(36,36,3,'1002003040285084','CURRENT',48200.00,'2022-09-23','ACTIVE'),
(37,37,5,'1002003040293003','CURRENT',42000.00,'2025-08-08','ACTIVE'),
(38,38,8,'1002003040300922','SALARY',7900.00,'2024-04-20','ACTIVE'),
(39,39,9,'1002003040308841','SAVINGS',31000.00,'2019-05-25','ACTIVE'),
(40,40,7,'1002003040316760','SAVINGS',67100.00,'2022-01-10','ACTIVE'),
(41,41,5,'1002003040324679','SALARY',30100.00,'2025-03-15','INACTIVE'),
(42,42,9,'1002003040332598','CURRENT',18100.00,'2023-09-25','ACTIVE'),
(43,43,9,'1002003040340517','CURRENT',26300.00,'2023-04-23','ACTIVE'),
(44,44,4,'1002003040348436','SALARY',36600.00,'2021-07-02','ACTIVE'),
(45,45,6,'1002003040356355','CURRENT',36600.00,'2024-07-22','CLOSED'),
(46,46,3,'1002003040364274','CURRENT',49800.00,'2018-03-17','ACTIVE'),
(47,47,10,'1002003040372193','SAVINGS',50700.00,'2019-08-04','ACTIVE'),
(48,48,9,'1002003040380112','CURRENT',1200.00,'2020-07-28','ACTIVE'),
(49,49,3,'1002003040388031','SAVINGS',60800.00,'2022-06-20','ACTIVE'),
(50,50,7,'1002003040395950','SAVINGS',44100.00,'2023-11-28','ACTIVE');


/* =========================================================
   11. INSERT 50 TRANSACTIONS
   ========================================================= */

INSERT INTO `transaction`
(transaction_id, account_id, transaction_type, amount, transaction_date, status, description)
VALUES
(1,31,'DEPOSIT',8100.00,'2026-01-02 13:50:03','SUCCESS','Cheque deposit'),
(2,28,'TRANSFER',1900.00,'2026-01-07 12:13:49','SUCCESS','Transfer to friend'),
(3,44,'DEPOSIT',16500.00,'2026-01-10 20:28:02','SUCCESS','Cheque deposit'),
(4,47,'TRANSFER',3800.00,'2026-01-12 20:50:15','SUCCESS','Online transfer'),
(5,39,'TRANSFER',19500.00,'2026-01-20 19:31:53','SUCCESS','Online transfer'),
(6,4,'DEPOSIT',19800.00,'2026-01-22 09:17:28','SUCCESS','UPI credit'),
(7,49,'DEPOSIT',10900.00,'2026-02-05 08:02:19','SUCCESS','UPI credit'),
(8,6,'DEPOSIT',4200.00,'2026-02-05 12:39:40','SUCCESS','Cheque deposit'),
(9,20,'WITHDRAWAL',4500.00,'2026-02-15 13:37:19','SUCCESS','Rent payment'),
(10,28,'DEPOSIT',14200.00,'2026-02-15 13:43:47','PENDING','Cheque deposit'),
(11,33,'TRANSFER',11400.00,'2026-02-16 19:58:28','SUCCESS','Fund transfer to family'),
(12,14,'TRANSFER',12100.00,'2026-02-22 11:41:40','SUCCESS','Fund transfer to family'),
(13,24,'TRANSFER',9900.00,'2026-02-25 12:36:14','SUCCESS','NEFT transfer'),
(14,26,'DEPOSIT',9200.00,'2026-03-12 12:46:20','SUCCESS','Cash deposit'),
(15,8,'DEPOSIT',14200.00,'2026-03-13 15:23:42','SUCCESS','UPI credit'),
(16,19,'TRANSFER',4200.00,'2026-03-18 12:51:11','SUCCESS','Fund transfer to family'),
(17,22,'WITHDRAWAL',10000.00,'2026-03-22 15:04:05','PENDING','ATM withdrawal'),
(18,2,'DEPOSIT',1800.00,'2026-03-24 14:33:07','SUCCESS','Cash deposit'),
(19,39,'WITHDRAWAL',2200.00,'2026-03-24 18:01:05','SUCCESS','Cash withdrawal'),
(20,4,'WITHDRAWAL',6700.00,'2026-03-26 17:13:04','SUCCESS','Cash withdrawal'),
(21,24,'DEPOSIT',13400.00,'2026-04-05 18:30:14','SUCCESS','Cash deposit'),
(22,49,'DEPOSIT',8200.00,'2026-04-13 15:06:15','SUCCESS','UPI credit'),
(23,19,'DEPOSIT',9900.00,'2026-04-15 15:15:54','SUCCESS','Cheque deposit'),
(24,24,'DEPOSIT',4200.00,'2026-04-17 14:36:43','SUCCESS','Salary credit'),
(25,16,'WITHDRAWAL',9500.00,'2026-04-21 11:39:16','SUCCESS','Cash withdrawal'),
(26,17,'WITHDRAWAL',7800.00,'2026-04-24 09:27:06','FAILED','ATM withdrawal - insufficient balance'),
(27,39,'DEPOSIT',8000.00,'2026-05-01 18:25:17','SUCCESS','Cash deposit'),
(28,34,'WITHDRAWAL',11100.00,'2026-05-07 20:32:07','FAILED','Bill payment - insufficient balance'),
(29,2,'DEPOSIT',18400.00,'2026-05-11 13:00:11','SUCCESS','Salary credit'),
(30,26,'TRANSFER',14000.00,'2026-05-15 16:38:27','SUCCESS','Fund transfer to family'),
(31,40,'DEPOSIT',16800.00,'2026-06-04 18:14:30','SUCCESS','Cash deposit'),
(32,43,'TRANSFER',14800.00,'2026-06-20 11:41:04','SUCCESS','NEFT transfer'),
(33,10,'DEPOSIT',8000.00,'2026-06-24 14:11:12','SUCCESS','Salary credit'),
(34,40,'DEPOSIT',6400.00,'2026-06-25 10:50:57','SUCCESS','Cash deposit'),
(35,33,'TRANSFER',8000.00,'2026-06-26 09:29:04','FAILED','Transfer to friend - insufficient balance'),
(36,6,'DEPOSIT',19500.00,'2026-06-26 10:35:03','SUCCESS','Cheque deposit'),
(37,29,'DEPOSIT',12100.00,'2026-07-14 19:06:20','SUCCESS','UPI credit'),
(38,12,'DEPOSIT',16100.00,'2026-07-20 18:15:31','SUCCESS','Salary credit'),
(39,40,'WITHDRAWAL',4400.00,'2026-07-21 09:53:31','SUCCESS','Rent payment'),
(40,47,'DEPOSIT',9500.00,'2026-07-28 19:03:18','SUCCESS','Cheque deposit'),
(41,16,'TRANSFER',19000.00,'2026-07-28 20:35:23','FAILED','Fund transfer to family - insufficient balance'),
(42,16,'WITHDRAWAL',7000.00,'2026-08-09 18:00:57','SUCCESS','Rent payment'),
(43,30,'DEPOSIT',17800.00,'2026-08-17 18:19:02','SUCCESS','Salary credit'),
(44,37,'DEPOSIT',8600.00,'2026-08-28 16:02:39','SUCCESS','Cash deposit'),
(45,38,'TRANSFER',16400.00,'2026-09-01 17:59:42','FAILED','Online transfer - insufficient balance'),
(46,43,'DEPOSIT',17300.00,'2026-09-10 15:41:01','SUCCESS','Cash deposit'),
(47,37,'TRANSFER',9800.00,'2026-09-17 12:53:10','SUCCESS','Online transfer'),
(48,33,'DEPOSIT',9700.00,'2026-09-19 09:28:32','SUCCESS','Salary credit'),
(49,7,'TRANSFER',9900.00,'2026-09-21 13:03:25','FAILED','Online transfer - insufficient balance'),
(50,49,'DEPOSIT',17200.00,'2026-09-24 11:27:28','SUCCESS','Salary credit');


/* =========================================================
   12. INSERT 50 LOANS
   ========================================================= */

INSERT INTO loan
(loan_id, customer_id, loan_type, loan_amount, interest_rate, start_date, loan_status)
VALUES
(1,1,'EDUCATION',940000.00,8.74,'2021-08-24','ACTIVE'),
(2,2,'PERSONAL',160000.00,11.94,'2025-04-17','ACTIVE'),
(3,3,'BUSINESS',4760000.00,11.25,'2023-02-13','CLOSED'),
(4,4,'HOME',5960000.00,7.78,'2021-06-19','ACTIVE'),
(5,5,'PERSONAL',410000.00,12.36,'2026-07-10','ACTIVE'),
(6,6,'HOME',5640000.00,7.78,'2023-03-26','ACTIVE'),
(7,7,'BUSINESS',2850000.00,11.50,'2023-02-14','ACTIVE'),
(8,8,'HOME',3990000.00,8.40,'2024-09-03','ACTIVE'),
(9,9,'PERSONAL',240000.00,12.87,'2022-06-25','ACTIVE'),
(10,10,'CAR',390000.00,9.52,'2021-09-17','ACTIVE'),
(11,11,'CAR',1450000.00,9.91,'2023-03-08','ACTIVE'),
(12,12,'HOME',2990000.00,8.13,'2022-03-25','CLOSED'),
(13,13,'HOME',3310000.00,9.18,'2026-08-15','ACTIVE'),
(14,14,'BUSINESS',4390000.00,11.12,'2026-06-28','ACTIVE'),
(15,15,'EDUCATION',580000.00,8.91,'2024-08-21','ACTIVE'),
(16,16,'EDUCATION',900000.00,9.14,'2023-09-03','ACTIVE'),
(17,17,'EDUCATION',1380000.00,8.93,'2021-06-27','ACTIVE'),
(18,18,'EDUCATION',390000.00,9.22,'2021-09-13','ACTIVE'),
(19,19,'PERSONAL',420000.00,12.58,'2026-01-15','ACTIVE'),
(20,20,'BUSINESS',3830000.00,10.53,'2025-08-17','ACTIVE'),
(21,21,'CAR',370000.00,9.43,'2023-02-17','ACTIVE'),
(22,22,'CAR',350000.00,9.12,'2024-08-17','ACTIVE'),
(23,23,'BUSINESS',3620000.00,10.49,'2023-05-13','ACTIVE'),
(24,24,'PERSONAL',260000.00,12.77,'2021-06-03','ACTIVE'),
(25,25,'EDUCATION',440000.00,9.09,'2024-05-09','CLOSED'),
(26,26,'BUSINESS',4970000.00,10.48,'2021-03-12','ACTIVE'),
(27,27,'EDUCATION',1870000.00,9.30,'2024-03-20','ACTIVE'),
(28,28,'HOME',4670000.00,8.59,'2026-06-27','ACTIVE'),
(29,29,'CAR',1150000.00,9.80,'2026-09-03','ACTIVE'),
(30,30,'PERSONAL',320000.00,12.15,'2025-10-12','ACTIVE'),
(31,31,'HOME',4250000.00,7.65,'2024-11-18','ACTIVE'),
(32,32,'EDUCATION',720000.00,8.85,'2025-01-22','ACTIVE'),
(33,33,'CAR',680000.00,9.45,'2024-07-16','ACTIVE'),
(34,34,'PERSONAL',275000.00,12.40,'2026-02-14','ACTIVE'),
(35,35,'BUSINESS',3150000.00,10.75,'2023-10-05','ACTIVE'),
(36,36,'HOME',5200000.00,7.95,'2022-12-19','ACTIVE'),
(37,37,'CAR',890000.00,9.65,'2025-06-11','ACTIVE'),
(38,38,'EDUCATION',610000.00,8.95,'2024-02-28','CLOSED'),
(39,39,'PERSONAL',350000.00,12.25,'2025-09-20','ACTIVE'),
(40,40,'BUSINESS',2780000.00,10.85,'2024-04-15','ACTIVE'),
(41,41,'HOME',4380000.00,7.88,'2025-03-22','ACTIVE'),
(42,42,'CAR',760000.00,9.35,'2023-08-10','ACTIVE'),
(43,43,'PERSONAL',295000.00,12.60,'2026-03-18','ACTIVE'),
(44,44,'BUSINESS',3560000.00,10.65,'2024-06-25','ACTIVE'),
(45,45,'EDUCATION',830000.00,9.05,'2022-09-14','CLOSED'),
(46,46,'HOME',4890000.00,7.72,'2023-11-07','ACTIVE'),
(47,47,'CAR',970000.00,9.55,'2025-05-19','ACTIVE'),
(48,48,'PERSONAL',210000.00,12.90,'2026-01-30','DEFAULTED'),
(49,49,'BUSINESS',4120000.00,10.35,'2023-07-21','ACTIVE'),
(50,50,'EDUCATION',560000.00,8.88,'2025-08-09','ACTIVE');


/* =========================================================
   13. INSERT LOAN PAYMENTS
   Weak Entity
   Composite Primary Key = (loan_id, payment_id)
   ========================================================= */

INSERT INTO loan_payment
(loan_id, payment_id, amount_paid, payment_date, payment_status)
VALUES
(1,1,25000.00,'2026-01-10','PAID'),
(2,1,8500.00,'2026-01-12','PAID'),
(3,1,120000.00,'2025-12-15','PAID'),
(4,1,45000.00,'2026-01-05','PAID'),
(5,1,12000.00,'2026-08-10','PAID'),
(6,1,43000.00,'2026-02-05','PAID'),
(7,1,38000.00,'2026-01-18','PAID'),
(8,1,35000.00,'2026-02-12','PAID'),
(9,1,7500.00,'2026-01-25','PAID'),
(10,1,11000.00,'2026-02-01','PAID'),
(11,1,22000.00,'2026-01-20','PAID'),
(12,1,40000.00,'2025-12-20','PAID'),
(13,1,32000.00,'2026-09-10','PAID'),
(14,1,45000.00,'2026-08-05','PAID'),
(15,1,15000.00,'2026-01-15','PAID'),
(16,1,18000.00,'2026-02-15','PAID'),
(17,1,20000.00,'2026-01-25','PAID'),
(18,1,9000.00,'2026-02-10','PAID'),
(19,1,10500.00,'2026-02-01','PAID'),
(20,1,42000.00,'2026-01-18','PAID'),
(21,1,12000.00,'2026-02-05','PAID'),
(22,1,11500.00,'2026-02-08','PAID'),
(23,1,38000.00,'2026-01-30','PAID'),
(24,1,8500.00,'2026-02-12','PAID'),
(25,1,14000.00,'2025-12-10','PAID'),
(26,1,45000.00,'2026-01-15','PAID'),
(27,1,21000.00,'2026-02-18','PAID'),
(28,1,40000.00,'2026-09-05','PAID'),
(29,1,18000.00,'2026-09-15','PENDING'),
(30,1,9500.00,'2026-01-15','PAID'),
(31,1,42000.00,'2026-02-10','PAID'),
(32,1,13000.00,'2026-02-15','PAID'),
(33,1,16000.00,'2026-01-20','PAID'),
(34,1,9000.00,'2026-03-05','PAID'),
(35,1,35000.00,'2026-02-12','PAID'),
(36,1,44000.00,'2026-01-25','PAID'),
(37,1,19000.00,'2026-02-20','PAID'),
(38,1,12000.00,'2025-12-18','PAID'),
(39,1,9500.00,'2026-02-05','PAID'),
(40,1,33000.00,'2026-01-30','PAID'),
(41,1,41000.00,'2026-02-10','PAID'),
(42,1,17000.00,'2026-01-18','PAID'),
(43,1,8500.00,'2026-04-05','PENDING'),
(44,1,36000.00,'2026-02-15','PAID'),
(45,1,15000.00,'2025-12-20','PAID'),
(46,1,43000.00,'2026-01-25','PAID'),
(47,1,20000.00,'2026-02-05','PAID'),
(48,1,7000.00,'2026-03-10','FAILED'),
(49,1,39000.00,'2026-02-20','PAID'),
(50,1,13000.00,'2026-02-15','PAID');


/* =========================================================
   14. VERIFICATION QUERIES
   ========================================================= */

/* Check number of customers */
SELECT COUNT(*) AS total_customers
FROM customer;

/* Check number of branches */
SELECT COUNT(*) AS total_branches
FROM bank_branch;

/* Check number of accounts */
SELECT COUNT(*) AS total_accounts
FROM account;

/* Check number of transactions */
SELECT COUNT(*) AS total_transactions
FROM `transaction`;

/* Check number of loans */
SELECT COUNT(*) AS total_loans
FROM loan;

/* Check number of loan payments */
SELECT COUNT(*) AS total_loan_payments
FROM loan_payment;


/* =========================================================
   END OF BANKING DATABASE PROJECT
   ========================================================= */
