# UML dijagrami kod klasa podataka 

- kardinalnosti se kod veza u UML dijagramima upisuju u suprotnom smeru nego u odnosu na ER dijagram

- primer klase:

```

----------------
|   STUDENT    |
----------------
| <<pk>> indeks|      <---- primarni kljuc tabele
| - ime        |
| - prezime    |
|              |
----------------

```

- PRIMER VEZE:

```
----------------                                    -------------
|   VOZAC      |                                    |  AUTOBUS  |
----------------                                    -------------
|              |               vozi                 |           |
|              |------------------------------------|           |
|              |  *                         1..1    |           |
|              |                                    |           |
----------------                                    -------------

```

- **KLASE VEZA** - odnosi izmedju objekata sa atributima na vezama

- **TERNARNE VEZE** - 
  - posmatramo za svaki par klasa 
    - MUZICAR i INSTRUMENT , posmatramo TRECU klasu 
    - za svaki konkrtetan par posmatramo 
    - za svaku konkretan par imamo kardinalnost *

- **NASLEDJIVANJE**
  - kod specijalizacija ne navodimo kardinalnost
  
- semantika sadranja
  - **AGREGACIJA**
    - objekat jedne klase predstavlja deo nekog objekta druge klase
    - delovi **mogu** da postoje nezavisno od slozenog objekta
    - romb ne obojen 
      - >automobil sadrzi tockove

  - **KOMPOZICIJA**
    - objekat jedne klase predstavlja deo nekog objekta druge klase 
    - delovi **ne mogu** da postoje nezavisno od slozenog objekta
    - romb je obojen (uvek je na strani 1)
    
- Prevodjenje u relacioni model
  - pomocu tabela, isto kao i u relacionom modelu
  - obrnuti podskupovi, nego u ER dijagramima, jer su kardinalnosti na suprotnim mestima
  - kada imamo vise-vise, pravimo novu tabelu i primarni kljuc je iz obe tabele
  - association class - ne ubacujemo dodatne atribute 
  - ternarne veze se prevode u zasebnu tabelu 
  - prevodimo baznu klasu u zasebnu relaciju, nasledjene klase imaju strani kljuc prema njoj
  - agregaciju prevodimo kao zasebnu tabelu, imace strani kljuc prema klasi koja je sa druge strane dijamanta 
  - kompozicija se prevodi slicno kao 1-1 veza
    - ne prevodimo u zasebnu tabelu

### Izdavacko preduzece

```

Radnik(*jmbg, ime, prezime, staz, struka)

Distributer(*id, naziv, telefon)

Izdavac(*maticni_broj, naziv, adresa, telefon, fax)

Publikacija(*isbn, naziv, tiraz, jezik)

Autor(*id, ime, prezime, telefon, email)

DnevnaNovina(*^isbn_publikacije, izdanje)
  DnevnaNovina[isbn_publikacija] < Publikacija[isbn]

Nedeljnik(*^isbn_publikacije)
  Nedeljnik[isbn_publikacije] < Publikacija[isbn]

PeriodicnoIzdanje(*^isbn_publikacije, tema)
  PeriodicnoIzdanje[isbn_publikacije] < Publikacija[isbn]

Kolumna(*^isbn_nedeljnika, *jedinstveni_broj,naziv, ^id_autora)
  Kolumna[isbn_nedeljnika] < Nedeljnik[isbn_publikacije]  
  Kolumna[id_autora] < Autor[id]

VoziZa(^id_distributera, *^jmbg_radnika)
  VoziZa[id_distributera] < Distributer[id]
  VoziZa[jmbg_radnika] < Radnik[jmbg]

Zaposlen(*^jmbg_radinka, ^maticni_broj_izdavaca)
  Zaposlen[jmbg_radnika] < Radnik[jmbg]
  Zaposlen[maticni_broj_izdavaca] < Izdavac[maticni_broj]

Objavio(*^maticni_broj_izdavaca, *^isbn_publikacije)
  Objavio[maticni_broj_izdavaca] < Izdavac[maticni_broj]
  Objavio[isbn_publikacije] < Publikacija[isbn]


```
 

### Organizovanje muzickih koncerata

```

Koncert(*id_koncerta, naziv, datum, vreme)

Menadzer(*id, ime, prezime, telefon)

Izvodjac(*id, naziv, web, telefon, email)

Album(*id, naziv)

HumanitarniKoncert(*^id_koncerta, ustanova)
  HumanitarniKoncert[id_koncerta] < Koncert[id]

KomercijalniKoncert(*^id_koncerta, ustanova, cena_ulaznice)
  KomercijalniKoncert[id_koncerta] < Koncert[id]

-- agregacija u zasebnu tabelu

AlbumSadrzi(^id_albuma, *^id_pesme)
  AlbumSadrzi[id_albuma] < Album[id] 
  AlbumSadrzi[id_pesme] <  Pesma[id]

Snimio(*^id_izvodjaca, *^id_albuma)
  Snimio[id_izvodjaca] < Izvodjac[id]
  Snimio[id_albuma] < Album[id]

Ugovor(^id_menadzera, *^id_kom_koncerta, *^id_izvodjac, broj, procenat)
  Ugovor[id_menadzera] < Menadzer[id]
  Ugovor[id_kom_koncerta] < KomercijalniKoncert[id_koncerta]
  Ugovor[id_izvodjac] < Izvodjac[id]

Izvedba(*^id_koncerta, *^id_izvodjaca, *^id_pesme, termin)
  Izvedba[id_koncerta] < Koncert[id]
  Izvedba[id_izvodjaca] < Izvodjac[id]
  Izvedba[id_pesme] < Pesma[id]


```