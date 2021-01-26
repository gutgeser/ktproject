# Module Imports
import sys
import mysql.connector
cnx = mysql.connector.connect(  user=sys.argv[1],
                                password=sys.argv[2],
                                host=sys.argv[3],
                                database=sys.argv[4]
                              )

cursor = cnx.cursor()
print("Hello Python ! This is App Project Python.")
print(f"Name of the script      : {sys.argv[0]}")
query = ("SELECT Hg, Li, V FROM metals "
          "WHERE sample_id BETWEEN %s AND %s")
cursor.execute(query, (10, 20))

for (Hg, Li, V) in cursor:
  print("{}, {}, {}".format(Hg, Li, V))
cursor.close()
cnx.close()
