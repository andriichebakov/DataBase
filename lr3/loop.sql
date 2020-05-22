DECLARE
    position        players.position%TYPE;
BEGIN
    INSERT INTO positions VALUES ('Centre-Forward');
    INSERT INTO positions VALUES ('Attacking Midfield');
    INSERT INTO positions VALUES ('Left Winger');
    INSERT INTO positions VALUES ('Right Winger');
    INSERT INTO positions VALUES ('Centre-Back');
    INSERT INTO positions VALUES ('Central Midfield');
    FOR i IN 1..12 LOOP
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