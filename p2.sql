CREATE TABLE SALESMAN (
SALESMAN_ID INT(5) PRIMARY KEY,
 NAME VARCHAR(10) NOT NULL,
CITY VARCHAR(15) NOT NULL,
 COMMISSION INT(5));

CREATE TABLE CUSTOMER (
CUSTOMER_ID INT(5) PRIMARY KEY,
CUST_NAME VARCHAR(10) NOT NULL, 
CITY VARCHAR(10) NOT NULL,
GRADE INT(5) NOT NULL,
SALESMAN_ID INT(5),
FOREIGN KEY (SALESMAN_ID)  REFERENCES
SALESMAN(SALESMAN_ID) ON DELETE SET NULL);

CREATE TABLE ORDERS (
ORD_NO INT(5) PRIMARY KEY, 
PURCHASE_AMT INTEGER NOT NULL,
ORD_DATE DATE NOT NULL,
CUSTOMER_ID INT(5) ,
SALESMAN_ID INT(5) ,
FOREIGN KEY (CUSTOMER_ID)  REFERENCES CUSTOMER(CUSTOMER_ID),
FOREIGN KEY (SALESMAN_ID) REFERENCES SALESMAN(SALESMAN_ID) ON DELETE CASCADE);

INSERT INTO SALESMAN VALUES (1000,'RAJ','BENGALURU',50);
INSERT INTO SALESMAN VALUES (2000,'ASHWIN','TUMKUR',30);
INSERT INTO SALESMAN VALUES (3000,'BINDU','MUMBAI',40);
INSERT INTO SALESMAN VALUES (4000,'LAVANYA','BENGALURU',40);
INSERT INTO SALESMAN VALUES (5000,'ROHIT','MYSORE',60);

INSERT INTO CUSTOMER VALUES (11,'INFOSYS','BENGALURU',5,1000);
INSERT INTO CUSTOMER VALUES (22,'TCS','BENGALURU',4,2000);
INSERT INTO CUSTOMER VALUES (33,'WIPRO','MYSORE',7,1000);
INSERT INTO CUSTOMER VALUES (44,'TCS','MYSORE',6,2000);
INSERT INTO CUSTOMER VALUES (55,'ORACLE','TUMKUR',3,3000);

INSERT INTO ORDERS VALUES (1,200000,'12-04-16',11,1000);
INSERT INTO ORDERS VALUES (2,300000,'12-04-16',11,2000);
INSERT INTO ORDERS VALUES (3,400000,'15-04-17',22,1000);


**************queries**************

1.


SELECT COUNT(CUSTOMER_ID) FROM CUSTOMER WHERE GRADE> (SELECT AVG(GRADE)FROM CUSTOMER WHERE CITY LIKE '%BENGALURU');

2.

SELECT NAME, COUNT(CUSTOMER_ID) FROM SALESMAN S, CUSTOMER C WHERE 
S.SALESMAN_ID=C.SALESMAN_ID GROUP BY NAME HAVING COUNT(CUSTOMER_ID)>1 ;

3.

SELECT NAME FROM SALESMAN S, CUSTOMER C WHERE S.SALESMAN_ID=C.SALESMAN_ID AND S.CITY = C. CITY) 
UNION (SELECT NAME FROM SALESMAN WHERE SALESMAN_ID NOT IN (SELECT S1.SALESMAN_ID FROM SALESMAN S1, CUSTOMER C1 WHERE S1. SALESMAN_ID=C1.SALESMAN_ID AND S1.CITY=C1.CITY));

4.

CREATE VIEW SALES_HIGHERODER AS SELECT SALESMAN_ID, PURCHASE_AMT   FROM ORDERS 
WHERE PURCHASE_AMT= (SELECT MAX(O_PURCHASE_AMT) FROM ORDERS O
WHERE O.ORD_DATE='12-04-16');

5.

DELETE FROM SALESMAN WHERE SALESMAN_ID= 1000;


6.

alter table ORDERS add index keyy (CUSTOMER_ID);
show indexes from ORDERS;

