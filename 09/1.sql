-- pogledi predstavljaju rezultate nekog upita
-- promenljiva koja predstavlja upit na odredjenoj tabeli
-- sve informacije koje pogled ima, cuva u originalnoj tabeli 

-- db2 connect to stud2020 



-- -------------------------------------------------------------------------

-- PRIMER:
-- CREATE VIEW OCLICNI(ID, IME) AS
-- SELECT ID, IME 
-- FROM UCENICI 
-- WHERE PROSEK >= 4.5;

-- UPDATE ODLICNI  

-- DELETE FROM ODLICNI 
-- WHERE ID = 2;

-- za transformaciju kolone moraju da se koriste pogledi 
--

-- --------------------------------------------------------------------------

--#SET TERMINATOR @ 
CREATE TRIGGER UNOSINFORMACIJA INSTEAD OF INSERT ON INFORMACIJE 
REFERENCNG 
    NEW AS N
FOR EACH ROW MODE DB2SQL  
    BEGIN ATOMIC
        INSERT INTO KORISNIK
        VALUES (N.ID, N.IME);

        INSERT INTO DODATENINFORMACIJE
        VALUES (N.ID, N.EMAIL, N.TELEFON);
    END @
--#SET TERMINATOR ;