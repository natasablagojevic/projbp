CREATE VIEW INFO(SSN, NAME, COMPANY, SALARY, UNIVERSITY, MAJOR) AS 
SELECT P.SSN, P.NAME, E.COMPANY, E.SALARY, S.UNIVERSITY, S.MAJOR
FROM PERSONS P LEFT JOIN EMPLOYEES E ON P.SSN = E.SSN 
               LEFT JOIN STUDENTS S ON P.SSN = S.SSN 
 
--#SET TERMINATOR @ 
CREATE TRIGGER INFO_DELETE INSTEAD OF DELETE ON INFO 
REFERENCING
    OLD AS O 
FOR EACH ROW MODE DB2SQL
    BEGIN  ATOMIC 
        DELETE FROM PERSONS 
        WHERE SSN = O.SSN;
    END @


CREATE RIGGER INFO_INSERT INSTEAD OF INSERT ON INFO 
REFERENCING 
    NEW AS N  
FOR EACH ROW MODE DB2SQL
    BEGIN ATOMIC 

        INSERT INTO PERSONS 
        VALUES (N.SSN, N.NAME);

        IF N.UNIVERSITY IS NOT NULL 
        THEN
            INSERT INTO STUDENTS
            VALUES (N.SNN, N.UNIVERSITY, N.MAJOR);
        END IF;

        IF N.COMPANY IS NOT NULL 
        THEN 
            INSERT INTO EMPLOYEES 
            VALUES (N.SSN, N.COMPANY, N.SALARY)
        END IF;
    END@

CREATE TRIGGER INFO_UPDATE INSTEAD OF UPDATE ON INFO 
REFERENCING 
    NEW AS N 
    OLD AS O 
FOR EACH ROW MODE DB2SQL 
    BEGIN ATOMIC 

        IF N.SSN <> O.SSN 
        THEN 
            INSERT INTO PERSONS 
            VALUES (N.SNN, N.NAME)
        END IF; 


        IF O.UNIVERSITY IS NULL AND N.UNIVERSITY IS NOT NULL 
        THEN 
            INSERT INTO STUDENTS
            VALUES (N.SSN, N.UNIVERSITY, N.MAJOR);
        END IF; 

        IF O.UNIVERSITY IS NULL AND N.UNIVERSITY 
        THEN 
            DELETE FROM STUDENTS
            WHERE SSN = O.SSN;
        END IF;

        IF O.UNIVERSITY IS NOT NULL AND N.UNIVERSITY IS NOT NULL 
        THEN 
            UPDATE STUDENTS 
            SET SSN = N.SSN, UNIVERSITY = N.UNIVERSITY, MAJOR = N.MAJOR
            WHERE SSN = O.SSN;

        IF N.SSN <> O.SSN 
        THEN 
            DELETE FROM PERSONS 
            WHERE SSN = O.SSN;
        END IF;

    END @

--#SET TERMINATOR ;