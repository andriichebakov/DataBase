import cx_Oracle

username = 'SYSTEM'
password = 'oralce'
dsn = 'localhost/xe'

connection = cx_Oracle.connect(username, password, dsn)
cursor = connection.cursor()

# Запит 1

query = '''
SELECT 
    age,
    COUNT(player) transfers
FROM 
    player_info p
GROUP BY age
ORDER BY age
'''

print('Запит 1')
cursor.execute(query)
for row in cursor:
    print(row)
print('\n\n')


# Запит 2

query = '''
SELECT
    p.position,
    round(COUNT(pi.player) * 100 / (SELECT COUNT(*) FROM player_info), 2) persentage
FROM 
    player_info pi
JOIN 
    players p ON pi.player = p.player
GROUP BY p.position
ORDER BY persentage DESC
'''

print('Запит 2')
cursor.execute(query)
for row in cursor:
    print(row)
print('\n\n')

# Запит 3

query = '''
SELECT 
    s.season,
    COUNT(t.player) transfers
FROM 
    seasons s
JOIN transfer t on s.season = t.season
GROUP BY s.season
ORDER BY season
'''

print('Запит 3')
cursor.execute(query)
for row in cursor:
    print(row)

cursor.close()
connection.close()