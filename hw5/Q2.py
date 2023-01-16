
import oracledb
import pandas as pd

# connection
conn = oracledb.connect(user = "javidan",
                        password = "fuzuli19",
                        dsn = "dbs3.cs.umb.edu/dbs3")
cur = conn.cursor()

# run query against DB
sqlQuery1 = pd.read_sql_query("""
                             SELECT SID, NAME, CITY, STATE, AGE, GPA
                             FROM students
                             """, conn)
df = pd.DataFrame(sqlQuery1,
                  columns = ['SID', 'NAME', 'CITY', 'STATE', 'AGE', 'GPA'])

# Print statements for the above dataframe
print(df.columns)
print(df.shape)
print(df.head(2))
print(df[['AGE']].agg(['mean']))
print(df[['GPA']].agg(['min', 'max']))
print(df[['GPA']].agg(['sum']))

# The second query
sqlQuery2 = pd.read_sql_query("""
                              SELECT s1.SID, s1.NAME,
                              s1.STATE, r1.AID, a1.TITLE
                              FROM students s1
                              INNER JOIN reads r1 ON s1.SID = r1.SID
                              INNER JOIN articles a1 ON r1.AID = a1.AID
                              """, conn)

df2 = pd.DataFrame(sqlQuery2,
                   columns = ['SID', 'NAME', 'STATE', 'AID', 'TITLE'])

# Print statements for the second query
print(df2)
print(df2.shape[0])
print(df2.shape[1])
print(df2.columns)

# Only Students from MA
df3 = df2[df2['STATE'] == 'MA']

# Print statements
print(df3)
print(df3.groupby(['SID']).count()[['AID']])

# Close the connection
cur.close()
conn.close()