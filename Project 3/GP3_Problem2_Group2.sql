create or replace PACKAGE GP3_PROBLEM2_GROUP2 AS 
  
  /* Procedure for option 1 */
  PROCEDURE insertPerformerOption1
  (pid_in IN NUMBER, pname_in IN VARCHAR, age_in IN NUMBER);
  
  /* Procedure for option 2 */
  PROCEDURE insertPerformerOption2
  (pid_in IN NUMBER, pname_in IN VARCHAR, age_in IN NUMBER, did_in IN NUMBER); 

END GP3_PROBLEM2_GROUP2;

create or replace PACKAGE BODY GP3_PROBLEM2_GROUP2 AS

  PROCEDURE insertPerformerOption1
  (pid_in IN NUMBER, pname_in IN VARCHAR, age_in IN NUMBER) AS
  /* declare variable*/
  yoe NUMBER;
  BEGIN
    /* Get the average years of experience */
    SELECT floor(AVG(years_of_experience))
    INTO yoe
    FROM Performer
    WHERE age between age_in - 10 and age_in + 10;
    /* Check the nullity fo years of experience (yoe) */
    IF yoe IS NULL
    THEN
      yoe := age_in - 18;
    END IF;
    /* Check the validity of yoe */
    IF yoe < 0  -- for negative values
    THEN
      yoe := 0; -- for values over performer age
    ELSIF yoe > age_in
    THEN
      yoe := age_in;
    END IF;
    /* Add to table NOTE: pid not checked*/
    INSERT INTO Performer VALUES (pid_in, pname_in, yoe, age_in);
  END insertPerformerOption1;

  PROCEDURE insertPerformerOption2
  (pid_in IN NUMBER, pname_in IN VARCHAR, age_in IN NUMBER, did_in IN NUMBER) AS
  /* declare variable*/
  yoe NUMBER;
  BEGIN
    /* Get the average years of experience */
    SELECT floor(AVG(years_of_experience))
    INTO yoe
    FROM Performer
    WHERE pid IN (
      SELECT pid
      FROM Acted
      WHERE mname IN (
        SELECT mname
        FROM Movie
        WHERE did = did_in ));
    /* Check the nullity fo years of experience (yoe) */
    IF yoe IS NULL
    THEN
      yoe := age_in - 18;
    END IF;
    /* Check the validity of yoe */
    IF yoe < 0  -- for negative values
    THEN
      yoe := 0; -- for values over performer age
    ELSIF yoe > age_in
    THEN
      yoe := age_in;
    END IF;
    /* Add to table NOTE: pid not checked*/
    INSERT INTO Performer VALUES (pid_in, pname_in, yoe, age_in);
  END insertPerformerOption2;

END GP3_PROBLEM2_GROUP2;
