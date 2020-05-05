import csv
import cx_Oracle
file = open('csvfile.csv')
connection = cx_Oracle.connect('SYSTEM', 'oralce', 'localhost/xe')

cursor = connection.cursor()
reader = csv.reader(file, delimiter=',')

positions = []
players = []
seasons = []

row_count = 1
next(reader)
try:
    for row in reader:
        player = row[0]
        position = row[1]
        age = row[2]
        season = row[7]


        if position not in positions:
            positions.append(position)

            query = "INSERT INTO positions(position) VALUES ( :position)"
            cursor.execute(query, position = position )

        if player not in players:
            players.append(player)

            query = "INSERT INTO players(player, position) VALUES ( :player, :position)"
            cursor.execute(query, player = player, position = position)

        if season not in seasons:
            seasons.append(season)

            query = "INSERT INTO seasons(season) VALUES ( :season)"
            cursor.execute(query, season = season)

        query = "INSERT INTO player_info(player, season, age) VALUES ( :player, :season, :age)"
        cursor.execute(query, player = player, season = season, age = age)
        query = "INSERT INTO transfer(player, season, team_from, team_to) VALUES ( :player, :season, :team_from, :team_to)"
        cursor.execute(query, player = player, season = season, team_from = row_count, team_to = row_count)



        row_count += 1
except:
    print(f' Line -  {row_count}')
    raise

cursor.close()
connection.commit()