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
