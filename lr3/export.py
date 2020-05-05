import csv
import cx_Oracle

connection = cx_Oracle.connect('SYSTEM', 'oralce', 'localhost/xe')
cursor = connection.cursor()

tables = ['seasons', 'positions', 'players', 'player_info', 'transfer']

for table in tables:
    with open(table + '.csv', 'w', newline='') as file:
        writer = csv.writer(file, delimiter=',')

        query = 'SELECT * FROM ' + table
        cursor.execute(query)

        columns = [i[0] for i in cursor.description]
        writer.writerow(columns)

        for row in cursor:
            writer.writerow(row)

cursor.close()
connection.close()