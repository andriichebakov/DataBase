CREATE OR REPLACE TRIGGER match_check
BEFORE INSERT
    ON Match
    FOR EACH ROW  
   
BEGIN  
    IF ( :new.home = :new.visitors ) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Home and visitors team cannot be the same!');
    END IF;
exception 
    when others then
        dbms_output.put_line('Home and visitors team cannot be the same!');
END;
