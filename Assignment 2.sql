use aplicateai;

# 1. UPLOAD DATA IN ORDER TABLE WITH UNIQUE KEY ' InvoiceNor,MaterialNumber'
create table dealer(
API varchar(10),
BasePrice decimal(10,3),
CREATIONDATE date,
CREATIONDATETIME datetime,
DealerCode decimal(20,3),
DealerName varchar(45),
DistChannel varchar(45),
Division varchar(45),
GroPrice int,
InvoiceDate date,
InvoiceNor int not null,
MRP decimal(10,3),
MaterialDescription varchar(45),
MaterialGrp2 varchar(45),
MaterialNumber decimal(10,3) not null,
Month int,
NSP decimal(10,2),
OfficerName varchar(45),
Officercode varchar(45),
OrderCreationdate date,
QTY int,
RSOCode varchar(45),
Region varchar(45),
SalesOfficeCode varchar(45),
SuppPLname varchar(45),
SuppPlant varchar(45),
Tax decimal(10,2),
Year int,
unique(InvoiceNor, MaterialNumber)
);

show global variables like 'local_infile';
set global local_infile=1;
LOAD DATA LOCAL INFILE 'E:\study\step2assignmentforsqldeveloperopportunityinternship\ASSIGNMENT AND DATA.csv' into table aplicateai.dealer
FIELDS TERMINATED BY ','
ENCLOSED BY ""
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(API,BasePrice,CREATIONDATE,CREATIONDATETIME,DealerCode,DealerName,DistChannel,Division,GroPrice,InvoiceDate,InvoiceNor,MRP,MaterialDescription,MaterialGrp2,MaterialNumber,Month,NSP,OfficerName,Officercode,OrderCreationdate,QTY,RSOCode,Region,SalesOfficeCode,SuppPLname,SuppPlant,Tax,Year);

# 2. FIND TOP 5 DEALER IN MONTH ON BASIS OF AMOUNT 
select DealerName, month(creationdate), GoPrice * QTY as Amount from dealer order by Amount desc limit 5;

# 3. FIND LAST ORDER OF EACH DELEAR
select * from dealer group by dealername order by date desc limit 1;

# 4. FIND AVARAGE AMOUNT OF EACH DELEAR
select dealername, avg(Goprice * QTY) as `Average aount` from dealer group by dealername;

# 5. FIND 2ND HIGHEST BILLED AMOUNT DEALEAR NAME
select dealername from 
(select dealername, (Goprice * QTY) as Amount from dealer group by dealername order by Amount limit 2) 
dealer1 order by Amount asc limit 1;

# 6. FIND HOURLY AMOUNT BILLED
select hour(creationdatetime) as `HourBill`, sum(Goprice * QTY) as `AmountSum` from dealer
group by HourBill;

# 7. FIND DATEWISE TOTAL QTY
select date(creationdate) as CreationDate, sum(QTY) as TotalQuantity  from dealer
group by creationdate order by creationdate asc;

# 8. FIND TOTAL NO OF DELEAR WHO HAVE AMOUNT GREATER THAN 50000
select count(*) from
(select dealername, sum(Goprice * QTY) as TotalAmount
from dealer where Amount > 50000 group by dealername) dealer2;

# 9. PUT A LABLE TOP IF DEALER AMOUNT IN MONTH IS GEATER THAN 10000 ELSE LABLE AVG AND SHOW LIST
select dealername,
if (`Amount in Month` > 10000, 'TOP', 'AVG') as `Label`
from (select dealername, month(creationdate) as `Month`, sum(Goprice * QTY) as `Amount in Month` from dealer
group by dealername, `Month`) dealer3;

# 10. LIST DELEAR NAME WHOSE NAME STARTS WITH B
select dealername from dealer where dealername like 'B%';