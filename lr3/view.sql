CREATE VIEW transfers_view AS
    SELECT 
        pi.age,
        t.player,
        p.position,
        t.season
    FROM
        transfer t
        INNER JOIN player_info pi ON t.player = pi.player AND t.season = pi.season
        INNER JOIN players p ON t.player = p.player;
