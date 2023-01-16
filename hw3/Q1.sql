--answer for a)

create table customers(
	cid	number(9) primary key,
	firstname	varchar(20),
	lastname	varchar(20),
	city	varchar(20),
	state	varchar(20)
);

create table accounts(
	aid	number(9) primary key,
	atype	varchar(20),
	amount	real
);

create table has_account(
	cid	number(9),
	aid	number(9),
	since	date,
	primary key(cid, aid),
	foreign key (cid) references customers,
	foreign key (aid) references accounts
);


-- answer for b)
select DISTINCT c.cid, c.firstname, c.lastname
FROM customers c, accounts a
WHERE state='MA'
GROUP BY c.cid, c.firstname, c.lastname
HAVING MIN(a.amount)>1000
ORDER BY c.lastname;

-- answer for c)
SELECT atype, COUNT(*) from accounts
GROUP BY atype;

-- answer for d)
SELECT c.cid, COUNT(a.aid) FROM customers c
JOIN has_account h ON c.cid = h.cid
JOIN accounts a ON a.aid = h.aid
WHERE c.state like 'MA'
GROUP BY c.cid
HAVING COUNT(a.aid) >= 3;


-- answer for e)
SELECT c.cid, c.firstname from customers c
JOIN has_account h ON c.cid = h.cid
JOIN accounts a ON a.aid = h.aid
where a.atype='checking'
Group by c.cid, c.firstname
having count(*) >= 2;

		 
-- answer for f)
SELECT c.cid, c.firstname, c.lastname from customers c
where c.cid IN(select cid from has_account
			where extract(year from since)=2020 and extract(year from since)=2018);


-- answer for g)
SELECT c.cid, c.lastname from customers c
WHERE c.cid IN(
	SELECT cid from has_account
	 WHERE since<=TO_DATE('01/01/2020','mm/dd/yyyy'));

-- answer for h)
select c.cid, c.lastname from customers c, accounts a
WHERE EXISTS(select * from has_account
			where atype = (select atype from accounts
						where a.atype='savings' and a.atype='checking'));
