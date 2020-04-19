import cx_Oracle
import chart_studio
import plotly.graph_objects as go
import chart_studio.plotly as py
import chart_studio.dashboard_objs as dashboard
import re

def get_id(url):
    return re.findall("~[A-z.]+/[0-9]+", url)[0][1:].replace('/', ':')

chart_studio.tools.set_credentials_file(username='andriichebakov', api_key='NdoLJtSwLsgszPJE1LFc')

username = "SYSTEM"
password = "oralce"
database = "localhost/xe"
connection = cx_Oracle.connect(username, password, database)
cursor = connection.cursor()

query = """
SELECT 
    age,
    COUNT(player) transfers
FROM 
    player_info p
GROUP BY age
ORDER BY age
"""
cursor.execute(query)

x = list()
y = list()
for row in cursor:
    x.append(row[0])
    y.append(row[1])
bar = go.Bar(x = x, y = y)
bar = py.plot([bar],auto_open = True)

query = """
SELECT
    p.position,
    round(COUNT(pi.player) * 100 / (SELECT COUNT(*) FROM player_info), 2) persentage
FROM 
    player_info pi
JOIN 
    players p ON pi.player = p.player
GROUP BY p.position
ORDER BY persentage DESC
"""
cursor.execute(query)

x = list()
y = list()
for row in cursor:
    x.append(row[0])
    y.append(row[1])
pie = go.Pie(labels = x, values = y)
pie = py.plot([pie],auto_open = True)


query = """
SELECT 
    s.season,
    COUNT(t.player) transfers
FROM 
    seasons s
JOIN transfer t on s.season = t.season
GROUP BY s.season
ORDER BY season
"""
cursor.execute(query)

x = list()
y = list()
for row in cursor:
    x.append(row[0])
    y.append(row[1])
scatter = go.Scatter(x = x, y = y)
scatter = py.plot([scatter],auto_open = True)

dash = dashboard.Dashboard()
bar_id = get_id(bar)
pie_id = get_id(pie)
scatter_id = get_id(scatter)


filed_1= {'type': 'box',
    'boxType': 'plot',
    'fileId': bar_id,
    'title': 'Кількість трансферів гравців кожного віку.'}


filed_2 = {'type': 'box',
    'boxType': 'plot',
    'fileId': pie_id,
    'title': 'Відсоток кількості трансферів гравців кожної позиції.'}


filed_3 = {'type': 'box',
    'boxType': 'plot',
    'fileId': scatter_id,
    'title': 'Динаміка трансерів по сезонах.'}



dash.insert(filed_3)
dash.insert(filed_2, 'below', 1)
dash.insert(filed_1, 'right', 2)


py.dashboard_ops.upload(dash, 'DataBase_Dashboard')


cursor.close()
connection.close()