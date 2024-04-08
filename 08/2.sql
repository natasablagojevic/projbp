CREATE TABLE PROFILES (
    EMPID INT, 
    NAME VARCHAR(20),
    SQLID VARCHAR(18),
    MGRID INT,
    SALARY DECIMAL(9,2),
    ISMGR CHAR(1)
);

INSERT INTO PROFILES 
VALUES ...;

SELECT *
FROM PROFILES;

-- POGLED KOJI IMA TRI KOLONE KOJE SU NAM BILE POTREBNE 
CREATE VIEW MY_EMPS(EMPID, LEVEL, SALARY) AS
    WITH REC(EMPID, LEVEL, SALARY) AS (
        -- BAZA REKURZIJE
        SELECT P.EMPID, 0, P.SALARY 
        FROM PROFILES AS P 
        WHERE P.SQLID = USER 

        UNION ALL 

        -- NADOVEZIVANJE NOVIH REDOVA U TABELI
        -- REKURZIVNI KORAK
        SELECT P.EMPID, R.LEVEL - 1, P.SALARY
        FROM PROFILES AS P, REC AS R 
        WHERE P.MGRID = R.EMPID AND R.LEVEL > -100 
    )
    SELECT EMPID, LEVEL, SALARY
    FROM REC;

SELECT EMPID, LEVEL, SALARY
FROM REC;

-- ZADATAK 3

CREATE VIEW EMPS(EMPID, NAME, MGRID, SALARY, SQLID, ISMGR) AS 
SELECT P.EMPID, P.NAME, PM.EMPID, ME.SALARY, P.SQLID, P.ISMGR 
FROM PROFILES AS P LEFT JOIN MY_EMPS AS ME ON P.EMPID = ME.EMPID 
    LEFT JOIN PROFILES AS PM ON PM.EMPID = P.EMPID;

SELECT * 
FROM EMPS;

-- ZADATAK 3
-- PRAVLJENJE OKIDACA TAKO DA MOGU DA SE DODAJU ODREDJENI RADNICI

--#SET TERMINATOR @ 
CREATE TRIGGER EMP_INSERT INSERT ON EMPS 
REFERENCING NEW AS N 
FOR EACH ROW MODE DB2SQL  
    BEGIN ATOMIC 
        DECLARE MGRID INT;
        DECLARE ISMGR CHAR(1);

        SET (MGRID, ISMGR) = (
            SELECT P.MGRID, P.ISMGR
            FROM PROFILES AS P 
            WHERE N.NAME = P.NAME
        );



        IF MGRID NOT IN (SELECT EMPID FROM MY_EMPS) OR ISMGR <> 'Y'
            THEN 
                SIGNAL SQLSTATE '70000' SET MESSAGE_TEXT = 'NE MOZE!';
        END IF;
    END@

--#SET TERMINATOR ;

-- ZADATAK 4

--#SET TERMINATOR @ 
CREATE TRIGGER EMP_UPDATE_TRIGGER INSTEAD OF UPDATE ON EMPS 
REFERENCING
    NEW AS N 
    OLD AS O 
FOR EACH ROW 
    BEGIN ATOMIC
        DECLARE NEW_MGRID INT;
        DECLARE OLD_MGRID INT;
        
        SET NEW_MGRID = (
            SELECT P.EMPID 
            FROM PROFILES P 
            WHERE N.NAME = P.NAME 
        );

        SET OLD_MGRID = (
            SELECT P.EMPID
            FROM PROFILES P 
            WHERE O.NAME = P.NAME
        );

        IF OLD_MGRID NOT IN (SELECT * FROM MY_EMPS) OR 
           NEW_MGRID NOT IN (SELECT * FROM MY_EMPS) OR 
           O.SQLID = USER OR 
           (0 < (SELECT COUNT(*) FROM PROFILES P WHERE N.EMPID = P.MGRID) AND N.ISMGR = 'N') OR
           NEW_MGRID IN (SELECT P.MGRID FROM PROFILES P WHERE P.ISMGR = 'Y')
            THEN SIGNAL SQLSTATE '70000' SET MESSAGE_TEXT = 'NOT AUTHORIZED!';
        END IF; 


        UPDATE PROFILES 
        SET (EMPID, NAME, SQLID, MGRID, SALARY, ISMGR) = (N.EMPID, N.NAME. N.SQLID, NEW_MGRID, N.SALARY, N.ISMGR)
        WHERE O.EMPID = EMPID ;

    END @

--#SET TERMINATOR ;