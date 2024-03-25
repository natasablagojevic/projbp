-- DROP DATABASE 

CREATE TABLE Takmicenje(
    sifra VARCHAR(10) NOT NULL PRIMARY KEY,
    naziv VARCHAR(40) NOT NULL,
    datumPocetka DATE NOT NULL
);

CREATE TABLE Disciplina(
    sifra VARCHAR(10) NOT NULL PRIMARY KEY,
    naziv VARCHAR(30) NOT NULL,
    rekord INT CHECK(rekord BETWEEN 0 AND 100)
);

CREATE TABLE Borba(
    sifraTakmicenja VARCHAR(10) NOT NULL.
    stepen VARCHAR(3) CHECK(stepen IN ('I', 'II', 'III', 'IV')),
    sifraDiscipline VARCHAR(10) NOT NULL,
    datum DATE NOT NULL,
    rezultat INT CHECK(rezultat BETWEEN 0 AND 100) DEFAULT 0,
    PRIMARY KEY(sifraTakmicenja, sifraDiscipline),
    UNIQUE(sifraTakmicenja, sifraDiscipline),
    CONSTRAINT takmicenje_fk FOREIGN KEY (sifraTakmicenja) REFERENCES Takmicenje(sifra) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT disciplina_fk FOREIGN KEY (sifraDiscipline) REFERENCES Disciplina(sifra) ON DELETE CASCADE ON UPDATE CASCADE
);

-- INSERT INTO Disciplina
-- VALUES('')