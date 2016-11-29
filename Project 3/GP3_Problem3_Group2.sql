--Insert a certain number of extras into a certain movie
create or replace  PROCEDURE insertExtras(mname_in IN VARCHAR, count_in IN NUMBER)
  AS
    counter NUMBER;
    max_pid NUMBER;
  BEGIN
    SELECT max(pid) INTO max_pid
    FROM performer;
    
    max_pid := max_pid+1;
  
    FOR counter IN 1 .. count_in
    LOOP
      INSERT INTO performer VALUES (max_pid, 'extra', 0, 18);
      INSERT INTO acted VALUES(max_pid, mname_in);
      max_pid := max_pid+1;
    END LOOP;
  END insertExtras;
  
--Calculate the average of all actors from a certain movie
create or replace  FUNCTION avgAgeInMovie(mname_in IN VARCHAR2) RETURN NUMBER
  AS
    avg_age NUMBER;
  BEGIN
    SELECT avg(age) INTO avg_age
    FROM performer
    WHERE pid IN(
      SELECT pid
      FROM acted
      WHERE mname = mname_in
    );
    
  IF avg_age = NULL
  THEN avg_age := 0;
  ELSE avg_age := floor(avg_age);
  END IF;
  
  RETURN avg_age;
  END avgAgeInMovie;

-- Anonymous block for running procedure and function
DECLARE
 results NUMBER;
BEGIN
  insertextras('Up', 5);
  results := avgageinmovie('Up');
  DBMS_OUTPUT.PUT_LINE(results);
END;
