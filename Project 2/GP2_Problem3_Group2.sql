/* Problem 3.a =========================================================== */
create table Manager (
  mid int,
  name varchar(20),
  salary float(2),
  hours_worked int,
  title varchar(20),
  primary key(mid)
);

create table Worker (
  wid int, 
  name varchar(20),
  salary float(2),
  hours_worked int,
  mid int,
  primary key(wid),
  foreign key(mid) references Manager
);

create table Phone (
  wid int,
  phone_number char(10),
  primary key(wid, phone_number),
  foreign key(wid) references Worker
);

create table Chef (
  cid int,
  specialty varchar(20),
  title varchar(20),
  replaces_id int,
  primary key(cid),
  foreign key(cid) references Worker(wid),
  foreign key(replaces_id) references Chef(cid)
);

create table Dish (
  name varchar(20),
  price float(2),
  cid int,
  times_prepared int,
  primary key(name),
  foreign key(cid) references Chef
);

create table Ingredient (
  dishname varchar(20),
  name varchar(20),
  primary key(dishname, name),
  foreign key(dishname) references Dish(name)
);

create table Waiter (
  wid int,
  number_of_customers int,
  primary key(wid),
  foreign key(wid) references Worker
);

create table Section (
  section_number int,
  wid int,
  primary key(section_number),
  foreign key(wid) references Waiter
);

create table Rest_Table (
  section_number int,
  table_number int,
  number_of_chairs int,
  primary key(section_number, table_number),
  foreign key(section_number) references Section
);

create table Cleaner (
  cid int,
  specialty varchar(20),
  primary key(cid),
  foreign key(cid) references Worker(wid)
);

create table Eval (
  eid int,
  description varchar(256),
  edate char(10),
  primary key(eid)
);

create table Evaluated (
  wid int,
  eid int,
  primary key(wid, eid),
  foreign key(wid) references Worker,
  foreign key(eid) references Eval
);

/* Problem 3.b =========================================================== */
/* Add the Manager */
insert into Manager values(1, 'Kyouko Shirafuji', 400000.90, 0, 'Working!! Manager');
insert into Manager values(2, 'Senzaemon Nakiri', 900500.66, 40, 'Totsuki Manager');

/* Add the Workers */
insert into Worker values(1, 'Satou Jun', 24900.45, 40, 1);
insert into Worker values(2, 'Yachiyo Todoroki', 20900.45, 35, 1);
insert into Worker values(3, 'Aoi Yamada', 1900.50, 30, 1);
insert into Worker values(4, 'Hiroomi Souma', 23500.75, 25, 1);
insert into Worker values(5, 'Misaki Ayuzawa', 22750.48, 20, 2);
insert into Worker values(6, 'Sanji Vinsmoke', 35900.69, 42, 2);
insert into Worker values(7, 'Erina Nakiri', 40000.20, 38, 2);
insert into Worker values(8, 'Levi Ackerman', 20890.77, 12, 2);
insert into Worker values(9, 'Popura Taneshima', 19000.50, 30, 1);
insert into Worker values(10, 'Soma Yukihira', 29050.00, 45, 2);
insert into Worker values(11, 'Mahiru Inami', 19050.20, 15, 1);
insert into Worker values(12, 'Maya Matsumoto', 21500.75, 28, 1);
insert into Worker values(13, 'Souta Takanashi', 20090.50, 17, 1);

/* Add the Phone Numbers */
insert into Phone values(1, '2919989876');
insert into Phone values(2, '1313443655');
insert into Phone values(3, '6015675675');
insert into Phone values(4, '2414445444');
insert into Phone values(5, '7016767688');
insert into Phone values(6, '2613449885');
insert into Phone values(7, '9216546577');
insert into Phone values(8, '2812325488');
insert into Phone values(9, '4119989876');
insert into Phone values(10, '2513443655');
insert into Phone values(11, '8095675675');
insert into Phone values(12, '2514445444');
insert into Phone values(13, '3016767688');

/* Add the Chefs */
insert into Chef values(1, 'Smoking', 'Blondie', null);
insert into Chef values(4, 'Intel-Gathering', 'Mister', 1);
insert into Chef values(6, 'Seafood', 'Mr. Prince', 1);
insert into Chef values(7, 'Everything', 'God Tongue', null);
insert into Chef values(10, 'Yukihira Special', 'Harem King', 7);
/* Give Blondie and God Tongue someone to replace */
update Chef set replaces_id = 4 where cid = 1;
update Chef set replaces_id = 10 where cid = 7;

/* Add the Dishes */
insert into Dish values('Steak', 1250.00, 1, 12);
insert into Dish values('Hamburger', 12.00, 4, 30);
insert into Dish values('Fries', 2.00, 4, 50);
insert into Dish values('Seabeast Soup', 10.70, 6, 60);
insert into Dish values('Rice', 5.12, 10, 90);
insert into Dish values('Sumire Karaage', 5.00, 10, 100);
insert into Dish values('Eggs Benedict', 9.40, 7, 30);

/* Add the Ingredients */
insert into Ingredient values('Steak', 'Holy Cow');
insert into Ingredient values('Steak', 'Hourai Elixir');
insert into Ingredient values('Hamburger', 'Mystery Meat');
insert into Ingredient values('Hamburger', 'Soggy Bun');
insert into Ingredient values('Hamburger', 'Special Sauce');
insert into Ingredient values('Hamburger', 'Lettuce');
insert into Ingredient values('Fries', 'Groovy Spud');
insert into Ingredient values('Fries', 'Special Seasoning');
insert into Ingredient values('Rice', 'Rice');
insert into Ingredient values('Rice', 'Water');
insert into Ingredient values('Seabeast Soup', 'Grandline Fish');
insert into Ingredient values('Seabeast Soup', 'Soysauce');
insert into Ingredient values('Seabeast Soup', 'Love');
insert into Ingredient values('Sumire Karaage', 'Rice Tortilla');
insert into Ingredient values('Sumire Karaage', 'Soysauce');
insert into Ingredient values('Sumire Karaage', 'Cheap Chicken');
insert into Ingredient values('Sumire Karaage', 'Lettuce');

/* Add the Waiters */
insert into Waiter values(2, 60);
insert into Waiter values(5, 55);
insert into Waiter values(9, 45);
insert into Waiter values(11, 10);
insert into Waiter values(13, 20);

/* Add the Sections */
insert into Section values(1, 2);
insert into Section values(2, 5);
insert into Section values(3, 9);
insert into Section values(4, 11);
insert into Section values(5, 13);
insert into Section values(6, 5);
insert into Section values(7, 11);
insert into Section values(8, 5);

/* Add the Tables */
insert into Rest_Table values(1, 1, 4);
insert into Rest_Table values(1, 2, 4);
insert into Rest_Table values(1, 3, 6);

insert into Rest_Table values(2, 1, 2);
insert into Rest_Table values(2, 2, 2);

insert into Rest_Table values(3, 1, 6);
insert into Rest_Table values(3, 2, 6);
insert into Rest_Table values(3, 3, 4);

insert into Rest_Table values(4, 1, 4);
insert into Rest_Table values(4, 2, 2);

insert into Rest_Table values(5, 1, 6);
insert into Rest_Table values(5, 2, 8);

insert into Rest_Table values(6, 1, 4);

insert into Rest_Table values(7, 1, 2);
insert into Rest_Table values(7, 2, 2);

insert into Rest_Table values(8, 1, 2);
insert into Rest_Table values(8, 2, 2);

/* Add the Cleaners */
insert into Cleaner values(3, 'Breaking Things');
insert into Cleaner values(12, 'Normal');
insert into Cleaner values(8, 'Titans');

/* Add the Evals */
insert into Eval values(1, 'Cooks well but smokes too much', '10/01/2016');
insert into Eval values(2, 'Knows everybodys personal information but has no friends', '10/01/2016');
insert into Eval values(3, 'Pretty and works well but has a sword??', '10/01/2016');
insert into Eval values(4, 'Very enthusiastic and short', '10/01/2016');
insert into Eval values(5, 'Punched me and I hate her now', '10/01/2016');
insert into Eval values(6, 'Sometimes he dresses up like a girl but why', '10/01/2016');
insert into Eval values(7, 'Always breaks plates and trips', '10/01/2016');
insert into Eval values(8, 'What a normal person', '10/01/2016');
insert into Eval values(9, 'Always wearing a maid outfit', '10/02/2016');
insert into Eval values(10, 'Flirts with too many women', '10/02/2016');
insert into Eval values(11, 'Does her job well, Best Girl', '10/02/2016');
insert into Eval values(12, 'Too short', '10/02/2016');
insert into Eval values(13, 'Makes weird things', '10/02/2016');
insert into Eval values(14, 'I hate my job!', '10/03/2016');

insert into Evaluated values(1, 1);
insert into Evaluated values(4, 2);
insert into Evaluated values(2, 3);
insert into Evaluated values(9, 4);
insert into Evaluated values(11, 5);
insert into Evaluated values(13, 6);
insert into Evaluated values(3, 7);
insert into Evaluated values(12, 8);
insert into Evaluated values(5, 9);
insert into Evaluated values(6, 10);
insert into Evaluated values(7, 11);
insert into Evaluated values(8, 12);
insert into Evaluated values(10, 13);

/* Problem 3.c =========================================================== */
select * from Manager;
select * from Worker;
select * from Phone;
select * from Chef;
select * from Dish;
select * from Ingredient;
select * from Waiter;
select * from Section;
select * from Rest_Table;
select * from Cleaner;
select * from Eval;
select * from Evaluated;

/* Problem 3.d =========================================================== */

/* Find all workers that work between sections 4 and 6 */
select name from Worker, Section where Worker.wid = Section.wid
and section_number between 4 and 6;

/* Find the average price amongst all dishes at the restauraunt */
select avg(price) from Dish;

/* Show the number of emplloyees that each manager manages */ 
select Manager.name, count(wid) from Manager, Worker 
where Manager.mid = Worker.mid
group by Manager.name; 

/* Show the names of all waiters that wait 2 or more sections */
select name from (select name, wid from Worker where wid in (select wid from Waiter)) X
where 2<= (select count(section_number) from Section where Section.wid = X.wid);

/* Insert a new manager with the same primary key */
insert into Manager values(1, 'Komatsu', 3300000.90, 0, 'Toriko Manager');

/* Insert a dish with a chef ID that does not exist */
insert into Dish values('Meatloaf', 12.00, 2, 30);
