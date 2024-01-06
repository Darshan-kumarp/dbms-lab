CREATE TABLE STUDENT
(USN VARCHAR(10) PRIMARY KEY,
 SNAME VARCHAR(25),
ADDRESS VARCHAR(25), 
PHONE VARCHAR(10), 
GENDER CHAR(1));

CREATE TABLE SEMSEC(
SSID VARCHAR(5) PRIMARY KEY, 
SEM INT NOT NULL,
SEC VARCHAR(8) NOT NULL);

CREATE TABLE CLASS (
   USN VARCHAR(10),
SSID VARCHAR(5), FOREIGN KEY(USN) REFERENCES STUDENT(USN), FOREIGN KEY(SSID) REFERENCES SEMSEC(SSID));

CREATE TABLE SUBJECT(
SUBCODE VARCHAR(8) PRIMARY KEY,
 TITLE VARCHAR(20),
    SEM INT NOT NULL, 
    CREDITS  INT );
    
CREATE TABLE IAMARKS (
USN VARCHAR(10), 
SUBCODE VARCHAR(8),
 SSID VARCHAR(5), 
TEST1  INT, 
TEST2  INT,
    TEST3  INT, 
     FINALIA INT,FOREIGN KEY(USN)REFERENCES STUDENT(USN), FOREIGN KEY(SUBCODE) REFERENCES SUBJECT(SUBCODE), FOREIGN KEY(SSID) REFERENCES SEMSEC(SSID));
     
insert into student values 
('01jst15cs001','Abhi','tumkur','9875698410','m'),
('01jst15cs002','amulya','gubbi','8896557412','f'),
('01jst16me063','chetan','nittur','7894759458','m'),
('01jst14ec055','raghavi','sspuram','8896557412','f'),
('01jst15ee065','sanjay','bangalore','8896557412','m');

insert into semsec values 
('5A', 5 ,'A'),
('3B',3,'B'),
('8A',8 ,'A'),
('2C',2,'C'),
('4B',4 ,'B'),
('4C',4 ,'C');


insert into class values
('01jst15cs001','5A'),
('01jst15cs002','5A'),
('01jst16me063','3B'),
('01jst14ec055','8A'),
('01jst15ee065','3B'),
('01jst15ee065','4C'),
('01jst15cs002','4C');

insert into subject values
('15cs53','dbms',5,4),
('15cs33','ds',3,4),
('15cs34','co',3,4),
('15cs185','dba',5,2),
('15cs71','oomd',8,4);

insert into iamarks values
('01jst15cs001','15cs53','5A',18,19,15,19),
('01jst15cs002','15cs53','5A',15,16,14,16),
('01jst16me063','15cs33','3B',10,15,16,16),
('01jst14ec055','15cs71','8A',18,20,21,21),
('01jst15ee065','15cs33','3B',16,20,17,19),
('01jst15ee065','15cs53','4C',19,20,18,20);

/////////////////////////////////////////

SELECT S.*,SS.SEM,SS.SEC
     FROM STUDENT S,SEMSEC SS,CLASS C WHERE S.USN=C.USN
     AND SS.SSID=C.SSID
     AND SS.SEM=4 AND SS.SEC='C';
     
//////////////////////////////////////////////////
     
SELECT SS.SEM,SS.SEC,S.GENDER,COUNT(S.GENDER) AS COUNT FROM STUDENT S,SEMSEC SS,CLASS C WHERE S.USN=C.USN
AND SS.SSID=C.SSID GROUP BY SS.SEM,SS.SEC,S.GENDER ORDER BY SEM; 

/////////////////////////////////////////////////

CREATE VIEW STUDENT_TEST1_MARKS_VIEW
     AS SELECT TEST1, SUBCODE
     FROM IAMARKS
     WHERE USN='01jst15ee065';
     
SELECT * FROM STUDENT_TEST1_MARKS_VIEW; 


/////////////////////////////////////////////////////////////////// 


UPDATE IAMARKS SET FINALIA = GREATEST(TEST1+TEST2,TEST2+TEST3,TEST3+TEST1)/2 where usn like '1cg%';
SELECT * FROM IAMARKS;

/////////////////////////////////////////////////////////////////////

SELECT S.USN,S.SNAME,S.ADDRESS,S.PHONE,S.GENDER, IA.SUBCODE,
     (CASE
     WHEN IA.FINALIA BETWEEN 17 AND 20 THEN 'OUTSTANDING'
     WHEN IA.FINALIA BETWEEN 12 AND 16 THEN 'AVERAGE'
     ELSE 'WEAK'
     END) AS CAT
     FROM STUDENT S, SEMSEC SS, IAMARKS IA, SUBJECT SUB
     WHERE S.USN = IA.USN AND
    SS.SSID = IA.SSID AND
     SUB.SUBCODE = IA.SUBCODE AND
     SUB.SEM = 8;

//////////////////////////////////////////////////////////////////////
