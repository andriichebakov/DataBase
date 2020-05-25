SET SERVEROUTPUT ON;

--робота функції

SELECT * FROM TABLE(getplayer(19, 'season_1')); 
SELECT * FROM TABLE(getplayer(20, 'season_1')); 
SELECT * FROM TABLE(getplayer(35, 'what season?'));

--робота процедури та тригеру

BEGIN
  add_match('team_3', 'team_2', 2, 1, current_date);
  add_match('team_1', 'team_100', 0, 3, current_date); 
  add_match('team_1', 'team_1', 0, 3, current_date); 
END;