use Saat_Merkezi

-- Görev 1: Segment Belirleme (Fiyat Analizi) Saatlerin markasını ve fiyatını getir. Yanına "Segment" diye bir sütun ekle.
-- Eğer fiyatı 10.000'den büyükse Lüks yaz küçük eşitse Premium yaz diğerlerine de Giriş Seviyesi yaz.

select 
    Marka, 
    Model, 
    Fiyat,
    case 
        when Fiyat > 100000 then 'Lüks'
        when Fiyat >= 10000 then 'Premium'
        else 'Giriş Seviyesi'
    end as 'Segment'
from Saatler;

-- Görev 2: Kordon Değerlendirmesi (Metin Kontrolü) Markayı ve kordon tipini getir.
-- Soru: Markayı ve kordon tipini getir. Yanına "Kullanım Tarzı" diye bir sütun ekle.
--Kural: Eğer kordon tipi 'Çelik' ise yanına 'Ağır ve Klasik' yazsın.
--Kural 2: Diğer her şey için (Plastik, Bioceramic vs.) 'Hafif ve Spor' yazsın.

select 
    Marka,
    KordonTipi,
    case
        when KordonTipi = 'Çelik' then 'Ağır ve Klasik'
        else 'Plastik, Bioceramic vs.'
    end as 'Kullanım Tarzı'
from saatler;

-- Görev 3: Satış Alarmı (Karma Mantık) Ürün adını ve stoğunu getir.
-- Bu sefer stok takibi yapıyoruz. Patron diyor ki: "Bana sayı verme, durum bildir!"
-- Soru: Markayı, Modeli ve Stoğu getir. Yanına "Satış_Aksiyonu" diye bir sütun ekle.
-- Markayı, Modeli ve Stoğu getir. Yanına "Satış_Aksiyonu" diye bir sütun ekle.
-- Kural 1: Stok 0 ise -> 'Sipariş Geç' yazsın.
-- Kural 2: Stok 10'dan az ise -> 'Vitrine Koy (Azaldı)' yazsın.
-- Kural 3: Diğerleri için -> 'Depoda Beklesin' yazsın.
select 
    Marka,
    Model,
    Stok,
    case
        when Stok = 0 then 'Sipariş Geç'
        when Stok < 10 then 'Vitrine Koy (Azaldı)'
        else 'Depoda beklesin'
    end as 'Satış Aksiyonu'
    from saatler;
        
    
-- Görev 1: Marka Klasmanı (Metin Gruplama)
-- Patron diyor ki: "Bana markaların hangi grupta olduğunu gösteren bir liste çıkar."
-- Kural: * Eğer Marka 'Rolex' veya 'Seiko' veya 'Tissot' ise -> 'Mekanik Devler' yazsın.
-- Eğer Marka 'Casio' veya 'Swatch' ise -> 'Dijital/Moda' yazsın.

select 
    Marka,
    case
        when Marka = 'Rolex' or Marka = 'Seiko' or Marka = 'Tissot' then 'Mekanik Devler'
        when Marka = 'Casio' or Marka = 'Swatch' then 'Dijital/Moda'
    end as 'Marka Klasmanı'
    from saatler;


-- Görev 2: Toplam Stok Değeri Analizi (Hesaplama + CASE)Burada biraz matematik kasacağız. 
-- Bir ürünün toplam değerini ($Fiyat \times Stok$) hesapla ve ona göre yorum yap.
-- Kural: * Toplam değer (Fiyat * Stok) 50.000 TL'den fazlaysa -> 'Yüksek Yatırım'Değilse -> 'Normal Stok' yazsın.Neyi Öğreniyoruz?: CASE içinde çarpma işlemi yapıp sonuca göre etiket basmayı.

select 
    Marka,
    Model,
    Fiyat,
    Stok,
    case
        when (Fiyat * Stok) > 50000 then 'Yüksek Yatırım'
        else 'Normal Stok'
    end as 'Yatırım Durumu'
    from saatler;


-- Görev 3: Karma Durum Raporu (Çoklu Filtre)Hem stoğa hem kordona bakacağız.
-- Kural: * Stok 0 ise -> 'Acil Temin Edilmeli'
-- Stok 0 değilse ve KordonTipi 'Çelik' ise -> 'Satışa Hazır Klasik'
-- Geri kalan her şey için -> 'Spor Satışa Hazır' yazsın.

select 
    Marka,
    Model,
    Stok,
    KordonTipi,
    case
        when Stok = 0 then 'Acil Temin Edilmeli!'
        when Stok != 0 and KordonTipi = 'Çelik' then 'Satışa Hazır Klasik'
        else 'Spor Satışa Hazır'
    end as 'Karma Durum Raporu'
    from saatler;


-- Soru: Marka, Model ve Mevcut Fiyatı (Fiyat) getir. Yanına 'Güncel_Fiyat' ve 'Fiyat_Aksiyonu' diye iki farklı CASE sütunu ekle.
-- 1. Sütun (Güncel_Fiyat) Kuralları:Eğer Marka 'Casio' ise -> Fiyata %10 indirim yap. 
-- ($Fiyat \times 0.90$)Eğer Marka 'Rolex' ise -> Fiyata %20 zam yap. ($Fiyat \times 1.20$)
-- Diğer markaların fiyatı aynı kalsın.


select 
    Marka, 
    Model, 
    Fiyat,
    -- BİRİNCİ SÜTUN (Fiyat Hesaplama)
    case 
        when Marka = 'Casio' then Fiyat * 0.90
        when Marka = 'Rolex' then Fiyat * 1.20
        else Fiyat
    end as 'Güncel Fiyat', -- Araya virgül şart!
    
    -- İKİNCİ SÜTUN (Durum Bildirme)
    case 
        when Marka = 'Casio' then 'Kampanyalı Ürün'
        when Marka = 'Rolex' then 'Lüks Artışı'
        else 'Sabit Fiyat'
    end as 'Fiyat Aksiyonu'
from saatler;



-- Patron diyor ki: "Müşterilerimize hangi saati nerede takmaları gerektiğini söyleyen bir rapor lazım."
-- Soru: Marka, Model ve KordonTipi bilgilerini getir. Yanına 'Kullanım_Alanı' diye bir sütun ekle.
-- Kurallar:

-- Eğer Marka 'Rolex' ise -> 'Özel Davetler/Yatırım' yazsın.

-- Eğer Fiyat 5.000 TL'den büyük VE KordonTipi 'Çelik' ise -> 'İş Toplantısı/Şık' yazsın.

-- Eğer KordonTipi 'Plastik' VEYA 'Bioceramic' ise -> 'Günlük/Sportif' yazsın.

-- Geri kalan her şey için -> 'Genel Kullanım' yazsın.


select 
    Marka,
    Model,
    Fiyat,
    KordonTipi,
    case
        when Marka = 'Rolex' then 'Özel Davetler / Yatırım'
        when Fiyat > 5000 and KordonTipi = 'Çelik' then 'İş Toplantısı / Şık' 
        when KordonTipi = 'Plastik' or KordonTipi = 'Bioceramic' then 'Günlük / Sportif'
        else 'Genel Kullanım'
    end as 'Kullanım Alanı'
from saatler;


-- Soru: Saatler (A) ve MarkaDetay (B) tablolarını Marka sütunu üzerinden birleştir. Marka, Model ve Mensei (Ülke) bilgilerini getir. Yanına da 'Saatçilik_Ekolü' diye bir sütun ekle.
-- Kurallar:
-- Eğer Mensei 'İsviçre' ise -> 'Avrupa Geleneksel' yazsın.
-- Eğer Mensei 'Japonya' ise -> 'Asya Teknoloji' yazsın.
-- Geri kalanlar için -> 'Diğer' yazsın.

select 
    A.Marka, 
    A.Model, 
    B.Mensei,
    case 
        when B.Mensei = 'İsviçre' then 'Avrupa Geleneksel'
        when B.Mensei = 'Japonya' then 'Asya Teknoloji'
        else 'Diğer'
    end as 'Saatçilik Ekolü'
from Saatler A inner join MarkaDetay B on A.Marka = B.Marka;




-- Soru: Saatler (A) ve MarkaDetay (B) tablolarını Marka üzerinden birleştir. Marka, Model, Fiyat ve Mensei (Ülke) bilgilerini getir. Yanına da 'Satis_Stratejisi' diye bir sütun ekle.
-- Kurallar:
-- Eğer Mensei 'İsviçre' ise VE Fiyat 20.000 TL'den büyük ise -> 'Lüks İhracat' yazsın.
-- Eğer Mensei 'Japonya' ise VE Fiyat 10.000 TL'den büyük ise -> 'Premium Teknoloji' yazsın.
-- Diğer tüm durumlar için -> 'Standart Pazarlama' yazsın.

select 
    A.Marka,
    A.Model,
    A.Fiyat,
    B.Mensei,
    case
        when B.Mensei = 'İsviçre' and A.Fiyat > 20000 then 'Lüks İhracat'
        when B.Mensei = 'Japonya' and A.Fiyat > 10000 then 'Premium Teknoloji'
        else 'Standart Pazarlama'
    end as 'Satış Stratejisi'
from saatler A inner join MarkaDetay B on A.Marka = B.Marka; 


-- Soru: Saatler (A) ve MarkaDetay (B) tablolarını birleştir. Marka, Model, Mensei ve Stok bilgilerini getir. Yanına 'Lojistik_Önceliği' diye bir sütun ekle.
-- Kurallar:
-- Eğer Mensei 'İsviçre' ise VE Stok 5'ten az ise -> 'Uçakla Acil Sevkiyat' yazsın.
-- Eğer Mensei 'Japonya' ise VE Stok 10'dan fazla ise -> 'Deniz Yolu/Beklemede' yazsın.
-- Eğer Marka 'Rolex' ise (stok ne olursa olsun) -> 'Özel Zırhlı Kurye' yazsın. (İpucu: Bu kuralı en üste yazarsan daha garanti olur)
-- Geri kalan her şey için -> 'Standart Kargo' yazsın.

select 
    A.Marka,
    A.Model,
    A.Stok,
    B.Mensei,
    case
        when A.Marka = 'Rolex' then 'Özel Zırhlı Kurye' 
        when B.Mensei = 'İsviçre' and A.Stok < 5 then 'Uçakla Acil Sevkiyat'
        when B.Mensei = 'Japonya' and A.Stok > 10 then 'Deniz Yolu / Beklemede'
        else 'Standart Kargo'
    end as 'Lojistik Önceliği'
from saatler A inner join MarkaDetay B on A.Marka = B.Marka;



------------------------------------------------------------------- GROUP BY -------------------------------------------------------------------------------



-- Görev 1: Ülke Bazlı Envanter Özeti
-- Hadi ısınma turuyla başlayalım. Yine o iki tablomuzu (Saatler A ve MarkaDetay B) kullanacağız.
-- Soru: Her bir ülkenin (Mensei) ismini ve o ülkeye ait kaç farklı saat modelimiz olduğunu getir.
-- Algoritma Adımları:
-- A.Marka ve B.Marka üzerinden tabloları zımbala (JOIN).
-- SELECT kısmına B.Mensei yaz ve yanına COUNT(A.Model) koy.
-- En alta GROUP BY B.Mensei yazmayı unutma!


-- AGGREGATE (Hesapla): Sonra o poşetlerin içine bakıp "Burada kaç tane var?" (COUNT), 
-- "Hepsi kaç gram?" (SUM) veya 
-- "Ortalama büyüklüğü ne?" (AVG) diye bakıyorsun.

select 
    B.Mensei as 'Ülke', 
    count(A.Model) as 'Model_Sayısı'
from Saatler A inner join MarkaDetay B on A.Marka = B.Marka group by B.Mensei;  


-- Görev 2: Ciro ve Envanter Analizi
-- Şimdiye kadar tek tek saatleri gördük. Şimdi patrona ülke bazlı büyük resmi göstereceğiz.
-- Soru: Her bir ülkenin (Mensei) ismini, o ülkeye ait toplam stok miktarını ve saatlerin ortalama fiyatını getiren sorguyu yaz.
-- Sütun İsimleri (Alias):
-- B.Mensei -> 'Ülke'
-- SUM(A.Stok) -> 'Toplam_Stok'
-- AVG(A.Fiyat) -> 'Ortalama_Fiyat'

select 
    B.Mensei as 'Ülke',
    sum(A.Stok) as 'Toplam Stok',
    avg(A.Fiyat) as 'Ortalama Fiyat'
from Saatler A inner join MarkaDetay B on A.Marka = B.Marka group by B.Mensei;


-- Görev 3: Kritik Stok Raporu
-- Şimdi o yazdığın kodun sonuna minicik bir ekleme yapacağız.
-- Soru: Ülkelere göre toplam stok miktarını getir. AMA sadece toplam stoğu 10'dan az olan ülkeleri listele.
-- Taktik:
-- Yine JOIN ve GROUP BY B.Mensei yapacaksın.
-- En sona (GROUP BY'dan sonra) HAVING SUM(A.Stok) < 10 yazacaksın.

select  
    B.Mensei as 'Ülke', 
    sum(A.Stok) as 'Toplam_Stok'
from Saatler A inner join MarkaDetay B on A.Marka = B.Marka group by B.Mensei having sum(A.Stok) >= 10

    
        

-- Şirket yönetimi, sadece ucuz saatlerin çok satıldığı ülkelerle değil, "marka değeri yüksek" olan ülkelerle ilgilenmek istiyor.
-- Soru: Her bir ülkenin ismini (Mensei) ve o ülkedeki saatlerin ortalama fiyatını getiren bir sorgu yaz.
-- Kurallar:
-- Saatler (A) ve MarkaDetay (B) tablolarını Marka üzerinden birleştir.
-- Verileri ülkeye (Mensei) göre grupla.
-- Filtre (HAVING): Sadece ortalama fiyatı 15.000 TL'den büyük olan ülkeleri listele.

select 
    B.Mensei,
    avg(A.Fiyat) as 'Marka Değeri Yüksek'
from saatler A inner join MarkaDetay B on A.Marka = B.Marka group by B.Mensei having sum(A.Fiyat) > 15000


-- Soru: Her bir ülkenin (Mensei) ismini ve o ülkedeki saatlerin toplam stok miktarını getir.
-- Kurallar:
-- Tabloları Marka üzerinden birleştir.
-- Verileri ülkeye göre grupla.
-- Filtre (HAVING): Sadece toplam stoğu 5'ten fazla olan ülkeleri göster.
-- Sıralama (ORDER BY): Listeyi, toplam stoğu en yüksek olandan en düşük olana doğru (DESC) sırala.

select 
    B.Mensei,
    sum(A.Stok) as 'Toplam Stok'
from saatler A inner join MarkaDetay B on A.Marka = B.Marka group by B.Mensei having sum(A.Stok) > 5 order by sum(A.Stok) desc;




-- Soru: Ülkelere (Mensei) göre; kaç adet modelimiz olduğunu, toplam stok miktarımızı ve saatlerin ortalama fiyatını getiren bir sorgu yaz.
-- Kurallar:
-- Zımba (JOIN): Saatler ve MarkaDetay tablolarını birleştir.
-- Ön Eleme (WHERE): Listeye sadece fiyatı 2.000 TL’den büyük olan saatleri dahil et (ucuzları en başta ele).
-- Paketleme (GROUP BY): Verileri ülkeye (Mensei) göre grupla.
-- Grup Eleme (HAVING): Sadece bünyesinde 1'den fazla saat modeli (COUNT > 1) barındıran ülkeleri göster.
-- Sıralama (ORDER BY): Listeyi, ortalama fiyatı en yüksek olandan en düşüğe (DESC) doğru sırala.


select 
    B.Mensei,
    count(A.Model) as 'Toplam Model Sayısı', 
    sum(A.Stok) as 'Toplam Stok Sayısı',
    avg(A.Fiyat) as 'Saatlerin Ortalama Fiyatı'
from Saatler A inner join MarkaDetay B on A.Marka = B.Marka where A.Fiyat > 2000 group by B.Mensei having count(A.Model) > 1 order by avg(A.Fiyat) desc;





-- Soru: Her bir markanın ismini (MarkaAd), o markaya ait toplam stok maliyetini (Stok * Fiyat) ve o markadan kaç farklı model olduğunu getiren sorguyu yaz.
-- Kurallar:
-- Saatler (A) ve MarkaDetay (B) tablolarını birleştir.
-- Hesaplama (SELECT): Toplam maliyet için SUM(A.Stok * A.Fiyat) kullan. (Evet, parantez içinde çarpma yapabilirsin!)
-- Paketleme (GROUP BY): Marka ismine (B.MarkaAd) göre grupla.
-- Filtre (HAVING): Sadece toplam maliyeti 100.000 TL'den fazla olan "ağır topları" getir.
-- Sıralama (ORDER BY): En yüksek maliyetli markayı en üstte gör.

select 
    B.Marka,
    count(A.Model) as 'Model Sayısı',
    sum(A.Stok * A.Fiyat) as 'Toplam Maliyet'
from saatler A inner join MarkaDetay B on A.Marka = B.Marka group by B.Marka having sum(A.Stok * A.Fiyat) > 100000 order by sum(A.Stok * A.Fiyat) desc;




-- Görev 6: Stok Alarm Raporu
-- Patron diyor ki: "Onur, bana her bir ülkenin (Mensei) toplam stok miktarını getir. Ama yanına bir de 'Durum' sütunu ekle. Eğer toplam stok 15'ten fazlaysa 'Depo Dolu' yazsın, 15 ve altındaysa 'Sevkiyat Lazım' yazsın."
-- Kurallar:
-- Zımba (JOIN): Saatler (A) ve MarkaDetay (B) tablolarını birleştir.
-- Paketleme (GROUP BY): Verileri ülkeye (Mensei) göre grupla.
-- Etiketleme (CASE WHEN): SUM(A.Stok) sonucuna bakıp etiketi yapıştır.
-- Sıralama (ORDER BY): Toplam stoğu en yüksek olandan en düşüğe diz.

select
    B.Mensei,
    sum(A.Stok) as 'Toplam Stok Miktarı',
    case
        when sum(A.Stok) > 15 then 'Depo Dolu'
        when sum(A.Stok) <= 15 then 'Sevkiyat Lazım'
    end as 'Stok Durum'
from Saatler A inner join MarkaDetay B on A.Marka = B.Marka group by B.Mensei order by sum(A.Stok) desc;




-- Görev 7: Fiyat Segmentasyonu ve Vergi Analizi
-- Patron, hangi ülkelerin "Lüks" saatler ürettiğini, hangilerinin "Ekonomik" takıldığını merak ediyor.
-- Soru: Her bir ülkenin (Mensei) ismini ve o ülkedeki saatlerin ortalama fiyatını getir. Yanına da bir "Segment" sütunu ekle:
-- Ortalama fiyatı 20.000 TL'den büyükse 'Lüks Üretim' yazsın.
-- Ortalama fiyatı 20.000 TL ve altındaysa 'Standart Üretim' yazsın.
-- Kurallar:
-- Zımba (JOIN): Saatler (A) ve MarkaDetay (B) tablolarını Marka üzerinden bağla.
-- Paketleme (GROUP BY): Verileri ülkeye (Mensei) göre grupla.
-- Etiketleme (CASE WHEN): Ortalama fiyata (AVG) göre etiketi bas.
-- Sıralama (ORDER BY): Ortalama fiyata göre büyükten küçüğe diz.

select 
    B.Mensei,
        avg(A.Fiyat) as 'Ortalama Fiyat',
    case
        when avg(A.Fiyat) > 20000 then 'Lüks Üretim'
        when avg(A.Fiyat) <= 20000 then 'Standart Üretim'
    end as 'Ekonomik'
from Saatler A inner join MarkaDetay B on A.Marka = B.Marka group by B.Mensei order by avg(A.Fiyat) desc;



-- Görev 8: "Şüpheli Muhasebeci" Senaryosu
-- Şirketin muhasebecisi geldi ve dedi ki: "Onur, bazı markalarda çok garip bir durum var. Stokta sadece 1-2 tane saati kalmış ama o saatlerin toplam değeri acayip yüksek. Sanki elimizde 'satılamayan' çok pahalı ürünler kalmış gibi."
-- Soru: Senden öyle bir rapor istiyor ki; markaların ismini, ellerindeki toplam stok adedini ve bu stoğun toplam parasal değerini görsün.
-- Ancak sadece şu şartlara uyanları listelemeni istiyor:
-- Elimizde o markadan toplamda 5 adetten az saat kalmış olmalı (Yani stokta bitmek üzere olanlar).
-- Bu az sayıdaki saatin toplam maliyeti 50.000 TL'den fazla olmalı (Yani "az ama öz/pahalı" ürünler).
-- Listeyi, en yüksek maliyetli olandan en düşüğe doğru sırala ki "en tehlikeli" stokları en üstte görelim.


select 
    A.Marka, 
    sum(A.Stok) as 'Toplam Stok', 
    sum(A.Stok * A.Fiyat) as 'Stoğun Toplam Değeri', 
    case
        when sum(A.Stok) <= 5 then 'Stok Bitmek Uzere'
        when sum(A.Stok) <= 5 and sum(A.Stok * A.Fiyat) > 50000 then 'Az ama Öz/Pahalı Ürünler'  
        else 'Normal Stok'
    end as 'Stok Durumu' 
from Saatler A inner join MarkaDetay B on A.Marka = B.Marka group by A.Marka order by sum(A.Stok * A.Fiyat) desc;




--------------------------------------------------- kurumsal hayattan örnek -----------------------------------------------------

📧 Şirket İçi Yazışma 'Veri Analizi Talebi'
Kimden: Satış ve Operasyon Direktörü
Kime: Onur Mustafa Sarıdoğan (MIS Uzman Yardımcısı)
Konu: Bölgesel Ürün Çeşitliliği ve Fiyat Analizi Raporu

Onur Bey merhaba,

Yarınki yönetim kurulu toplantısında ülkelerin (Menşei) pazar performansını sunacağız. Mevcut stok verilerimiz üzerinden bir "Verimlilik Analizi" yapmanı bekliyorum. Bazı ülkelerde saatlerimizin ortalama fiyatı çok yüksek olmasına rağmen ürün çeşitliliğimizin (model sayımızın) çok düşük kaldığını fark ettik. Bu da o pazarda potansiyeli tam kullanamadığımız anlamına geliyor.

Senden acil olarak şu raporu hazırlamanı rica ediyorum

İstenen Veriler

Ülke (Mensei) ismi.

O ülkeye ait saatlerin ortalama fiyatı.

O ülkede bulunan toplam model sayısı.

Rapor Şartları (Filtreler):

Listeye sadece ortalama saat fiyatı 15.000 TL’nin üzerinde olan "Lüks Segment" ülkeleri dahil edilsin.

Bu ülkeler arasından, elinde toplamda 3 taneden az (yani 1 veya 2) farklı saat modeli olan "Düşük Çeşitlilik" grubunu görmek istiyoruz.

Raporun en üstünde, ortalama fiyatı en yüksek olan ülke yer alsın.

Bu verileri bugün mesai bitimine kadar hazırlayıp sorgu çıktısını benimle paylaşabilir misin?

İyi çalışmalar.


select 
    B.Mensei,
    avg(A.Fiyat) as 'Ortalama Fiyat',
    count(A.Model) as 'Toplam Model Sayısı'
from Saatler A inner join MarkaDetay B on A.Marka = B.Marka group by B.Mensei having avg(A.Fiyat) > 15000 and count(A.Model) < 3 order by avg(A.Fiyat) desc;




