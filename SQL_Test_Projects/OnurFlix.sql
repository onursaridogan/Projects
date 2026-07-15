use OnurFlix

-- Görev 1 (INNER JOIN): Sadece yönetmeni belli olan filmleri ve yönetmen isimlerini listele.
select A.FilmAdi, B.Ad , B.Soyad from Filmler A inner join Yonetmenler B on A.YonetmenID = B.YonetmenID

-- Görev 2 (LEFT JOIN): Bütün filmleri listele; yönetmeni olmayanlarýn (eðer varsa) yanýnda NULL yazsýn.
select * from Filmler A left join Yonetmenler B on A.YonetmenID = B.YonetmenID

-- Görev 3 (RIGHT JOIN): Sistemdeki bütün yönetmenleri listele; bizde henüz filmi olmayan yönetmenlerin (Tarantino) yanýnda NULL yazsýn.
select * from Filmler A right join Yonetmenler B on A.YonetmenID = B.YonetmenID

-- Görev 4 (WHERE + JOIN): 'Türkiye' kökenli yönetmenlerin çektiði filmleri ve yýllarýný getir.
select A.FilmAdi, A.Yil, B.Ad, B.Soyad from Filmler A inner join Yonetmenler B on A.YonetmenID = B.YonetmenID where Ulke = 'Türkiye'

-- Görev 5 (FÝLTRE): 2010 yýlýndan sonra çekilen filmleri ve yönetmenlerini listele.
select A.FilmAdi, A.Yil, B.Ad,B.Soyad from Filmler A inner join Yonetmenler B on A.YonetmenID = B.YonetmenID where A.Yil > 2010

-- Görev 6 (Çift Filtre): Hem 'ABD'li yönetmenlerin çektiði hem de türü 'Bilim Kurgu' olan filmleri listele. (Ýpucu: JOIN + WHERE + AND kullanacaksýn).
select A.FilmAdi, A.Tur, B.Ad, B.Ulke from Filmler A inner join Yonetmenler B on A.YonetmenID = B.YonetmenID where A.Tur = 'Bilim Kurgu' and B.Ulke = 'USA'

-- Görev 7 (Sýralama - ORDER BY): Bütün filmleri ve yönetmenlerini listele ama en yeni film en üstte görünsün. (JOIN + ORDER BY Yil DESC).
select A.FilmAdi, A.Yil, A.Tur, B.Ad, B.Soyad from Filmler A inner join Yonetmenler B on A.YonetmenID = B.YonetmenID order by A.Yil desc

-- Görev 8 (Yalnýz Filmler): Yönetmeni sisteme hiç girilmemiþ (yani YonetmenID'si NULL olan) filmleri LEFT JOIN kullanarak bul. (Ýpucu: WHERE B.YonetmenID IS NULL).
select A.FilmAdi, B.Ad, B.Soyad from Filmler A left join Yonetmenler B on A.YonetmenID = B.YonetmenID where B.YonetmenID is NULL 

-- Görev 9: Sisteme kayýtlý olan ama henüz hiçbir filmi olmayan yönetmenleri bulmaný istiyorum. 
select A.FilmAdi, A.Yil, A.Tur, B.Ad, B.Soyad from Filmler A right join Yonetmenler B on A.YonetmenID = B.YonetmenID where A.FilmID is NULL

-- Görev 10 (Soyadý Avý): Sadece soyadý 'Ceylan' olan yönetmenin çektiði filmleri, bu filmlerin türünü ve yýlýný listele.
select A.FilmAdi,A.Yil,A.Tur,B.Ad,B.Soyad from Filmler A inner join Yonetmenler B on A.YonetmenID = B.YonetmenID where B.Soyad = 'Ceylan' 
