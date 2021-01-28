"""
1) Import dataset as array from database using SQL query
2) calculate Z-scores - in array of same format as table in database
    a) Within each metal calculate mean
    b) within each metal caclulate SD
    c) for each value calculate (value - mean)/SD
3) Populate z-score table in database with the transformed values

"""
import pandas as pd
from sqlalchemy import create_engine
import sys
import mysql.connector
cnx = mysql.connector.connect(  user=sys.argv[1],
                                password=sys.argv[2],
                                host=sys.argv[3],
                                database=sys.argv[4]
                              )

cursor = cnx.cursor()

query = ("SELECT * FROM metals ") #see if I can paramaterize the table

df = pd.read_sql(query, cnx)

cols = list(df.columns)
cols.remove('id')
cols.remove('sample_id')
df[cols]

for col in cols:
    df[col] = (df[col]-df[col].mean())/df[col].std(ddof=0)  # z-score calculation

engine = create_engine("mysql+pymysql://{user}:{pw}@{host}/{db}"
				.format(host=sys.argv[3], db=sys.argv[4], user=sys.argv[1], pw=sys.argv[2])) # creates connection engine in sqlalchemy

df.to_sql('metals_z', engine, if_exists = 'replace', index=False) # uses the .to_sql method to write to a new table - does not require an existing schema

query2 = ("ALTER TABLE metals_z ADD PRIMARY KEY (id)")
query3 = ("ALTER TABLE metals_z ADD CONSTRAINT UNIQ_30py UNIQUE (id)")
query4 = ("ALTER TABLE metals_z MODIFY sample_id INT(11) UNSIGNED")
query5 = ("ALTER TABLE metals_z ADD CONSTRAINT FK_101py FOREIGN KEY (sample_id) REFERENCES samples (id)")

cursor.execute(query2)
cursor.execute(query3)
cursor.execute(query4)
cursor.execute(query5)

cnx.close() # closes the connection, dont forget about this

