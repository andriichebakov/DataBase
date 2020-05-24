DECLARE
    age        Transfer.age%TYPE;
    team1        Team.team%TYPE;
    team2        Team.team%TYPE;
BEGIN
    FOR i IN 1..3 LOOP
    
        INSERT INTO Team (
            team
        ) VALUES (
            'team_' || i
        );
        
        
        INSERT INTO Position (
            position
        ) VALUES (
            'position_' || i
        );

        
        INSERT INTO Season (
            season
        ) VALUES (
            'season_' || i
        );
        
        INSERT INTO Player (
            player,
            position
        ) VALUES (
            'player_' || i,
            'position_' || i
        );
        

    END LOOP;

    FOR i IN 1..3 LOOP
        IF i = 1 THEN
            age := 19;
            team1 := 'team_1';
            team2 := 'team_2';
        ELSIF i = 2 THEN
            age := 25;
            team1 := 'team_2';
            team2 := 'team_3';
        ELSIF i = 3 THEN
            age := 35;
            team1 := 'team_3';
            team2 := 'team_1';
        END IF;
            
        INSERT INTO Transfer (
            player,
            season,
            team_from,
            team_to,
            age
        ) VALUES (
            'player_' || i,
            'season_' || i,
            team1,
            team2,
            age
        );
        
        INSERT INTO Match (
            home,
            visitors,
            datetime,
            home_score,
            visitors_score
        ) VALUES (
            team1,
            team2,
            '13.0' || i || '.20',
            i,
            i-1
        );        
            
    END LOOP;
    

END;