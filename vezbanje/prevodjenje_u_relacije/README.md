# Prevodjenje ER dijagrama u Relacije 


### PRAVILA:

```

K1. Prevode se svi nezavisni entiteti u posebne table:
  - Svi atributi entiteta postaju polja tabele;
  - Primarni kljuc entiteta postaje primarni kljuc tabele.
K2. Prevode se zavisni entiteti i specijalizacije u posebne tabele:
  - Svi atributi zavisnog/specijalizovanog entiteta postaju polja tabele;
  - Dodaje kao strani kljuc tj. primarni kljuc entiteta koji identifikuje taj zavisan entitet
    (odnosno, cini generalizaciju).
K3. Agregirani entiteti i relacije se prevode u zavisnosti od kardinalnosati na sledeci nacin:
  a) Ako je sa bar jedne strane kardinalnost (1, 1):
    - Ne pravimo pravimo novu tabelu, vec uzimamo primarni kljuc iz tabele KA kojoj je 
      kardinalnost (1, 1) i stavljamo ga, kao strani kljuc,  u tabelu OD koje je kardinalnost (1, 1);
    - Atributi koji pripadaju relaciji se dodaju tabeli, zajedno sa stranim
      kljucem, OD koje je kardinalnost (1, 1).
    
    E1 --(1,1)-- R --(?,?)-- E2
        --KA-->     <--OD--
        
    Primarni kljuc od E2 stavljamo kao strani kljuc u E1.
    Napomena: Samo u slucaju (1, 1) kardinalnosti ne prevodimo odnos u tabelu.
  
  b) Inace, ako je sa bar jedne strane kardinalnost (0, 1):
    - Pravimo novu tabelu koja se sastoji od:
      1. Primarnog kljuca entiteta od kojeg je kardinalnost (0, 1) - strani kljuc;
      2. Primarnog kljuca entiteta ka kojem je kardinalnost (0, 1) - strani kljuc;
      3. Svih atributa koji pripadaju tom odnosu na dijagramu.
    - Primarni kljuc je strani kljuc od tabele od koje je kardinalnost (0, 1)
    
    E1 --(0,1)-- R --(?,?)-- E2
        --KA-->     <--OD--
        
    Primarni kljuc je strani kljuc od E1.
    
  c) Inace, imamo vise-vise vezu:
    - Pravimo novu tabelu koja se sastoji od:
      1. Primarnog kljuca prvog entiteta - strani kljuc;
      2. Primarnog kljuca drugog kljuca - strani kljuc
      3. Svih atributa koji pripadaju toj relaciji;
      
    Primarni kljuc je unija stranih kljuceva.
         
```

#### Zadatak 1:

![Primer1](./slike/primer1.png)

```
Zaposleni(*JMBG, ime, prezime, adresa, telefon)
Autobus(*reg_broj, tip, god_nabavke, aktivan)
Linija(*sifra, polazna_stanica, krajnja_stanica, trajanje_voznje)
ServisnaUsluga(*sifra, naziv, koliko_puta)
RezervniDeo(*sifra, naziv, jed_mere, trenune_zalihe, min_dozvola_zaliha)

Vozac(*^JMBG, kat_voz_dozvol, zdravstveno_stanje)
  Vozac[JMBG] < Zaposleni[JMBG]

Automehanicar(*^JMBG, strucna_sprema)
  Automehanicar[JMBG] < Zaposleni[JMBG]

Rasporedjen(*^JMBG_vozaca, ^reg_broj_autobusa)
  Rasporedjen[JMBG_vozaca] < Vozac[JMBG]
  Rasporedjen[reg_broj_autobusa] < Autobus[reg_broj]

Saobraca(*^reg_broj_autobusa, ^sifra_linije)
  Saobraca[reg_broj_autobusa] < Autobus[reg_broj]
  Saobraca[sifra_linije] < Linja[sifra]

Potrebni(*^sifra_serv_usluge, *^sifra_rez_dela, kolicina)
  Potrebni[sifra_serv_usluge] < ServisnaUsluga[sifra]
  Potrebni[sifra_rez_dela] < RezervniDeo[sifra]

Izvrsava(*^reg_broj_autobusa, *^sifra_serv_usluge, datum, ^JMBG_automehanicara)
  Izvrsava[reg_broj_autobusa] < Autobus[reg_broj]
  Izvrsava[sifra_serv_usluge] < ServisnaUsluga[sifra]

Koriscen(*^reg_broj_autobusa, *^sifra_serv_usluge, *^sifra_rez_dela, kolicina)
  Koriscen[reg_broj_autobusa, sifra_serv_usluge] < Izvrsava[reg_broj_autobusa, sifra_serv_usluge]
  Koriscen[sifra_serv_usluge, sifra_rez_dela] < Potrebni[sifra_serv_usluge, sifra_rez_dela]

Zamena(*^sifra_rez_dela1, *^sifra_rez_dela2, uslov)
  Zamena[sifra_rez_dela1] < RezervniDeo[sifra]
  Zamena[sifra_rez_dela2] < RezervniDeo[sifra]
```

### Zadatak 2: 

![Primer2](./slike/primer2.png)

```
Zaposleni(*JMBG, ime, prezime, datum_zasn_rad, naziv_rad_mesta, adresa, telefon)
Kupac(*sifra, naziv adresa, telefon, ^JMBG_prodavca)
  Kupac[JMBG_prodavca] < Prodavac[JMBG]

Narudzbenica(*sifra, datum, status, ^sifra_kupca)
  Narudzbenica[sifra_kupca] < Kupac[sifra]

Faktura(*id, ukupan_iznos, rok_uplate, ^sifra_narudzbenice)
  Faktura[sifra_narudzbenie] < Narudzbenica[sifra]

Uplatnica(*id, datum, nacin_placanja, ^id_fakture)
  Uplatnica[id_fakture] < Faktura[id]

Artikal(*sifra, naziv, rabat, knjigov_cena, min_dop_zal, jed_mere, kolicina_na_zalihama)
Dobavljac(*sifra, naziv, telefon, adresa)

Prodavac(*^JMBG, provizija)
  Prodavac[JMBG] < Zaposleni[JMBG]

Otpremnica(*^sifra_narudzbenice, datum, ^JMBG_zaposlenog)
  Otpremnica[sifra_narudzbenice] < Narudzbenica[sifra]
  Otpremnica[JMBG_zaposlenog] < Zaposleni[JMBG]

Nabavka(*^sifra_dobavljaca, datum, iznos)
  Nabavka[sifra_dobavljaca] < Dobavljac[sifra]

Sadrzi(*^sifra_narudzbenice, *^sifra_artikla, cena, kolicina)
  Sadrzi[sifra_narudzbenice] < Narudzbenica[sifra]
  Sadrzi[sifra_artika] < Artikal[sifra]

Isporuceno(*^sifra_narudzbenice, *^sifra_artikla, kolicina)
  Isporuceno[sifra_narudzbenice, sifra_artikla] < Sadrzi[sifra_narudzbenice, sifra_artikla]
  Isporuceno[sifra_narudzbenice] < Otpremnica[sifra_narudzbenice]

Dobavlja(*^sifra_dobavljaca, *^sifra_artikla)
  Dobavlja[sifra_dobavljaca] < Dobavljac[sifra]
  Dobavlja[sifra_artikla] < Artikal[sifra]

Nabavlja(*^sifra_dobavljaca, *^sifra_artikla, kolicina, cena)
  Nabavlja[sifra_dobavljaca] < Nabavka[sifra_dobavljaca]
  Nabavlja[sifra_dobavljaca, sifra_artikla] < Dobavlja[sifra_dobavljaca, sifra_artikla]
```

### Zadatak 3

![Primer3](./slike/primer3.png)

```
K1:
Zaposleni(*MRB, ime, prezime, adresa)
Apoteka(*sifra, naziv, adresa)
Lek(*sifre, naziv, pros_mesecne_potrebe)
Nabavka(*sifra, rok_isporuke, nacin_placanja, ukupni_iznos, datum_isporuke, ^MBR_komercijaliste, ^sifra_veletrgovine)
  Nabavka[MBR_komercijaliste] < Komercijalista[MBR]
  Nabavka[sifra_veletrgovine] < Veletrgovina[sifra]

Veletrgovina(*sifra, telefon, naziv, adresa)

K2:
Farmaceut(*^MBR, strucna_sprema)
  Farmaceut[MBR] < Zaposleni[MBR]

Komercijalista(*^MBR, telefon)
  Komercijalista[MBR] < Zaposleni[MBR]

K3:
Zaposlen(*^sifra_apoteka, *^MBR_farmaceut, datum, dana, meseci)
  Zaposlen[sifra_apteka] < Apoteka[sifra]
  Zaposleni[MBR_farmaceut] < Farmaceut[MBR]

Raspolaze(*^sifra_apoteka, *^sifra_lek, kolicina, pros_mes_potrebe)
  Raspolaze[sifra_apoteka] < Apoteka[sifra]
  Raspolaze[sifra_lek] < Lek[sifra]

Isporucuje(*^sifra_lek, *^sifra_nabavka, kolicina)
  Isporucuje[sifra_lek] < Lek[sifra]
  Isporucuje[sifra_nabavka] < Nabavka[sifra]

Isporucen(*^sifra_lek, *^sifra_nabavka, *^sifra_apoteka, kolicina)
  Isporucen[sifra_lek, sifra_nabavka] < Isporucuje[sifra_lek, sifra_nabavka]
  Isporucen[sifra_apoteka] < Apoteka[sifra]

Zamena(*^sifra_lek1, *^sifra_lek2)
  Zamena[sifra_lek1] < Lek[sifra]
  Zamena[sifra_lek2] < Lek[sifra]
```

### Zadatak 4: ???

![Primer4](./slike/primer4.png)

```
Biljka(*id, naziv, jed_mere, kolicina, min_dozv_zalihe, cena)
Dobavljac(*id, naziv, adresa, drzava, telefon)
Mesavina(*id, jed_mere, kolicina_za_zalihama, cena)
Narudzbina(*id, datum, uslovi_placanja, ^id_kupca)
  Narudzbina[id_kupca] < Kupac[id]

Kupac(*id, naziv, adresa, telefon, osoba_za_kontakt)
Racun(*id, ukupan_iznos, ^id_narudzbina)
  Racun[id_narudzbina] < Narudzbina[id]

Nabavka(*^id_dobavljaca, datum)
  nabavka[id_dobavljaca] < Dobavljac[id]

Naplata(*^id_racuna, redni_broj_rate, uplacen_iznos, datum_naplate)
  Naplata[id_racuna] < Racun[id]

SastojiSeOd(*^id_biljke, *^id_mesavine, kolicina)
  SastojiSeOd[id_biljke] < Biljka[id]
  SastojiSeOd[id_mesavine] < Mesavina[id]

NalaziSe(*^id_mesavine, *^id_narudzbine, kolicina, cena)
  NalaziSe[id_mesavine] < Mesavina[id]
  NalaziSe[id_narudzbine] < Narudzbina[id]

Dobavlja(*^id_biljke, *^id_dobavljaca)
  Dobavlja[id_biljke] < Biljka[id]
  Dobavlja[id_dobavljaca] < Dobavljac[id]

Sadrzi(*^id_biljke, *^id_dobavljaca, kolicina, cena)
  Sadrzi[id_biljke, id_dobavljaca] < Dobavlja[id_biljke, id_dobavljaca]
  Sadrzi[id_dobavljaca] < Nabavka[id_dobavljaca]


```