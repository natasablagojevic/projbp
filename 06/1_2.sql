DROP DATABASE IF EXISTS uvod;

CREATE DATABASE uvod CHARACTER SET=UTF8;

USE uvod;

CREATE TABLE STUDENT(
  -- IME_KOLONE TIP OPCIJE
  ID INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
  IME VARCHAR(50) NOT NULL,
  PREZIME VARCHAR(50) NOT NULL,
  PROSEK DOUBLE NOT NULL CHECK(PROSEK BETWEEN 6.0 AND 10.0),
  STATUS BOOLEAN DEFAULT 0
); 

-- INSERT INTO STUDENT
-- VALUES(1, 'PETAR', 'PETROVIC', 9.65, 1),
--       (2, 'MARKO', 'MARKOVIC', 7.73, 0);

INSERT INTO STUDENT(ID, IME, PREZIME, PROSEK)
VALUES
  (1, 'PETAR', 'PETROVIC', 9.65),
  (2, 'MARKO', 'MARKOVIC', 7.73);
  
-- SELECT * FROM DA.STUDENT \G -- DA ISPISUJE PO REDOVIMA

CREATE TABLE DODATNE_INFORMACIJE(
  ID_STUDENTA INT,
  DATUM_UPISA DATE,
  GRAD VARCHAR(30),
  DRZAVA VARCHAR(30),
  CONSTRAINT FK_ID FOREIGN KEY (ID_STUDENTA) REFERENCES STUDENT(ID) ON DELETE CASCADE ON UPDATE CASCADE
);

-- RESTRICT, NO ACTION, CASCADE, SET NULL, SET DEFAULT 
-- RESTRICT = NE DOZVOLJAVA NIKAKVO BRISANJE
-- NO ACTION = ISTO, NE DOZVOLJAVA BRISANJE, SAMO SE PROVERA ODLAZE ZA KASNIJE JER POSTOJI MOGUCNOST DA JE TO BRISANJE POSLEDICA NEKOG KASKADNOG BRISANJA
-- CASCADE = VRSI SE KASKADNO BRISANJE, BRISE SE RED, PA CE SE I ON AZURIRATI 
-- SET NULL = POSTAVI NA NULL
-- SET DEFAULT = POSTAVI NA DEFAULT VREDNOST 

INSERT INTO DODATNE_INFORMACIJE
VALUES
  (1, '2020-10-10', 'BEOGRAD', 'SRBIJA');

-- SELECT * FORM DA.DODATNE_INFORMACIJE;

