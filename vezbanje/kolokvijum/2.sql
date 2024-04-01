DROP DATABASE IF EXISTS AtletskiSavez;
CREATE DATABASE IF NOT EXISTS AtletskiSvaez;

USE AtletskiSavez;

CREATE TABLE Takmicenje(
	sifra INT NOT NULL PRIMARY KEY,
	naziv VARCHAR(50) NOT NULL,
	datum_pocetka DATE NOT NULL	
);

CREATE TABLE Borba(
	sifra_takmicenja INT NOT NULL, 
	stepen VARCHAR(4) NOT NULL CHECK(stepen in ('I', 'II', 'III', 'IV')),
	sifra_discipline INT NOT NULL PRIMARY KEY,
	datum DATE NOT NULL,
	rezultat INT NOT NULL DEFAULT 0,
	CONSTRAINT fk_takmicenje FOREIGN KEY (sifra_takmicenja) REFERENCES Takmicenje(sifra)
);

CREATE TABLE Disciplina(
	sifra INT NOT NULL,
	naziv VARCHAR(50) NOT NULL,
	rekord INT NOT NULL CHECK(rekord BETWEEN 0 AND 100)
)
