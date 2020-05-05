import cx_Oracle

username = 'SYSTEM'
password = 'oralce'
dsn = 'localhost/xe'

conection = cx_Oracle.connect(username, password, dsn)
currsor = conection.cursor()

# Запит 1

query = '''
SELECT 
    age,
    COUNT(player) transfers
FROM 
    transfers_view
GROUP BY age
ORDER BY age
'''

print('Запит 1')
currsor.execute(query)
for raw in currsor:
    print(raw)
print('\n\n')


# Запит 2

query = '''
SELECT
    position,
    round(COUNT(player) * 100 / (SELECT COUNT(*) FROM transfers_view), 2) persentage
FROM 
    transfers_view
GROUP BY position
ORDER BY persentage DESC
'''

print('Запит 2')
currsor.execute(query)
for raw in currsor:
    print(raw)
print('\n\n')

# Запит 3

query = '''
SELECT 
    season,
    COUNT(player) transfers
FROM 
    transfers_view
GROUP BY season
ORDER BY season
'''

print('Запит 3')
currsor.execute(query)
for raw in currsor:
    print(raw)

currsor.close()
conection.close()