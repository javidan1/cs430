
import oracledb
import pandas as pd

# Connection 
conn = oracledb.connect(user = "javidan",
                        password = "fuzuli19",
                        dsn = "dbs3.cs.umb.edu/dbs3")
cur = conn.cursor()

# Dropping the tables
cur.execute("DROP TABLE reads")
cur.execute("DROP TABLE students")
cur.execute("DROP TABLE articles")

# Creating the tables

cur.execute('''
            CREATE TABLE articles (aid INT PRIMARY KEY,
            title VARCHAR(20) NOT NULL,
            author VARCHAR(20) NOT NULL,
            pubyear INT NOT NULL
            )
            ''')

cur.execute('''
            CREATE TABLE students (sid INT PRIMARY KEY,
            name VARCHAR(20) NOT NULL,
            city VARCHAR(20) NOT NULL,
            state VARCHAR(20) NOT NULL,
            age REAL NOT NULL,
            gpa REAL NOT NULL,
            CHECK (gpa >= 1 AND gpa <= 4)
            )
            ''')

cur.execute('''
            CREATE TABLE reads (aid INT NOT NULL,
            sid INT NOT NULL,
            rday DATE NOT NULL,
            PRIMARY KEY (aid, sid),
            FOREIGN KEY (aid) references articles,
            FOREIGN KEY (sid) references students
            )
            ''')

# Inserting two records to each table

cur.execute('''
           INSERT INTO students (sid, name, city, state, age, gpa) values (1, 'Zlatan', 'Malmo', 'MA', 40, 2.9)
           ''')

cur.execute('''
           INSERT INTO students (sid, name, city, state, age, gpa) values (2, 'Tate', 'Luton', 'NY', 24, 3.5)
           ''')

cur.execute('''
           INSERT INTO articles (aid, title, author, pubyear) values (1, 'Love', 'Tristan', 2014)
           ''')

cur.execute('''
           INSERT INTO articles (aid, title, author, pubyear) values (2, 'Cars', 'Hammond', 1999)
           ''')

cur.execute('''
           INSERT INTO reads (aid, sid, rday) values (1, 1, '19-DEC-2020')
           ''')

cur.execute('''
           INSERT INTO reads (aid, sid, rday) values (2, 2, '22-MAY-2019')
           ''')


# Selecting the quesries and printing
sqlQuery1 = pd.read_sql_query('''
                             SELECT * FROM articles a1
                             ''', conn)
df1 = pd.DataFrame(sqlQuery1,
                   columns = ['AID', 'TITLE', 'AUTHOR', 'PUBYEAR'])
print(df1)

sqlQuery2 = pd.read_sql_query('''
                             SELECT * FROM students a1
                             ''', conn)
df2 = pd.DataFrame(sqlQuery2,
                   columns = ['SID', 'NAME', 'CITY', 'STATE', 'AGE', 'GPA'])
print(df2)

sqlQuery3 = pd.read_sql_query('''
                             SELECT * FROM reads a1
                             ''', conn)
df3 = pd.DataFrame(sqlQuery3,
                   columns = ['AID', 'SID', 'RDAY'])
print(df3)

# Closing the connection
cur.close()
conn.close()