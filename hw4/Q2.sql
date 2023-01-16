-- Answer for a)
create table Cars(
	carid number(9) primary key,
	make	varchar(20),
	model	varchar(20),
	myear	number(4),
	dailyfee	real
	CONSTRAINT YearRange
	CHECK (myear >= 2010)
);

-- Answer for b)

create table Customers(
	custid  number(9) primary key,
	name	varchar(20) NOT NULL,
	city	varchar(20) NOT NULL,
	state	varchar(20) NOT NULL,
	dob	date NOT NULL
);


-- Answer for c)
create table Rents(
	carid	number(9),
	custid number(9),
	rday date NOT NULL,
	primary key(carid, custid),
	foreign key (carid) references Cars,
	foreign key (custid) references Customers
);
	

-- Answer for d)
SELECT c.custid, c.name from Customers c
WHERE NOT EXISTS (
	select b.carid from Cars b
	where not exists (
		select * from Rents r
		where r.custid=c.custid and r.carid=b.carid
	)
);

-- Answer for e)
INSERT INTO Cars VALUES(1, 'Acura', 'NSX', 2012, 49)
-- Since there is a constraint, if the inserted year is older than 2010, the inserted value will be rejected
-- INSERT INTO Cars VALUES(1, 'Acura', 'NSX', 2008, 49)