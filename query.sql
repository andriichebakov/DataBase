--First query

SELECT 
    age,
    COUNT(player) transfers
FROM 
    player_info p
GROUP BY age
ORDER BY age;

--Second query


SELECT
    p.position,
    round(COUNT(pi.player) * 100 / (SELECT COUNT(*) FROM player_info), 2) persentage
FROM 
    player_info pi
JOIN 
    players p ON pi.player = p.player
GROUP BY p.position
ORDER BY persentage DESC;

-- Third query

SELECT 
    s.season,
    COUNT(t.player) transfers
FROM 
    seasons s
JOIN transfer t on s.season = t.season
GROUP BY s.season
ORDER BY season;



