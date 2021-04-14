-- Zad1
CREATE TABLE Koty (
pseudo VARCHAR2(15)
    CONSTRAINT p_pk PRIMARY KEY,
plec CHAR(1) 
    CONSTRAINT k_plec_nn NOT NULL
    CONSTRAINT k_plec_ch CHECK(plec IN ('K','M')),
w_stadku_od DATE 
    CONSTRAINT k_dat_nn NOT NULL,
przydzial_myszy NUMBER(4)
    CONSTRAINT k_pm_nn NOT NULL 
    CONSTRAINT k_pw_d CHECK (przydzial_myszy >= 0), 
nr_bandy NUMBER(2),
funkcja VARCHAR2(15)
    CONSTRAINT k_f_fk REFERENCES Funkcje(nazwa_funkcji),
pseudo_szefa VARCHAR2(15)
    CONSTRAINT k_ps_fk REFERENCES Koty(pseudo)
);
        
CREATE TABLE Funkcje(
nazwa_funkcji VARCHAR2(15) 
    CONSTRAINT f_nf_pk PRIMARY KEY, 
min_myszy NUMBER(4)
    CONSTRAINT f_mim_nn NOT NULL
    CONSTRAINT f_mim_d CHECK (min_myszy >= 0),
max_myszy NUMBER(4)
    CONSTRAINT f_mam_nn NOT NULL
    CONSTRAINT f_mam_d CHECK(max_myszy >= 0),
CONSTRAINT f_mm CHECK(max_myszy>=min_myszy)
);
      
CREATE TABLE Wrogowie(
imie_wroga VARCHAR2(15)
    CONSTRAINT w_iw_pk PRIMARY KEY,
stopien_wrogosci NUMBER(2)
    CONSTRAINT w_sw_nn NOT NULL
    CONSTRAINT w_sw_1 CHECK (stopien_wrogosci>0)
    CONSTRAINT w_sw_10 CHECK (stopien_wrogosci<11),
gatunek VARCHAR2(15)
    CONSTRAINT w_g_nn NOT NULL
);

CREATE TABLE Gratyfikacje(
nazwa VARCHAR2(15) 
    CONSTRAINT g_n_pk PRIMARY KEY
);

CREATE TABLE Bandy(
nr_bandy NUMBER(2)
    CONSTRAINT b_nrb_pk PRIMARY KEY
    CONSTRAINT b_nrb_0 CHECK (nr_bandy > 0),
teren VARCHAR2(15)
    CONSTRAINT b_t_nn NOT NULL,
nazwa_bandy VARCHAR2(15)
    CONSTRAINT b_nb_nn NOT NULL,
pseudo_szefa VARCHAR2(15) 
    CONSTRAINT b_ps_fk REFERENCES Koty(pseudo)
);


CREATE TABLE Incydenty(
opis_incydentu VARCHAR2(30)
    CONSTRAINT i_oi_nn NOT NULL, 
data_incydentu DATE 
    CONSTRAINT i_di_nn NOT NULL,
pseudo_kota VARCHAR2(15)
    CONSTRAINT i_pk_fk REFERENCES Koty(pseudo),
imie_wroga VARCHAR2(15)
    CONSTRAINT i_iw_fk REFERENCES Wrogowie(imie_wroga),
CONSTRAINT i_pk PRIMARY KEY (pseudo_kota, imie_wroga)
);

CREATE TABLE Myszy(
nr_myszy NUMBER(9) 
    CONSTRAINT m_nrm_pk PRIMARY KEY
    CONSTRAINT m_nm_0 CHECK (nr_myszy > 0),
data_upolowania DATE
    CONSTRAINT m_du_nn NOT NULL,
data_wydania DATE,
waga NUMBER(3)
    CONSTRAINT m_w_nn NULL
    CONSTRAINT m_w_10 CHECK(waga > 10),
dlugosc NUMBER(3)
    CONSTRAINT m_d_nn NULL
    CONSTRAINT m_d_10 CHECK(dlugosc > 5),
pseudo_lapacza VARCHAR2(15)
    CONSTRAINT m_pl_nn NOT NULL
    CONSTRAINT m_pl_fk REFERENCES Koty(pseudo),
pseudo_zjadacza VARCHAR2(15)
    CONSTRAINT m_pz_fk REFERENCES Koty(pseudo),
CONSTRAINT m_dudw CHECK (Data_upolowania <= Data_wydania)
);

CREATE TABLE Bierze(
imie_wroga VARCHAR2(15) 
    CONSTRAINT b_iw_fk REFERENCES Wrogowie(imie_wroga),
gratyfikacja VARCHAR2(15)
    CONSTRAINT b_g_fk REFERENCES Gratyfikacje(nazwa),
CONSTRAINT b_pk PRIMARY KEY (imie_wroga, gratyfikacja)
);

ALTER TABLE Koty
ADD CONSTRAINT k_nrb_fk
FOREIGN KEY (nr_bandy) REFERENCES bandy(nr_bandy);

--Zad2

ALTER SESSION SET NLS_DATE_FORMAT = 'DD.MM.YYYY';

INSERT INTO Funkcje VALUES('szef_stada','100','200');
INSERT INTO Funkcje VALUES('szef_bandy','75','100');
INSERT INTO Funkcje VALUES('zastepca_szefa','60','75');
INSERT INTO Funkcje VALUES('zwiadowca','50','60');
INSERT INTO Funkcje VALUES('stru¿','35','50');
INSERT INTO Funkcje VALUES('starszy_³apacz','30','35');
INSERT INTO Funkcje VALUES('³apacz','25','30');
INSERT INTO Funkcje VALUES('uczen','20','25');
INSERT INTO Funkcje VALUES('nowicjusz','10','20');

INSERT INTO Gratyfikacje VALUES('Gratyfikacja');
INSERT INTO Gratyfikacje VALUES('Mysz');
INSERT INTO Gratyfikacje VALUES('Koœæ');
INSERT INTO Gratyfikacje VALUES('Cukierek');
INSERT INTO Gratyfikacje VALUES('Kwiatek');
INSERT INTO Gratyfikacje VALUES('Miêso');
INSERT INTO Gratyfikacje VALUES('Jajko');

INSERT INTO Wrogowie VALUES('Kacperek','4','Cz³owiek');
INSERT INTO Wrogowie VALUES('Burek','6','Pies');
INSERT INTO Wrogowie VALUES('Czarny_kie³','9','Pies');
INSERT INTO Wrogowie VALUES('Podstepnik','10','Kot');
INSERT INTO Wrogowie VALUES('Chytrus','8','Lis');
INSERT INTO Wrogowie VALUES('Jagna','6','Kuna');
INSERT INTO Wrogowie VALUES('Pani_Jadzia','10','Cz³owiek');
INSERT INTO Wrogowie VALUES('Jojo','8','Pies');
INSERT INTO Wrogowie VALUES('Bartek','5','Cz³owiek');
INSERT INTO Wrogowie VALUES('Stefan','8','Kot');

INSERT INTO Bierze VALUES('Kacperek','Cukierek');
INSERT INTO Bierze VALUES('Burek','Koœæ');
INSERT INTO Bierze VALUES('Czarny_kie³','Koœæ');
INSERT INTO Bierze VALUES('Pani_Jadzia','Kwiatek');
INSERT INTO Bierze VALUES('Czarny_kie³','Miêso');
INSERT INTO Bierze VALUES('Jagna','Jajko');
INSERT INTO Bierze VALUES('Podstepnik','Mysz');
INSERT INTO Bierze VALUES('Chytrus','Miêso');
INSERT INTO Bierze VALUES('Jojo','Miêso');
INSERT INTO Bierze VALUES('Podstepnik','Miêso');
INSERT INTO Bierze VALUES('Bartek','Cukierek');

ALTER TABLE Koty
DROP CONSTRAINT k_nrb_fk;

INSERT INTO Koty VALUES('Tygrys','M','24.09.1999','100',NULL,'szef_stada',NULL);
INSERT INTO Koty VALUES('Zabka','K','01.01.2000','90','1','szef_bandy','Tygrys');
INSERT INTO Koty VALUES('Rudy','M','01.01.2000','83','2','szef_bandy','Tygrys');
INSERT INTO Koty VALUES('Joker','M','28.03.2001','88','3','szef_bandy','Tygrys');
INSERT INTO Koty VALUES('M³ody','M','15.10.2005','76','4','szef_bandy','Tygrys');
INSERT INTO Koty VALUES('Czarna','K','27.08.2004','75','2','zastepca_szefa','Rudy');
INSERT INTO Koty VALUES('Szybka','K','25.02.2007','73','1','zastepca_szefa','Zabka');
INSERT INTO Koty VALUES('Puszek','M','23.09.2007','70','4','zastepca_szefa','M³ody');
INSERT INTO Koty VALUES('Klakier','M','27.03.2018','65','3','zastepca_szefa','Joker');
INSERT INTO Koty VALUES('Mruczek','M','25.09.2009','55','1','zwiadowca','Szybka');
INSERT INTO Koty VALUES('PanKot','M','17.04.2002','57','2','zwiadowca','Czarna');
INSERT INTO Koty VALUES('Puma','K','11.03.2010','45','2','stru¿','PanKot');
INSERT INTO Koty VALUES('Landrynka','K','03.11.2012','49','4','stru¿','Puszek');
INSERT INTO Koty VALUES('Mamba','K','28.02.2013','55','3','zwiadowca','Klakier');
INSERT INTO Koty VALUES('Kula','M','05.07.2015','32','1','starszy_³apacz','Mruczek');
INSERT INTO Koty VALUES('Pazur','M','16.09.2016','31','2','starszy_³apacz','Puma');
INSERT INTO Koty VALUES('Simba','M','24.01.2017','35','4','starszy_³apacz','Landrynka');
INSERT INTO Koty VALUES('Zo³za','K','07.06.2018','22','3','uczen','Mamba');
INSERT INTO Koty VALUES('Leo','M','06.02.2020','15',NULL,'nowicjusz','Kula');

INSERT INTO Bandy VALUES('1','Podworko','Koty_ninja','Zabka');
INSERT INTO Bandy VALUES('2','Dom','Wymiatacze','Rudy');
INSERT INTO Bandy VALUES('3','Stodo³a','Nocni_³owcy','Joker');
INSERT INTO Bandy VALUES('4','£¹ka','Wataha','M³ody');

ALTER TABLE Koty
ADD CONSTRAINT k_nrb_fk
FOREIGN KEY (nr_bandy) REFERENCES bandy(nr_bandy);

INSERT INTO Incydenty VALUES('Podrapanie','29.03.2019','Zabka','Chytrus');
INSERT INTO Incydenty VALUES('Zabranie_myszy','11.11.2017','Landrynka','Stefan');
INSERT INTO Incydenty VALUES('Ugryzienie','18.03.2011','Puma','Jojo');
INSERT INTO Incydenty VALUES('Szczekanie','14.02.2018','Klakier','Burek');
INSERT INTO Incydenty VALUES('Atak_miot³¹','30.06.2017','Zo³za','Pani_Jadzia');
INSERT INTO Incydenty VALUES('Wtargniêcie_do_domu','06.07.2005','Mamba','Jagna');
INSERT INTO Incydenty VALUES('Ci¹gniêcie_za_ogon','27.08.2003','Leo','Kacperek');
INSERT INTO Incydenty VALUES('Kopniêcie','16.12.2018','Joker','Bartek');
INSERT INTO Incydenty VALUES('Gonienie','28.07.2004','M³ody','Czarny_kie³');
INSERT INTO Incydenty VALUES('Próba_oszustwa','17.05.2002','Tygrys','Podstepnik');
INSERT INTO Incydenty VALUES('Obraza','17.05.2012','Zabka','Podstepnik');
INSERT INTO Incydenty VALUES('Atak','11.02.2014','Kula','Podstepnik');
INSERT INTO Incydenty VALUES('Rabunek','07.06.2003','Joker','Podstepnik');

INSERT INTO Myszy VALUES('1','02.00.2020','10.02.2002','43','23','Leo','Puma');
INSERT INTO Myszy VALUES('2','29.02.2016','11.01.2017','17','13','M³ody','Leo');
INSERT INTO Myszy VALUES('3','12.12.2011','28.10.2014','27','11','Leo','¯abka');
INSERT INTO Myszy VALUES('4','15.12.2005','22.00.2017','22','25','Mamba','Puszek');
INSERT INTO Myszy VALUES('5','20.01.2007','19.02.2018','48','9','Mamba','Joker');
INSERT INTO Myszy VALUES('6','26.12.2007','14.11.2002','29','13','Zo³za','Joker');
INSERT INTO Myszy VALUES('7','16.11.2009','00.01.2016','21','12','Rudy','Szybka');
INSERT INTO Myszy VALUES('8','20.01.2007','17.02.2016','49','15','Mruczek','Szybka');
INSERT INTO Myszy VALUES('9','11.00.2004','08.00.2006','33','12','¯abka','Landrynka');
INSERT INTO Myszy VALUES('10','20.00.2004','13.02.2020','29','20','Klakier','Simba');
INSERT INTO Myszy VALUES('11','03.12.2020','23.10.2009','32','18','Klakier','Pazur');
INSERT INTO Myszy VALUES('12','10.00.2012','18.10.2005','28','12','Puszek','Klakier');
INSERT INTO Myszy VALUES('13','03.12.2014','18.00.2005','31','22','Puma','Rudy');
INSERT INTO Myszy VALUES('14','13.11.2012','08.01.2009','17','14','Tygrys','Puszek');
INSERT INTO Myszy VALUES('15','26.02.2016','07.01.2005','24','8','Joker','Klakier');
INSERT INTO Myszy VALUES('16','15.00.2018','24.12.2008','31','19','Puma','Klakier');
INSERT INTO Myszy VALUES('17','12.10.2015','01.11.2006','21','6','Mamba','Czarna');
INSERT INTO Myszy VALUES('18','17.02.2002','13.11.2000','24','11','¯abka','Zo³za');
INSERT INTO Myszy VALUES('19','15.02.2016','06.00.2010','12','10','Puma','¯abka');
COMMIT
 --Zad3

--1.1 Wyœwietl ranking najlepszych lowcow pod wzgledem wagi zlapanych myszy 
SELECT pseudo_lapacza "Lapacz", SUM(waga) "waga_zlapanych_myszy"
FROM Myszy
GROUP BY pseudo_lapacza
ORDER BY SUM(waga) DESC

--1.2 Wyswietl pseudo kotow ktore dolaczyly do stada po 01.01.2010 roku

SELECT pseudo
FROM Koty
WHERE w_stadku_od > '01.01.2010'

--1.3 Okresl o ile maksymalnie moze roznic sie przydzial myszy w ramach danej funkcji  
SELECT nazwa_funkcji, (max_myszy-min_myszy) "Roznica"
FROM Funkcje

--2.1 Wyœwietl informacje o badach: nr bandy, nazwa bandy, pseudo szefa i ilosc jej czlonkow
SELECT nr_bandy, nazwa_bandy, B.pseudo_szefa, COUNT(nr_bandy) "ilosc_czlonkow"
FROM Bandy B JOIN Koty K USING (nr_bandy)
GROUP BY nr_bandy, nazwa_bandy, B.pseudo_szefa


--2.2 Wyœwietl najbardziej wrogi gatunek pod wzgledem liczby incdyentow z danym gatunkiem 
SELECT gatunek, COUNT(gatunek)
FROM Incydenty I JOIN  Wrogowie W USING (imie_wroga)
GROUP BY gatunek
ORDER BY COUNT(gatunek) DESC

--2.3 Wyswietl ile myszy zjadla kazda banda
SELECT nr_bandy, COUNT(nr_bandy) "ile myszys zjedli"
FROM Myszy M INNER JOIN Koty K ON (M.pseudo_zjadacza = K.pseudo)
WHERE nr_bandy IS NOT NULL
GROUP BY nr_bandy

--2.4 Wyswietl koty ktore nie braly udzialu w zadnym incydencie 
SELECT K.pseudo
FROM Koty K LEFT JOIN Incydenty I ON (I.pseudo_kota = K.pseudo)
WHERE opis_incydentu IS NULL

--3.1  Wyswietl incydenty w ktorych bral udzial wrog o najwyzszym stopniu wrogosci
SELECT *
FROM Incydenty 
WHERE imie_wroga IN (SELECT imie_wroga
                      FROM wrogowie 
                      WHERE (stopien_wrogosci = (SELECT MAX(stopien_wrogosci)
                                                 FROM Wrogowie)))
--3.2 Wyswietl numery myszy zjedzonych przez szefow band
SELECT nr_myszy
FROM myszy
WHERE pseudo_zjadacza IN (SELECT pseudo
                        FROM Koty
                        WHERE (funkcja = 'szef_bandy'))


--3.3 Wyswietl najlepszych lapaczy w bandzie nr 1 pod wzgledem ilosci zlapanych myszy
 
SELECT pseudo_lapacza, COUNT(nr_myszy) "Zlapane mysz"
FROM myszy M INNER JOIN Koty K ON (M.pseudo_lapacza = K.pseudo)
WHERE nr_bandy='1' 
HAVING COUNT(nr_myszy) = (SELECT MAX(COUNT(nr_myszy))
                        FROM myszy M INNER JOIN Koty K ON (M.pseudo_lapacza = K.pseudo)
                        WHERE nr_bandy='1' 
                        GROUP BY pseudo_lapacza)
GROUP BY pseudo_lapacza,nr_bandy
        
        

