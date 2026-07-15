use Rift_Data;

-- Görev 1 (Mavi Öz Avý): Hangi þampiyonun hangi bölgeden olduðunu listele.

select A.Ad, B.BolgeAdi from Sampiyonlar A inner join Bolgeler B on A.BolgeID = B.BolgeID;

-- Görev 2 (Ionia Baskýný): Sadece 'Ionia' þampiyonlarýný ve bölgelerini getir.

select A.Ad, B.BolgeAdi from Sampiyonlar A inner join Bolgeler B on A.BolgeID = B.BolgeID where B.BolgeAdi = 'Ionia';

-- Görev 3 (Expert Combo - 3'lü JOIN): Þampiyonun Adýný, Bölge Adýný ve Kostüm Adýný tek bir listede göster.

select A.Ad, B.BolgeAdi, C.KostumAdi from Sampiyonlar A inner join Bolgeler B on A.BolgeID = B.BolgeID inner join Kostumler C on A.SampiyonID = C.SampiyonID;

-- Görev 4 (Kostümsüz Garibanlar): Tüm þampiyonlarýn isimlerini ve kostümlerini listele. 
-- Kostümü olmayanlar (Zed, Darius) da listede gözüksün, yanlarýnda NULL yazsýn. (Ýpucu: LEFT JOIN)

select A.Ad, C.KostumAdi from Sampiyonlar A left join Kostumler C on A.SampiyonID = C.SampiyonID

-- Görev 5 (Zorluk Filtresi): Zorluk seviyesi 7 ve üzeri olan þampiyonlarýn isimlerini, 
-- bölgelerini ve kostümlerini getir. (Ýpucu: 3'lü JOIN + WHERE)

select A.Ad, B.BolgeAdi, C.KostumAdi from Sampiyonlar A inner join Kostumler C on A.SampiyonID = C.SampiyonID inner join Bolgeler B on A.BolgeID = B.BolgeID where A.Zorluk >= 7

-- Görev 6 (Bölge Sayýmý): Hangi bölgede kaç tane þampiyon var? 
-- Liste 'BolgeAdi' ve 'Sayi' olarak gözüksün. (Ýpucu: GROUP BY ve COUNT)

select B.BolgeAdi, count(A.SampiyonID) as 'Sayý' from Sampiyonlar A inner join Bolgeler B on A.BolgeID = B.BolgeID group by B.BolgeAdi


-- Görev 7 (En Zorlar): Veritabanýndaki en zor 3 þampiyonun adýný, zorluðunu ve bölgesini 
-- zorluk seviyesi en yüksekten düþüðe doðru getir. (Ýpucu: TOP 3 ve ORDER BY DESC)

select top 3 A.Ad, A.Zorluk, B.BolgeAdi from Sampiyonlar A inner join  Bolgeler B on A.BolgeID = B.BolgeID order by A.Zorluk DESC


-- Görev 8 (Ýsim Arama): Ýsminin içinde 'a' harfi geçen þampiyonlarý ve 
-- bölgelerini listele. (Ýpucu: LIKE '%a%')

select A.Ad, B.BolgeAdi from Sampiyonlar A inner join Bolgeler B on A.BolgeID = B.BolgeID where A.Ad like '%a%'


-- Görev 9 (Kostüm Analizi): Hangi þampiyonun kaç tane kostümü olduðunu bul. 
-- Sadece 1'den fazla kostümü olanlarý göster. (Ýpucu: GROUP BY ve HAVING COUNT > 1)

select A.Ad, count(C.KostumID) as 'KostumSayisi' from Sampiyonlar A inner join Kostumler C on A.SampiyonID = C.SampiyonID group by A.Ad having count(C.KostumID) > 1


-- Görev 10 (Master Final): 'Ionia' bölgesindeki þampiyonlarýn isimlerini ve 
-- toplam kostüm sayýlarýný tek bir tabloda dök.

select A.Ad, count(C.KostumID) as 'KostumSayisi' from Sampiyonlar A inner join Kostumler C on A.SampiyonID = C.SampiyonID where A.BolgeID = 1 group by A.Ad

