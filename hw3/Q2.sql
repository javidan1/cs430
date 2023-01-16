-- answer for a)

create table books(
	bid	number(9) primary key,
	bname	varchar(20),
	author	varchar(20),
	pubyear	number(4),
	pubcompany	varchar(20)
);

create table students(
	sid	number(9) primary key,
	sname	varchar(20),
	age	real,
	state	varchar(20)
);

create table reads(
	sid	number(9),
	bid	number(9),
	year	number(4),
	primary key(sid, bid),
	foreign key (sid) references students,
	foreign key (bid) references books
);


-- answer for b)
INSERT into books(bid, bname, author, pubyear, pubcompany) 
values(1, "The Final Problem", "Sir Arthur Conan Doyle", "1893", "Strand Magazine");
INSERT into students(sid, sname, age, state) 
values(1, "Messi", "15", "NY"); 
INSERT into reads(sid, bid, year)
values(1, 1, 2020);


-- answer for c)
select * from students s
where s.state like 'MA' and (age<25 or age>35);

-- answer for d)
select count(*) from books
where author like 'B%';

-- answer for e)
select MIN(pubyear) from books b;

-- answer for f)
SELECT s.state, AVG(s.age) from students s
GROUP BY s.state
HAVING count(*) >= 50; 

-- answer for g)
select distinct s.sid, s.sname from students s
where not exists(
	select b.bid from books b
	where not exists(
	select * from reads r
	where r.sid = s.sid and r.bid= b.bid
	)
)
ORDER BY s.sname asc;

-- answer for h)
select distinct s.sid, s.sname, s.state from students s
where not exists(
	(select b.bid from books b
	where b.pubcompany='penguin')
	MINUS
	(SELECT r.bid from reads r
	 where r.sid=s.sid)
)
order by sname;

-- answer for part i)
select s.sid, s.sname from students s
where exists(
	select b.bid from books b
	where (b.pubcompany ='penguin'
	AND EXISTS( select * from reads r
			where r.sid = s.sid and r.bid = b.bid)))
AND NOT EXISTS (select b.bid from books b
			where(b.pubcompany='simon'
			and exists(select * from reads r
					where r.sid = s.sid and r.bid = b.bid)
	)
);

-- answer for part j)

select s.sname from students s
JOIN reads r on r.sid = s.sid
JOIN books b on b.bid=r.sid
where b.pubyear=r.year;