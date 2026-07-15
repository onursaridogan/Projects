use JetGaleri;

-- Görev 1: Galerideki tüm arabalar?n markas?n?, modelini ve fiyat?n? listele.
select Marka, Model, Fiyat from Arabalar;

-- Görev 2: Sadece 2020 y?l?ndan sonra üretilmi? (yeni) arabalar? bul.
select * from Arabalar where Yil > 2020;

-- Görev 3: Elimizde hala Sat?l?k olan arabalar hangileri? Onlar? getir.
select * from Arabalar where Durum = 'SATILIK';

-- Görev 4: Arabalar? fiyata göre pahal?dan ucuza do?ru s?rala. (?pucu: ORDER BY ... DESC)
select * from Arabalar order by Fiyat desc;

-- Görev 5: Mercedes'e zam geldi! Fiyat?n? 3.800.000 TL olarak güncelle.
update Arabalar set Fiyat = 3800000 where Marka = 'Mercedes-Benz';

-- Görev 6: Müjde, Fiat Egea sat?ld?! Durumunu 'Sat?ld?' olarak de?i?tir.
update Arabalar set Durum = 'SATILDI' where Marka = 'Fiat';

-- Görev 7: Galerimiz art?k sadece yeni model arabalar satacak. 
-- 2016 y?l?ndan eski olan arabalar? sistemden tamamen sil.
delete from Arabalar where Yil < 2016;