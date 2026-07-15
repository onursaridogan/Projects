use BakkalAmca;

-- Görev A: (Listeleme): Bakkaldaki her ?eyin ad?n? ve fiyat?n? ekranda gör.
select * from Urunler;

-- Görev B: (Azalanlar? Bul): Stok adedi 10'un alt?na dü?mü? olan ürünleri (Süt ve Cips gibi) c?mb?zla çek.
select UrunAdi, StokAdedi from Urunler where StokAdedi < 10;

-- Görev C: (Ucuzluk): Fiyat? 20 TL'den az olan ürünleri listele.
select UrunAdi, Fiyat from Urunler where Fiyat < 20;

-- Görev D: Ekmek fiyat? zamland?! Sadece Ekmek sat?r?n? bul ve fiyat?n? 12 TL yap.
update Urunler set Fiyat = 12 where UrunAdi = 'Ekmek';

-- Görev E: Stoklar tazelendi! Süt miktar?n? 5'ten 20'ye ç?kar.
update Urunler set StokAdedi = 20 where UrunAdi = 'Sut';

-- Görev F: Cipslerin tarihi geçmi?! Cips sat?r?n? tablodan tamamen sil.
delete from Urunler where UrunAdi = 'Cips';

------------------------------------------------------ JOINS (BAKKAL AMCA) ---------------------------------------------------------------

-- 1. INNER JOIN (Sadece E?le?enler) 
-- Mant?k: "Bana hem ürünü olan hem de reyonu belli olanlar? getir." 
-- Sak?z?n reyonu belli de?il, Temizlik reyonunda da ürün yok. O yüzden ikisi de listede gözükmez.

select Urunler.UrunAdi, Kategoriler.KategoriAdi 
from Urunler 
inner join Kategoriler on Urunler.KategoriID = Kategoriler.KategoriID;

-- 2. LEFT JOIN (Tüm Ürünler Gelsin) 
-- Mant?k: "Bakkaldaki bütün ürünleri listele. Reyonu varsa yan?na yaz, yoksa (Sak?z gibi) bo? kals?n."
-- Burada sol taraf (ilk yaz?lan tablo) Urunler oldu?u için hiçbir ürün listeden dü?mez.

select Urunler.UrunAdi, Kategoriler.KategoriAdi 
from Urunler 
left join Kategoriler on Urunler.KategoriID = Kategoriler.KategoriID;

-- 3. RIGHT JOIN (Tüm Reyonlar Gelsin) 
-- Mant?k: "Bakkaldaki bütün reyonlar? listele. ?çinde ürün varsa yan?na yaz, bo?sa (Temizlik reyonu gibi) bo? kals?n."
-- Burada sa? taraf Kategoriler oldu?u için tüm reyonlar listelenir.

select Urunler.UrunAdi, Kategoriler.KategoriAdi 
from Urunler 
right join Kategoriler on Urunler.KategoriID = Kategoriler.KategoriID;

-------------------------------------------------------------------------------------------------------------------------------------------

-- Neden ON Yaz?yoruz?
-- Dikkat ettiysen her kodun sonunda "ON Urunler.KategoriID = Kategoriler.KategoriID" yazd?k. 
-- Bu, SQL'e verdi?imiz ?u talimatt?r:
-- "Bak SQL, bu iki tabloyu birbirine KategoriID numaralar? üzerinden yap??t?r. 10 numaray? 10 numarayla e?le?tir!"