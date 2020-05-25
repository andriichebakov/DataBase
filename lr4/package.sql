CREATE OR REPLACE PACKAGE player_pkg IS
    TYPE player_row IS RECORD (
        player      transfer.player%TYPE,
        age     transfer.age%TYPE,
        season     transfer.season%TYPE
    );
    
TYPE player_table_type IS
    TABLE OF player_row;
    
FUNCTION getplayer (
    age_v      NUMBER,
    season_v   VARCHAR2
) RETURN player_table_type
    PIPELINED;
        
PROCEDURE add_match (
    home_team      VARCHAR,
    visitors_team   VARCHAR,
    home_team_score NUMBER,
    visitors_team_score NUMBER,
    datetime DATE
);
END player_pkg;

/

CREATE OR REPLACE PACKAGE BODY player_pkg IS


    FUNCTION getplayer (
    age_v      NUMBER,
    season_v   VARCHAR2
) RETURN player_table_type
    PIPELINED
IS
    CURSOR player_cursor IS
    SELECT
        player,
        age,
        season
    FROM
        transfer
    WHERE
        age = age_v
        and season = season_v;

BEGIN
    FOR play_row IN player_cursor LOOP
        PIPE ROW ( play_row );
    END LOOP;
END;
    
    PROCEDURE add_match (
    home_team      VARCHAR,
    visitors_team   VARCHAR,
    home_team_score NUMBER,
    visitors_team_score NUMBER,
    datetime DATE
) AS
    home_status NUMBER;
    visitors_status NUMBER;
    no_data EXCEPTION;
BEGIN

    SELECT
        COUNT(*)
    INTO home_status
    FROM
        Team
    WHERE
        team = home_team;

    SELECT
        COUNT(*)
    INTO visitors_status
    FROM
        Team
    WHERE
        team = visitors_team;

    IF (home_status = 1) and (visitors_status = 1)  THEN
        INSERT INTO Match (home, visitors, datetime, home_score, visitors_score) 
        VALUES (home_team, visitors_team, TO_DATE(datetime, 'YYYY-MM-DD HH24:MI:SS'), home_team_score, visitors_team_score);
    ELSE
        RAISE no_data;
    END IF;

EXCEPTION
    WHEN no_data THEN
        dbms_output.put_line('No such home or visitors team in the database');
END;
END player_pkg;       
        
        
        
        