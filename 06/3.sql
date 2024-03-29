DROP DATABASE IF EXISTS ROBA;
CREATE DATABASE IF NOT EXISTS ROBA;

CREATE TABLE NABAVKA(
  SIF_N INT NOT NULL PRIMARY KEY,
  DATUM INT NOT NULL CHECK(DATUM BETWEEN 1 AND 365), 
  KOLICINA NOT NULL CHECK(KOLICINA > 0), 
  CENA UNSIGNED NOT NULL, 
  SIF_R INT REFERENCES ROBA(SIF_R) ON DELETE CASCADE ON UPDATE CASCADE
  UNIQUE(DATUM, SIF_R)
);

ALTER TABLE NABAVKA
ADD CHECK(
  NOT EXISTS (
    SELECT * 
    FROM NABAVKA AS N1
    WHERE N1.CENA > 1.1*(
      SELECT N2.CENA
      FROM NABAVKA AS N2
      WHERE N2.SIF_R = N1.SIF_R AND N2.DATUM = (
        SELECT MAX(N3.DATUM)
        FROM NABAVKA AS N3
        WHERE N3.SIF_R = N2.SIF_R AND N3.DATUM < N1.DATUM
      )
    )
  )
);