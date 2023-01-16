-- Answer for a)
create TABLE Books( 
	bid number (9) primary key, 
 	bname varchar(20), 
 	author varchar(20), 
 	pubyear number(4), 
 	pubcompany varchar(20) 
 );

create TABLE Authors( 
 	aid number(9) primary KEY, 
 	name varchar(20), 
 	rating number(2), 
 	state varchar(2) 
); 

create TABLE Write( 
 	aid number(9), 
 	bid number(9), 
 	primary key(bid, aid), 
 	FOREIGN key(aid) REFERENCES Authors, 
 	FOREIGN key(bid) REFERENCES Books 
);

-- Answer for b)
SELECT bname FROM Books WHERE pubcompany NOT NULL;

-- Answer for c)
SELECT name from Books where pubcompany is null;

-- Answer for d)
select a.rating, a.state, COUNT(DISTINCT a.aid) from Authors a
GROUP BY a.rating, a.state;

-- Answer for e)
select name, bname, bid from Authors a join Books b
WHERE a.name = b.bname;

-- Answer for f)
SELECT a.name from Authors a join Books b
WHERE a.aid = w.aid and w.bid is null;

-- Answer for g)
INSERT INTO Books(bid, author, bname, pubyear, pubcompany) VALUES(1, 'Arthur Conan Doyle', 'Mr. Holmes', 1904, 'Ward, Lock & Co');
INSERT INTO Authors(aid, name, rating, state) VALUES(1, 'Arthur Conan Doyle', 9, 'TX');
INSERT INTO Write(aid, bid) VALUES(1,1);

-- Answer for h)
UPDATE Books set author = ('Osho'), pubyear=2020 where bid=1;

-- Answer for i)
UPDATE Books set pubyear = 2000 WHERE pubcompany = ('penguin');

-- Answer for j)
UPDATE Authors set rating = 10;

-- Answer for k)
DELETE from Authors WHERE aid NOT IN (select w.aid from Write w);

-- Answer for l)
-- The difference between COUNT(*) and COUNT(bname) is that COUNT(*) also includes
-- null values. Therefore, if there are null items in the Books database, COUNT(bname) and COUNT(*)
-- will give us distinct results.

-- Answer for m)
ALTER table Authors add age real;

-- Answer for n)
drop table Books;
drop table Authors;
drop table Write;

create table Authors (
	aid number(9) primary key,
	name varchar(20),
	rating number(2) CHECK(rating >=1 and rating <=5),
	state varchar(2),
);