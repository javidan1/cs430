CREATE TABLE Movies (
  mid number(9) PRIMARY KEY,
  title varchar(20),
  director varchar(20),
  studio varchar(20),
  releaseyear number(4)
);
CREATE TABLE Customers (
  cid number(9) PRIMARY KEY,
  name varchar(20),
  city varchar(20),
  state varchar(20),
  age REAL,
  CHECK (age >= 18)
);
CREATE TABLE Watch (
  cid varchar(20),
  mid varchar(20),
  watchedon DATE,
  PRIMARY KEY (cid, mid),
  FOREIGN KEY (cid) REFERENCES Customers(cid),
  FOREIGN KEY (mid) REFERENCES Movies(mid)
);
CREATE INDEX indexWatchDate ON Watch (watchedon);
INSERT INTO Movies (mid, title, director, studio, releaseyear) VALUES (1, 'Interstellar', 'Nolan', 'Syncopy', 2014);

INSERT INTO Customers (cid, name, city, state, age) VALUES (2, 'Javidan', 'Newton', 'MA', 22);

INSERT INTO Watch (cid, mid, watchedon) VALUES (1, 1, TO_DATE('14/11/2022', 'mm/dd/yyyy'));

SELECT DISTINCT mid, title
FROM Movies
INNER JOIN Watch
ON Movies.mid = Watch.mid
WHERE watchedon BETWEEN TO_DATE('01/01/2022', 'mm/dd/yyy') AND TO_DATE('07/31/2022', 'mm/dd/yyy');

SELECT Customers.cid, Customers.name, Movies.mid, Movies.title, Movies.director, Watch.watchedon
FROM Customers
INNER JOIN Watch
ON Customers.cid = Watch.cid
INNER JOIN Movies
ON Watch.mid = Movies.mid
ORDER BY Watch.watchedon DESC;