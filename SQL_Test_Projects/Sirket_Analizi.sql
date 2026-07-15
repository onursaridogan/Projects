use Sirket_Analizi
-- Görev 1 (CASE WHEN Isýnma): Ürünlerin adýný ve stok durumunu getir. Stok 0 ise 'Tükendi', 1-5 arasý ise 'Kritik Seviye', daha fazlasý ise 'Stok Sorunu Yok' yazsýn.

select 
    UrunAdi, 
    Stok,
    case 
        when Stok = 0 then 'Tükendi'
        when Stok <= 5 then 'Kritik Seviye'
        else 'Stok Sorunu Yok'
    end as 'Stok_Durumu'
    from Urunler


-- Görev 2 (JOIN & CASE WHEN): Her müþterinin adýný, aldýðý ürünün adýný ve ödediði toplam parayý getir. Yanýna bir sütun daha ekle; eðer toplam ödeme 50.000 TL üstü ise 'VIP Müþteri', deðilse 'Standart Müþteri' yazsýn.
select A.Ad, B.UrunAdi, C.Adet * B.Fiyat as 'Toplam Para',
case 
    when (C.Adet * B.Fiyat) > 50000 then 'VIP Müþteri' 
    else 'Standart Müþteri' 
end as 'Müþteri Statüsü' 
from Satislar C inner join Musteriler A on C.MusteriID = A.MusteriID inner join Urunler B on C.UrunID = B.UrunID

-- Görev 3 (LIKE & ORDER BY): Þehri 'Ýstanbul' olan veya adýnýn içinde 'e' harfi geçen müþterilerin yaptýðý alýþveriþleri, en yeni tarihten en eski tarihe göre sýralayarak getir.










-- Görev 3 (LIKE & ORDER BY): Þehri 'Ýstanbul' olan veya adýnýn içinde 'e' harfi geçen müþterilerin yaptýðý alýþveriþleri, en yeni tarihten en eski tarihe göre sýralayarak getir.

-- Görev 4 (MASTER KOMBO): Bütün tablolarý JOIN ile birleþtir. Müþteri Adý, Ürün Adý, Kategori Adý ve Toplam Tutarý listele. Sadece toplam tutarý, tüm satýþlarýn ortalama tutarýndan yüksek olanlarý getir (Subquery kullan).