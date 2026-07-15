use Fit_Yasam;

-- Görev A: Tüm üyelerin ad?n? ve paket tipini listele.
select AdSoyad from Uyeler;

-- Görev B: Ya?? 30'dan büyük olan üyeleri bul.
select * from Uyeler where Yas > 30;

-- Görev C: Borcu olan (Borcu 0'dan büyük olan) üyelerin listesini getir ki aray?p hat?rlatal?m.
select * from Uyeler where Borc > 0;

-- Görev D: Ay?e Demir borcunu ödedi! Ay?e'nin borcunu 0 TL yap.
update Uyeler set Borc = 0 where AdSoyad = 'Ay?e Demir';

-- Görev E: Mehmet Can çok disiplinli ç?kt?, paketini 'Bronz'dan 'Gold'a yükselt.
update Uyeler set PaketTipi = 'Gold' where AdSoyad = 'Mehmet Can';

-- Görev F: Caner Öz ba?ka ?ehre ta??nd?. Caner'in kayd?n? sistemden tamamen sil.
delete from Uyeler where AdSoyad = 'Caner Öz';

-- Görev G: Hem 'Gold' paketi olan hem de borcu bulunan üyeleri tek bir listede bul.
select * from Uyeler where PaketTipi = 'Gold' and Borc > 0;

-- Görev H: Ya?? 20 ile 30 aras?nda olan (20 ve 30 dahil) ve 'Silver' paketi kullanan üyeleri listele.
select * from Uyeler where Yas between 20 and 30 and PaketTipi = 'Silver';

-- Görev I: ?sminin içinde 'Ay?e' geçen üyeleri bul. 
select * from Uyeler where AdSoyad like '%Ay?e%';

-- Görev J: Enflasyon güncellemesi! 'Bronz' paket sahiplerinin borcuna %10 faiz ekle.
update Uyeler set Borc = Borc * 1.1 where PaketTipi = 'Bronz';

-- Görev K: Paketi 'Gold' OLMAYAN ama borcu 500 TL'den fazla olan üyeleri listele.
select * from Uyeler where PaketTipi != 'Gold' AND Borc > 500; -- "!=" e?it de?ildir demektir.

-- Görev L: Ya?? 40'tan büyük VE borcu 0 olan üyeleri sistemden sil.
delete from Uyeler where Yas > 40 and Borc = 0;