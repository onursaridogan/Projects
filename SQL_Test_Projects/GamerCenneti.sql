use GamerCenneti;

-- Görev A: (Afyonlular): Sadece "Afyonkarahisar" ?ehrindekilerin ad?n? ve soyad?n? getir. 
-- Ba?l?klar "?sim" ve "Soyisim" olsun.
select Ad as '?sim', Soyad as 'Soyisim' 
from Musteriler 
where Sehir = 'Afyonkarahisar';

-- Görev B: (En Yeniler): Kay?t tarihine göre en son gelen 3 ki?iyi listele.
select top 3 * from Musteriler order by KayitTarihi desc;

-- Görev C: (Sat?? Listesi - INNER JOIN): Sadece oyun alm?? mü?terilerin isimlerini ve oyun isimlerini yan yana getir.
select A.Ad, B.OyunAdi 
from Musteriler A 
inner join Siparisler B on A.MusteriID = B.MusteriID;

-- Görev D: (Al??veri? Yapmayanlar - LEFT JOIN): Kay?tl? olan ama bugüne kadar hiç oyun almam?? mü?terileri bul.
select A.Ad, A.Soyad, B.OyunAdi 
from Musteriler A
LEFT JOIN Siparisler B on A.MusteriID = B.MusteriID
where B.OyunAdi IS NULL; -- "Sipari? k?sm?nda oyun ismi yazmayanlar? (bo? olanlar?) getir" demek.

-- Görev E: (Zengin Filtresi - Karma): "?stanbul" ?ehrinde ya?ayan ve fiyat? 1000 TL'den fazla olan bir oyun alanlar? listele.
select A.Ad, B.OyunAdi, B.Fiyat 
from Musteriler A
INNER JOIN Siparisler B on A.MusteriID = B.MusteriID 
where A.Sehir = '?stanbul' AND B.Fiyat >= 1000;