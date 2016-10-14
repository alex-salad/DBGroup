/* Problem 2.a =========================================================== */
create table Performer (
  pid int,
  pname varchar(20),
  years_of_experience int,
  age int,
  primary key(pid)
);

create table Director(
  did int,
  dname varchar(20),
  earnings real,
  primary key(did)
);

create table Movie(
  mname varchar(20),
  genre varchar(20),
  minutes int,
  release_year int,
  did int,
  primary key(mname),
  foreign key(did) references Director
);

create table Acted(
  pid int,
  mname varchar(20),
  primary key(pid, mname),
  foreign key(pid) references Performer,
  foreign key(mname) references Movie
);

/* Problem 2.b =========================================================== */
insert into Performer values(1, 'Morgan', 48, 67);
insert into Performer values(2, 'Cruz', 14, 28);
insert into Performer values(3, 'Adams', 1, 16);
insert into Performer values(4, 'Perry', 18, 32);
insert into Performer values(5, 'Hanks', 36, 55);
insert into Performer values(6, 'Hanks', 15, 24);
insert into Performer values(7, 'Lewis', 13, 32);

insert into Director values(1, 'Parker', 580000);
insert into Director values(2, 'Black', 2500000);
insert into Director values(3, 'Black', 30000);
insert into Director values(4, 'Stone', 820000);

insert into Movie values('Jurassic Park', 'Action', 125, 1984, 2);
insert into Movie values('Shawshank Redemption', 'Drama', 105, 2001, 2);
insert into Movie values('Fight Club', 'Drama', 144, 2015, 2);
insert into Movie values('The Departed', 'Drama', 130, 1969, 3);
insert into Movie values('Back to the Future', 'Comedy', 89, 2008, 3);
insert into Movie values('The Lion King', 'Animation', 97, 1990, 1);
insert into Movie values('Alien', 'Sci-Fi', 115, 2006, 3);
insert into Movie values('Toy Story', 'Animation', 104, 1978, 1);
insert into Movie values('Scarface', 'Drama', 124, 2003, 1);
insert into Movie values('Up', 'Animation', 111, 1999, 4);

insert into Acted values(4, 'Fight Club');
insert into Acted values(5, 'Fight Club');
insert into Acted values(6, 'Shawshank Redemption');
insert into Acted values(4, 'Up');
insert into Acted values(5, 'Shawshank Redemption');
insert into Acted values(1, 'The Departed');
insert into Acted values(2, 'Fight Club');
insert into Acted values(3, 'Fight Club');
insert into Acted values(4, 'Alien');

/* Problem 2.c =========================================================== */
/* 2.c.1 */
select * from Performer;
select * from Director;
select * from Movie;
select * from Acted;

/* 2.c.2 */
select pname from Performer where years_of_experience >= 20 and pid in (
select pid from Acted where mname in (
select mname from Movie where did in (
select did from Director where dname = 'Black')));

/* 2.c.3 */
select max(age) from Performer where pname = 'Hanks' or pid in (
select pid from Movie where mname = 'The Departed');

/* 2.c.4 */
select mname from Movie where genre = 'Comedy' or 1 < (
select count(distinct pid) from Acted where Acted.mname = Movie.mname);

/* 2.c.5 */
select dname from Director where 1 < (
select count(distinct pid) from Acted where mname in (
select mname from Movie where Movie.did = Director.did));

/* 2.c.6 */
select distinct genre from Movie X where 2 = (
select count(distinct did) from Movie Y where Y.genre = X.genre);

/* 2.c.7 */
select pname, pid from Performer where exists (
select X.mname from Movie X, Movie Y where X.mname != Y.mname
and X.genre = Y.genre and
X.mname in (
select mname from Acted where Acted.pid = Performer.pid)
and Y.mname in (
select mname from Acted where Acted.pid = Performer.pid));

/* 2.c.8 */
select X.genre, avg(X.minutes) from Movie X, Movie Y
where X.genre = Y.genre
group by X.genre;

/* 2.c.9 */
update Director set earnings = earnings * 0.9 where did in (
select did from Movie where mname = 'Up');

/* 2.c.10 */
delete Movie where release_year between 1970 and 1980;