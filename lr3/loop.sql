DECLARE
    position        players.position%TYPE;
    players_count   INTEGER;
BEGIN
    SELECT
        COUNT(DISTINCT player)
    INTO players_count
    FROM
        player_info;

    FOR i IN 1..players_count LOOP
        IF i > 10 THEN
            position := 'Centre-Forward';
        ELSIF i > 8 THEN
            position := 'Attacking Midfield';
        ELSIF i > 6 THEN
            position := 'Central Midfield';
        ELSIF i > 4 THEN
            position := 'Left Winger';
        ELSIF i > 2 THEN
            position := 'Right Winger';
        ELSE
            position := 'Centre-Back';
        END IF;

        INSERT INTO players (
            player,
            position
        ) VALUES (
            'player_' || i,
            position
        );

    END LOOP;

END;