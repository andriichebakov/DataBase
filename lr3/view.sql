CREATE VIEW transfers_view AS
    SELECT 
        pi.age,
        t.player,
        p.position,
        s.season
    FROM
        transfer t
        INNER JOIN player_info pi ON t.player = pi.player
        INNER JOIN players p ON t.player = p.player
        INNER JOIN seasons s ON t.season = s.season;