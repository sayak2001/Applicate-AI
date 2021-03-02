create database AplicateAI;
use aplicateai;

# creating the tables firstly
create table Shop(
shopid int PRIMARY KEY,
shopname varchar(45)
);

create table Product(
prodid int PRIMARY KEY,
shopid int not null,
price decimal(10,2),
maxAvail int,
Date date,
UNIQUE(shopid)
);

create table stockavailability(
stkid int PRIMARY KEY,
prodid int not null,
stkavail int,
price decimal(10,2),
date date,
UNIQUE(prodid)
);

# inserting some data
insert into shop(shopid, shopname) values(1, 'ABC Enterprise');
insert into shop(shopid, shopname) values(2, 'MNO Enterprise');
insert into shop(shopid, shopname) values(3, 'PQR Enterprise');
insert into shop(shopid, shopname) values(4, 'GHI Enterprise');
insert into shop(shopid, shopname) values(5, 'XYZ Enterprise');

insert into product(prodid, shopid, price, maxavail, date) values (11, 1, 25.99, 100, '2020-10-23');
insert into product(prodid, shopid, price, maxavail, date) values (12, 2, 24.99, 111, '2020-10-30');
insert into product(prodid, shopid, price, maxavail, date) values (13, 3, 29.99, 98, '2020-10-21');
insert into product(prodid, shopid, price, maxavail, date) values (14, 4, 24.99, 95, '2020-10-25');
insert into product(prodid, shopid, price, maxavail, date) values (15, 5, 19.99, 88, '2020-10-19');

insert into stockavailability(stkid, prodid, stkavail, price, date) values (111, 11, 98, 25.99, '2020-10-23');
insert into stockavailability(stkid, prodid, stkavail, price, date) values (112, 12, 110, 24.99, '2020-10-30');
insert into stockavailability(stkid, prodid, stkavail, price, date) values (113, 13, 95, 29.99, '2020-10-21');
insert into stockavailability(stkid, prodid, stkavail, price, date) values (114, 14, 91, 24.99, '2020-10-25');
insert into stockavailability(stkid, prodid, stkavail, price, date) values (115, 15, 85, 19.99, '2020-10-19');


# create stored procedure for date and prodid as parameters

create view dealerview as
select s.shopname, p.shopid, p.maxavail, st.* from shop s join product p
on s.shopid = p.shopid
join stockavailability st
on p.prodid = st.prodid;
select * from dealerview;

DELIMITER $$
create procedure prodprocedure (
	in proddate date,
    in productid int
)
BEGIN
	select * from dealerview where stkavail > 0 and date = proddate;
END
$$
DELIMITER ;