clear screen;

drop table product cascade constraints;
drop table supplier cascade constraints;
drop table customer cascade constraints;
drop table employee cascade constraints;
drop table log_in_history cascade constraints;
drop table purchase cascade constraints;
drop table product_info cascade constraints;
drop table purchase_history cascade constraints;
drop table temp cascade constraints;
drop table request cascade constraints;

DROP SEQUENCE product_seq;
DROP SEQUENCE supplier_seq;
DROP SEQUENCE customer_seq;
DROP SEQUENCE employee_seq;
DROP SEQUENCE purchase_seq;
DROP SEQUENCE request_seq;

create table product
(
	pid NUMBER NOT NULL,
	name varchar2(20),
	catagory varchar2(20),
	brand varchar2(20),
	primary key(pid)
);

CREATE SEQUENCE product_seq START WITH 1;

CREATE OR REPLACE TRIGGER product_id 
BEFORE INSERT ON product 
FOR EACH ROW

BEGIN
  SELECT product_seq.NEXTVAL
  INTO   :new.pid
  FROM   dual;
END;
/


create table supplier
(
	sid NUMBER NOT NULL,
	name varchar2(20),
	numbers number,
	primary key(sid)
);

CREATE SEQUENCE supplier_seq START WITH 1;

CREATE OR REPLACE TRIGGER supplier_id 
BEFORE INSERT ON supplier 
FOR EACH ROW

BEGIN
  SELECT supplier_seq.NEXTVAL
  INTO   :new.sid
  FROM   dual;
END;
/

create table customer
(
	cid NUMBER NOT NULL,
	name varchar2(20),
	numbers number,
	primary key(cid)
);

CREATE SEQUENCE customer_seq START WITH 1;

CREATE OR REPLACE TRIGGER customer_id 
BEFORE INSERT ON customer 
FOR EACH ROW

BEGIN
  SELECT customer_seq.NEXTVAL
  INTO   :new.cid
  FROM   dual;
END;
/

create table employee
(
	eid NUMBER NOT NULL,
	name varchar2(20),
	numbers number,
	password varchar2(20),
	primary key(eid)
);

CREATE SEQUENCE employee_seq START WITH 1;

CREATE OR REPLACE TRIGGER employee_id 
BEFORE INSERT ON employee 
FOR EACH ROW

BEGIN
  SELECT employee_seq.NEXTVAL
  INTO   :new.eid
  FROM   dual;
END;
/

create table log_in_history
(
	eid NUMBER,
	log_time TIMESTAMP default LOCALTIMESTAMP,
	status number
);

create table purchase
(
	purchase_id number,
	pid number,
	product_code number
);

create table product_info
(
	product_code number,
	pid number,
	sid number,
	cid number,
	buyprice number,
	sellprice number,
	branch varchar2(20),
	condition varchar2(20),
	status number
);


create table purchase_history
(
	purchase_id NUMBER NOT NULL,
	eid number,
	cid number,
	buyprice number,
	soldprice number,
	capitalprice number,
	purchase_type varchar2(20),
	primary key(purchase_id)
);

CREATE SEQUENCE purchase_seq START WITH 1;

CREATE OR REPLACE TRIGGER purch_id 
BEFORE INSERT ON purchase_history 
FOR EACH ROW

BEGIN
  SELECT purchase_seq.NEXTVAL
  INTO   :new.purchase_id
  FROM   dual;
END;
/

create table temp
(
	pid number,
	product_code number,
	buyprice number,
	sellprice number
);


create table request
(
	rid NUMBER NOT NULL,
	product_code number,
	eid_req number,
	send_to_branch varchar2(20),
	at_branch varchar2(20),
	status number,
	eid_done number,
	primary key(rid)
);

CREATE SEQUENCE request_seq START WITH 1;

CREATE OR REPLACE TRIGGER request_id 
BEFORE INSERT ON request
FOR EACH ROW

BEGIN
  SELECT request_seq.NEXTVAL
  INTO   :new.rid
  FROM   dual;
END;
/

insert into product(name,catagory,brand) values('Nvidia GTX 1050', 'GPU', 'Gigabyte');
insert into product(name,catagory,brand) values('Nvidia GTX 1060', 'GPU', 'Gigabyte');
insert into product(name,catagory,brand) values('Rx 480', 'GPU', 'AMD');
insert into product(name,catagory,brand) values('RX 460', 'GPU', 'AMD');
insert into product(name,catagory,brand) values('Core i7', 'CPU', 'Intel');
insert into product(name,catagory,brand) values('Core i5', 'CPU', 'Intel');
insert into product(name,catagory,brand) values('Ryzen 5', 'CPU', 'AMD');
insert into product(name,catagory,brand) values('Ryzen 7', 'CPU', 'AMD');
insert into product(name,catagory,brand) values('DDR4 DRAM 2400MHz', 'RAM', 'Corsair');
insert into product(name,catagory,brand) values('DDR4 DRAM 3200MHz', 'RAM', 'Twinmos');
insert into product(name,catagory,brand) values('Litepower 550W', 'PSU', 'Thermaltake');


insert into supplier(name,numbers) values('Global Brand',01768532168);
insert into supplier(name,numbers) values('Ryans',01768532167);
insert into supplier(name,numbers) values('UCCBD',01768532166);
insert into supplier(name,numbers) values('Rishit',01768532165);

insert into customer(name,numbers) values('Himel',01768532171);
insert into customer(name,numbers) values('Nafis',01768532172);
insert into customer(name,numbers) values('Azad',01768532173);
insert into customer(name,numbers) values('Faiza',01768532174);
insert into customer(name,numbers) values('Sefat',01768532175);

insert into employee(name,numbers,password) values('Swapnil',01768532155,'1234');
insert into employee(name,numbers,password) values('Shibli',01768532154,'1234');
insert into employee(name,numbers,password) values('Kumkum',01768532153,'123');
insert into employee(name,numbers,password) values('Jisha',01768532152,'4567');

insert into product_info values(1205,2,2,null,38500,42500,'kalabagan','new',0);
insert into product_info values(1206,2,3,null,38500,42500,'kalabagan','new',0);
insert into product_info values(1207,2,null,2,32000,36000,'Dhanmondi','old',0);
insert into product_info values(1208,3,1,null,45500,48500,'kalabagan','new',0);
insert into product_info values(1209,3,1,null,45500,48500,'Dhanmondi','new',0);

insert into log_in_history (eid,status) values(2,0);
insert into log_in_history (eid,status) values(3,0);




commit;



