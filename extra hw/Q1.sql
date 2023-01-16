-- Answer for question a)

CREATE TABLE Books (
  bid number(9) PRIMARY KEY,
  bname VARCHAR(20),
  author VARCHAR(20),
  pubyear number(9),
  price number(9)
);

-- Answer for question b)

CREATE TABLE Customers (
  cid number(9) PRIMARY KEY,
  cname VARCHAR(20),
  city VARCHAR(20)
);

-- Answer for question c)

CREATE TABLE Orders (
  cid number(9),
  bid number(9),
  orderdate DATE,
  PRIMARY KEY (cid, bid),
  FOREIGN KEY (cid) REFERENCES Customers(cid),
  FOREIGN KEY (bid) REFERENCES Books(bid)
);

-- Answer for question d)

SELECT COUNT(*) FROM Books;

-- Answer for question e)

SELECT COUNT(*) FROM Customers WHERE city = 'Boston';

-- Answer for question f)

SELECT city, COUNT(*) FROM Customers GROUP BY city;

-- Answer for question g)

SELECT bname, author FROM Books WHERE pubyear = 2020 ORDER BY bname ASC;

-- Answer for question h)

SELECT Customers.cid, Customers.cname, Books.bname, Books.author
FROM Customers INNER JOIN Orders ON Customers.cid = Orders.cid
INNER JOIN Books ON Orders.bid = Books.bid;

-- Answer for question i)

SELECT DISTINCT Books.bid, Books.bname
FROM Books INNER JOIN Orders ON Books.bid = Orders.bid
WHERE EXTRACT(YEAR FROM orderdate) = 2021;

-- Answer for question j)
SELECT bid, bname FROM Books WHERE author IS NULL;