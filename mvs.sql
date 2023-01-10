create database mvs_hostel;
use mvs_hostel;
 
 drop database mvs_hostel;
-- 2
create table student(
sid int primary key,
dob date not null,
fname varchar(15) not null,
lname varchar(15) not null,
street varchar(15) not null,
city varchar(15) not null,
scode int not null,
-- sit varchar(30),
nationality varchar(10) not null,
age int not null,
study varchar(20), -- Ug or pg  
placeno varchar(10),
status_1 varchar(10), -- placed or not 
foreign key(placeno) references office(placeno) on delete cascade on update cascade);

desc student;

-- 1
create table office(
-- office_id int,
-- oname varchar(20) not null,
placeno varchar(10) primary key,
fno int,
hno int
-- foreign key(fno) references apartment(fno) on delete cascade on update cascade,
-- foreign key(hno) references apartment(hno) on delete cascade on update cascade
);
drop table office;
-- 3
create table hall(
hno int primary key,
hname varchar(20) not null,
m_id int ,
mname varchar(20) ,
address varchar(20) not null,
tno int,

office_id int);
-- foreign key(office_id) references office(office_id) on delete cascade on update cascade);


-- 4
create table apartment
(
office_id int,
fno int primary key,
aname varchar(20) not null,
address varchar(20) not null,
no_of_dorm int -- in each apartment 
-- foreign key (rid) references residency_office(rid)
);
-- 5
create table rooms
(
-- hno for connection rplaceno is requirred!
hno int,
rno int,
rplaceno varchar(10),
foreign key(hno)references hall(hno) on delete cascade on update cascade,
foreign key(rplaceno)references office(placeno) on delete cascade on update cascade,
primary key(hno,rno)
);
-- 6
create table dormitory
(
-- fno,dno,dbedno isn't required as its present in dplaceno -- fno only for connection
fno int,
dno int,
dbedno int,
dplaceno varchar(10),
foreign key(fno)references apartment(fno) on delete cascade on update cascade,
foreign key(dplaceno)references office(placeno) on delete cascade on update cascade,
 primary key(dno,dbedno)
);
drop table dormitory;
-- 7
create table invoice
( 
iid int primary key,
term varchar(10), -- t1,t2,t3
sid int,
sname varchar(20),-- full
due_amt int,
pdate date,
placeno varchar(10), -- p
-- roomno int 
address varchar(20),
foreign key (sid) references student(sid) on delete cascade on update cascade,
-- changed
foreign key (placeno) references office(placeno) on delete cascade on update cascade
);

-- 8
create table staff
(
staffid int,
staffname varchar(20),
primary key(staffid)
);

-- 9
create table inspect(
staffid int,
hno int,
fno int,
feedback varchar(10), -- satisfied/ not satisfied
primary key(hno,fno),
foreign key (staffid) references staff(staffid),
foreign key (hno) references hall(hno),
foreign key (fno) references apartment (fno)
);
-- Hallname-roomno(1,2,3..)  Apartmantname-dno(10,20,30..)-bno(1,2,3)
insert into student values(1,'2003-08-15','Rajesh','kumar','jpn','blr',068,'India',18,'UG','Vr1','p');
insert into student values(2,'2003-08-16','Rakesh','kumar','jyn','blr',072,'India',18,'UG','Mr1','np');
insert into student values(3,'2003-08-17','Ramesh','kumar','jpn','blr',068,'India',18,'UG','Ad10b1','p');
insert into student values(4,'2003-08-18','Raveesh','kumar','jyn','blr',072,'India',18,'UG','Ad10b2','p');
insert into student values(5,'2003-08-19','Rashid','kumar','bsg','blr',019,'India',18,'UG','Bd10b1','np');

-- pno fno hno
insert into office values('Vr1',null,1);
insert into office values('Mr1',null,2);
insert into office values('Ad10b1',201,null);
insert into office values('Ad10b2',201,null);
insert into office values('Bd10b1',202,null);

insert into hall values (1,'V',60,'Vict','nrcolony',989,1);
insert into hall values (2,'M',61,'amster','jaynagar',986,1);


insert into apartment values(1,201,'A','nrcolony',5);
insert into apartment values(1,202,'B','jaynagar',8);

truncate apartment;
-- rplace no isn't required
insert into rooms values(1, 1, 81);
insert into rooms values(1, 2, 92);
insert into rooms values(2, 1, 103);
insert into rooms values(2, 2, 114);

truncate dormitory;
-- fno dno dbedno and dplaceno isn't required
insert into dormitory values(201,1,1,'Ad10b1');
insert into dormitory values(201,1,2,'Ad10b2');
insert into dormitory values(202,2,3,'Bd10b1');


insert into staff values(300,'mallikarjun');
insert into staff values(301,'revanth');
insert into staff values(302,'malli');
insert into staff values(303,'zebu');
insert into staff values(304,'leela');
insert into staff values(305,'monu');

insert into inspect values(300,8,null);
insert into inspect values(301,9,null);
insert into inspect values(302,null,202);
insert into inspect values(303,11,203);
insert into inspect values(304,10,204);
insert into inspect values(305,null,201);

-- iid term sid sname due_amt pdate placeno address 
insert into invoice values(1234,1,1,'Rajesh',30000,'2023-04-09','Vr1',);
insert into invoice values(1235,2,1,'Rajesh',25000,'2023-06-09','Vr1',);
insert into invoice values(1236,1,2,'Rakesh',20000,'2023-04-09','Mr1',);
insert into invoice values(1237,1,3,'Ramesh',15000,'2023-04-09','Ad10b1',);
insert into invoice values(1238,2,3,'Ramesh',10000,'2023-04-09','Ad10b1',);
insert into invoice values(1239,1,4,'Raveesh',12000,'2023-04-09','Ad10b2',);

select * from student;
select * from office;
select * from hall;
select * from apartment;
select * from rooms;
select * from dormitory;

-- select s.fname,s.sid
-- from student s, office o , apartment a,dormitory d
-- where d.dno=1 and s.placeno=o.placeno and o.office_id=a.office_id and a.fno=d.fno;

select s.fname,s.sid
from student s, office o 
where s.placeno=o.placeno and o.placeno like "Ad10%";

select s.fname,s.sid
from student s, office o ,apartment a,dormitory d
where s.placeno=o.placeno and o.fno=a.fno and d.fno=a.fno and a.address="jaynagar";

-- Giving fno and hno in office makes join possible.
select o.placeno
from office o, hall h
where o.hno=h.hno and h.hno=1;

select mname,m_id 
from hall 
where hname="V";




