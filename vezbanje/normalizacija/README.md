# Normalizacija 

## Pravila:

```
2NF: nema FZ od dela kljuca u nekljucne atribute

3NF: nema FZ nekljucnih atributa u nekljucne atribute

BCNF: nema FZ nekljucnih atributa u kljucne atribute
```

## Algoritam za nalazenje KK (kandidata za kljuc)

```
K1:
  Ukloniti trivijalne FZ
    `X -> Y  vazi Y < X`

K2:
  Naci grupe:
    I)   elementi koji se ne nalaze ni u jednoj FZ
    II)  elementi samo sa leve FZ
    III) elementi samo sa desne FZ
    IV)  elementi koji se nalaze sa obe strane

K3:
  Grupisati I) i II) (siguran deo KK)

K4:
  a) Ako se u III) dobije KK to je jedini KK
  b) Ako se u III) nije dobio KK, onda se kombinuje unija grupa I) i II) sa
     grupom IV). Kombinacije se vrse i iterativno po broju atributa.
      NA -> KA
```

### Zadatak1:

```
Autor(SIFA, SIFN, IME, KOJI)

F:
  (1) SIFA*, SIFN* -> IME, KOJI
  (2) SIFA* -> IME                (2NF)

--------------------------------------------------

KK:
  1. -
  2. SIFA, SIFN
  3. IME, KOJI
  4. -

  KA: (SIFA, SIFN)+ = (SIFA, SIFN, IME, KOJI)

--------------------------------------------------

R1 = (SIFA*, IME)
R2 = (SIFA*, SIFN*, KOJI)

F = R1 x R2

```

### Zadatak 2:

```
NASLOV(SIFN*, SIFA*, KOJI, NAZIVN, IME, SIFO, NAZIVO)

F:
  (1) SIFN*, SIFA* -> KOJI, NAZIVN, IME, SIFO, NAZIVO
  (2) SIFN* -> NAZIVN, SIFO                             (2NF)
  (3) SIFA* -> IME                                      (2NF)
  (4) SIFO -> NAZIVO                                    (3NF)

--------------------------------------------------------------------

KK:
  1. -
  2. SIFN, SIFA
  3. KOJI, NAZIVN, IME NAZIVO
  4. SIFO


  KA: (SIFN, SIFA)+ = SIFN, SIFA, KOJI, NAZIVN, IME, SIFO, NAZIVO

----------------------------------------------------------------------

R1 = (SIFA*, IME)
R2 = (SIFN*, SIFA*, KOJI, NAZIVN, SIFO, NAZIVO)

F = R1 x R2 

NOTE: PRVO SE OSLOBADJAMO (4) KAKO NE BISMO IZGUBILI INFORMACIJE

R3 = (SIFO*, NAZIVO)
R4 = (SIFN*, SIFA*, KOJI, NAZIV, SIFO)

R2 = R3 X R4

F = R1 x R3 x R4

R5 = (SIFN*, NAZIVN, SIFO)
R6 = (SIFN*, SIFA*, KOJI)

R4 = R5 X R6 

F = R1 X R3 X R5 X R6
```

### Zadatak 3:

```
P(SIFN*, SIFC*, DATUM*, DANA, SIFK, NAZIVN, SIFO, NAZIVO)

F:
  (1) SIFN*, SIFC*, DATUM* -> DANA             (SU)
  (2) SIFN*, SIFC*, DATUM* -> SIFK             (SU)
  (3) SIFN*, SIFC*, DATUM* -> NAZIVN           (SU)
  (4) SIFN*, SIFC*, DATUM* -> SIFO             (SU)
  (5) SIFN*, SIFC*, DATUM* -> NAZIVO           (SU)
  (6) SIFK -> SIFN*                            (BCNF)
  (7) SIFN* -> SIFO                            (2NF)
  (8) SIFN*, SIFC* -> SIFN*
  (9) SIFO -> NAZIVO                           (3NF)

--------------------------------------------------------------------------------

KK:
  1. -
  2. SIFC, DATUM
  3. DANA, NAZIVN, NAZIVO
  4. SIFN, SIFK, SIFO

  (SIFC, DATUM)+ = SIFC, DATUM

  KA: (SIFC, DATUM, SIFN)+ = SIFN, SIFC, DATUM, DANA, SIFK, NAZIVN, SIFO, NAZIVO 

--------------------------------------------------------------------------------

(9): 
  R1  = (SIFO*, NAZIVO*)
  R2 = (SIFN*, SIFC*, DATUM*, DANA, SIFK, NAZIVN, SIFO)

F = R1 X R2 

(7):
  R3 = (SIFN*, SIFO)
  R4 = (SIFN*, SIFC*, DATUM*, DANA, SIFK, NAZIVN)

F = R1 X R3 X R4

(6):
  R5 = (SIFK*, SIFN)
  R6 = (SIFC, DATUM, DANA, SIFK, NAZIVN)

F = R1 X R3 X R5 X R6
```

### Zadatak 4:

```
R(id_pacijenta*, ime, prezime, ptt, naziv_mesta, adresa, datum*, sifra_zahteva, naziv_zahteva, sifra_zuba, iznos_racuna)

F:
  (1) id_pacijenta* -> ime, prezime, ptt, naziv_mesta, adresa                                 (2NF)
  (2) ptt -> naziv_mesta                                                                      (3NF)
  (3) id_pacijenta*, datum* -> sifra_zahteva, naziv_zahteva, sifra_zuba, iznos_racuna         (SU)
  (4) sifra_zahteva -> naziv_zahteva                                                          (3NF)

-----------------------------------------------------------------------------------------------------------------------

KK:
  1. -
  2. id_pacijenta, datum
  3. ime, prezime, naziv_mesta, adresa, naziv_zahteva, sifra_zuba, iznos_racuna 
  4. ptt, sifra_zahteva

  KA: (id_pacijenta, datum)+ = id_pacijenta, datum, ime, prezime, ptt, naziv_mesta, adresa, sifra_zahteva, naziv_zahteva,
    sifra_zuba, iznos_racuna

-------------------------------------------------------------------------------------------------------------------------

(1):
  R1 = (id_pacijenta*, ime, prezime, ptt, naziv_mesta, adresa)
  R2 = (id_pacijenta*, datum*, sifra_zahteva, naziv_zahteva, sifra_zuba, naziv_zuba, iznos_racuna)

F = R1 x R2 

(2):
  R3 = (ptt*, naziv_mesta)
  R4 = (id_pacijenta*, ime, prezime, ptt, adresa)

  R1 = R3 x R4

F = R3 x R4 x R3 

(4):
  R5 = (sifra_zahteva*, naziv_zahteva)
  R6 = (id_pacijenta*, datum*, sifra_zahteva, sifra_zuba, naziv_zuba, iznos_racuna)

  R2 = R5 x R6

F = R3 x R4 x R5 x R6
```

### Zadatak 5:

```
R(sifra_ziotinje*, ime, vrsta, datum_rodjenja, mesto*, datum_dolaska*, datum_odlaska, zaduzena_osoba, komentar, proizvod*,
 alternativni_proizvod)

F:
  (1) sifra_zivotinje* -> ime, vrsta, datum_rodjenja                                              (2NF)
  (2) sifra_zivotinje*, mesto*, datum_dolaska* -> datum_odlaska, zaduzena_osoba, komentar         (2NF)
  (3) proizvod* -> alternativni_proizvod                                                          (2NF)

-------------------------------------------------------------------------------------------------------------------

KK:
  1. -
  2. sifra_zivotinje, mesto, datum_dolaska, proizvod
  3. ime, vrsta, datum_rodjenja, datum_odlaska, zaduzena_osoba, komentar, alternativni_proizvod
  4. -


  KA: (sifra_zivotinje, mesto, datum_dolaska, proizvod)+ =
    sifra_zivotinje, mesto, datum_dolaska, proizvod, ime, vrsta, datum_rodjenja, datum_odlaska,
    zaduzena_osoba, komentar, alternativni_proizvod

--------------------------------------------------------------------------------------------------------------------

(1):
  R1 = (sifra_zivotinje*, ime, vrsta, datum_rodjenja)
  R2 = (sifra_zivotinje*, mesto*, datum_dolaska*, proizvod*, datum_odlaska, zaduzena_osoba, komentar, alt_proizvod)

F = R1 x R2 

(2):
  R3 = (sifra_zivotinje*, mesto*, datum_dolaska*, datum_odlaska, zaduzena_osoba, komentar)
  R4 = (sifra_zivotinje*, mesto*, datumdolaska*, proizvod*, alt_proizvod)

F = R1 x R3 x R4

(3):
  R5 = (proizvod*, alt_proizvod)
  R6 = (sifra_zivotinje*, mesto*, datum_dolaska*, proizvod*)

F = R1 x R3 x R5 x R6
```

### Zadatak 6:

```
R(BrojRacuna*, RBTrans*, Stanje, Status, SifraKlijenta, ImeKlijenta, Datum, Iznos, VrstaTrans, Naziv)

F:
  (1) BrojRacuna*, RBTrans* -> Stanje, Status, SifraKlijenta, ImeKlijenta, Datum, Iznos, VrstaTrans, Naziv    (SU)
  (2) BrojRacuna* -> Stanje, Status, SifraKlijenta, ImeKlijenta                                               (2NF)
  (3) SifraKlijenta -> ImeKlijenta                                                                            (3NF)
  (4) VrstaTrans -> Naziv                                                                                     (3NF)

---------------------------------------------------------------------------------------------------------------------

KK:
  1. -
  2. BrojRacuna, RBTrans, 
  3. Stanje, Status, ImeKlijenta, Datum, Iznos, Naziv
  4. VrstaTrans, SifraKlijenta

  KA: (BrojRacuna, RBTrans)+ = BrojRacuna, RBTrans, Stanje, Status, SifraKlijenta, Datum, Iznos, VrstaTrans, Naziv

---------------------------------------------------------------------------------------------------------------------

(2):
  R1 = (BrojRacuna*, Stanje, Status, SifraKlijenta, ImeKlijenta)
  R2 = (BrojRacuna*, RBTrans*, Datum, Iznos, VrstaTrans, Naziv)

F = R1 x R2 

(3):
  R3 = (SifraKlijenta*, ImeKlijenta)
  R4 = (BrojRacuna*, Stanje, Status, SifraKlijenta)

  R1 = R3 x R4 

F = R3 x R4 x R3 

(4):
  R5 = (VrstaTrans*, Naziv)
  R6 = (BrojRacuna*, RBTrans*, Datum, Iznos, VrstaTrans)

  R2 = R5 x R6

F = R3 x R4 x R5 x R6
```

### Zadatak 7:

```
R(id_pozorista*, naziv, adresa, broj_telefona, ime_predstave, sifra_predstave*, reditelj, zanr)

F:
  (1) id_pozorista* -> naziv, adresa, broj_telefona                           (2NF)
  (2) broj_telefona -> adresa                                                 (3NF)
  (3) id_pozorista*, sifra_predstave* -> reditelj, zanr, ime_predstave        (SU)
  (4) ime_predstave -> sifra_predstave*                                       (BCNF)

---------------------------------------------------------------------------------------------------------------------

KK:
  1. 
  2. id_pozorista,
  3. naziv, adresa, reditelj, zanr
  4. broj_telefona, ime_predstave, sifra_predstave

  (id_pozorista)+ = id_pozorista, naziv, adresa, broj_telefona

  KA: (id_pozorista, sifra_predstave)+ = id_pozorista, ime_predstave, naziv, adresa, broj_telefona, sifra_predstave,
    reditelj, zanr 

-----------------------------------------------------------------------------------------------------------------------

(1):
  R1 = (id_pozorista*, naziv, adresa, broj_telefona)
  R2 = (id_pozorista*, sifra_predstave*, ime_predstave, reditelj, zanr)

F = R1 x R2 

(2):
  R3 = (broj_telefona*, adresa)
  R4 = (id_pozorista*, naziv, broj_telefona)

  R1 = R3 x R4 

F = R3 x R4 x R2

(4):
  R5 = (ime_predstave*, sifra_predstave)
  R6 = (id_predstave*, ime_predstave, reditelj, zanr)

  R2 = R5 x R6 

F = R3 x R4 x R5 x R6
```

