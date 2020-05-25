CREATE TYPE player_row IS OBJECT (
    player   VARCHAR2(60),
    age      NUMBER,
    season   VARCHAR2(9)
);

CREATE OR REPLACE TYPE player_table_type IS
    TABLE OF player_row

CREATE OR REPLACE FUNCTION getplayer (
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
        OR season = season_v;

BEGIN
    FOR play_row IN player_cursor LOOP
        PIPE ROW ( player_row(play_row.player, play_row.age, play_row.season) );
    END LOOP;
END;