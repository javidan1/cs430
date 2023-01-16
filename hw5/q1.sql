-- Answer for a)
create table Articles( 
	aid number(9) PRIMARY KEY, 
	title varchar(20), 
	author varchar(20), 
	pubyear number(4) 
); 

create table Students( 
	sid number(9) PRIMARY KEY, 
	name varchar(20), 
	city varchar(20), 
	state varchar(20), 
	age real, 
	gpa real
	constraint gpaRange
	check (gpa >= 1 and gpa <= 4) 
); 

create table Reads( 
	aid number(9), 
	sid number(9), 
	rday date not null,
	PRIMARY KEY(aid, sid), 
	FOREIGN KEY (aid) REFERENCES Articles, 
	FOREIGN KEY (sid) REFERENCES Students 
);

-- Answer for b)
INSERT INTO Students(sid, name, city, state, age, gpa) VALUES(1, "Joe", "Houston", "TX", 22, 3.4);
INSERT INTO Students(sid, name, city, state, age, gpa) VALUES(2, "Khan", "Boston", "MA", 18, 3.9);
INSERT INTO Students(sid, name, city, state, age, gpa) VALUES(3, "Leo", "Rosario", "NY", 26, 3.5);

INSERT INTO Articles(aid, title, author, pubyear) VALUES(1, "The World Cup", "Robert Lewa", 2022);
INSERT INTO Articles(aid, title, author, pubyear) VALUES(2, "Homecoming", "Peter Pen", 2006);

-- Answer for c)
INSERT INTO Reads(aid, sid, rday) VALUES(1, 1, TO_DATE('01/01/2022', 'mm/dd/yyyy'));
INSERT INTO Reads(aid, sid, rday) VALUES(2, 1, TO_DATE('05/18/2020', 'mm/dd/yyyy'));
INSERT INTO Reads(aid, sid, rday) VALUES(2, 2, TO_DATE('07/14/2012', 'mm/dd/yyyy'));

-- Answer for d)
CREATE VIEW MAStudents AS SELECT * FROM Students s WHERE s.state = "MA";

-- Answer for e)
CREATE VIEW StudentsReads AS SELECT s.sid, s.name, s.city, a.aid, a.title
FROM Articles a, Students s, Reads r
WHERE a.aid = r.aid AND s.sid = r.sid;

-- Answer for f)
SELECT name, count(aid) FROM StudentReads GROUP BY name;

-- Answer for g)
DROP VIEW StudentsReads;
DROP VIEW MAStudents;