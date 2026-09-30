/* =========================================================
   BANKING DATABASE MANAGEMENT SYSTEM
   FILE: 04_insert_data.sql
   PURPOSE: Insert sample data into all tables
   MySQL 8.0+
   ========================================================= */

USE banking_system;


-- =========================================================
-- 1. INSERT 50 CUSTOMERS
-- =========================================================

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


-- =========================================================
-- 2. INSERT 10 BANK BRANCHES
-- =========================================================

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

-- =========================================================
-- 3. INSERT 50 TRANSACTIONS
-- =========================================================

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
