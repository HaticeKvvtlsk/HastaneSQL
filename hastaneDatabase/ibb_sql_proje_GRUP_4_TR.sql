--Oluşturulan tüm trigger,procedure,view,function çalışmaları bunlara ek olarak Join ile yapılan sorgulamalarda aşağıda başlıklar altında ve yorum satırı halinde bulunmaktadır.



/*
--Eğer bu isimde bir veritabanı varsa silip tekrar oluşturacak, eğer yoksa veritabanını oluşturacak bir try-catch
--Daha önceden çalıştırdık ama son denemelerimizde hata verdi. O sebeple yorum satırı olarak eklendi.


begin try
if EXISTS (select * from sys.databases where name='HastaneVeriTabani')
begin
drop database HastaneVeriTabani
create database HastaneVeriTabani
end 
else
begin
create database HastaneVeriTabani
end
end try
begin catch
print 'Beklenmedik Bir Hata Oluştu.'
end catch
use HastaneVeriTabani
go
*/

create database HastaneVeriTabani
use HastaneVeriTabani
go

SET DATEFORMAT dmy;  
GO  

create table Meslek
(
MeslekID int primary key identity(1,1),
MeslekTuru nvarchar(25))
insert Meslek VALUES ('Doktor'),
('Hemşire'),
('Sağlık Teknikeri'),
('Acil Tıp Teknisyeni'),
('Laboratuvar Personeli'),
('Temizlik Personeli'),
('Hasta Bakım Personeli'),
('Hastane Yöneticisi'),
('Eczacı'), 
('Fizyoterapist'),
('Odyolog'),
('Biyolog'),
('Sosyal Hizmet Uzmanı'),
('Sağlık İdarecisi')

CREATE TABLE KanGrubu
(
KanGrubuID nvarchar(5) primary key,
KanGrubuTuru nvarchar(50)
)

INSERT KanGrubu VALUES ('ABP', 'AB+'),('ABN','AB-'),
('AP','A+'),('AN','A-'),
('BP','B+'),('BN','B-'),
('0P','0+'),('0N','0-')


create table HastaneBilgi(
HastaneID int primary key identity,
HastaneAdi nvarchar(50) not null,
TelefonNo nvarchar(20) not null,
Adres nvarchar(200) not null
)
INSERT HastaneBilgi(HastaneAdi,TelefonNo,Adres) Values ('Tema Kadiköy Hastanesi','0216 543 67 76','Dumlupınar Mah.Güner sok No:15 Kadiköy İstanbul')



create table Poliklinik(
PoliklinikID int primary key identity,
PoliklinkAdi nvarchar(50) not null,
HastaneID int FOREIGN KEY REFERENCES HastaneBilgi(HastaneID)
)

INSERT Poliklinik(PoliklinkAdi,HastaneID) VALUES ('Çocuk Sağlığı ve Hastalığı',1)
INSERT Poliklinik(PoliklinkAdi,HastaneID) VALUES ('Cildiye',1)
INSERT Poliklinik(PoliklinkAdi,HastaneID) VALUES ('Ortopedi ve Travmatoloji',1)
INSERT Poliklinik(PoliklinkAdi,HastaneID) VALUES ('Endokrinoloji ve Metaboliz',1)
INSERT Poliklinik(PoliklinkAdi,HastaneID) VALUES ('Fizik Tedavi ve Rehabilitasyon',1)
INSERT Poliklinik(PoliklinkAdi,HastaneID) VALUES ('Genel Cerrahi',1)
INSERT Poliklinik(PoliklinkAdi,HastaneID) VALUES ('Gögüs Cerrahisi',1)
INSERT Poliklinik(PoliklinkAdi,HastaneID) VALUES ('Göz Sağlığı ve Hastalıkları',1)
INSERT Poliklinik(PoliklinkAdi,HastaneID) VALUES ('İç Hastaliklari',1)
INSERT Poliklinik(PoliklinkAdi,HastaneID) VALUES ('Kadin Hastaliklari ve Doğum',1)
INSERT Poliklinik(PoliklinkAdi,HastaneID) VALUES ('Kardiyoloji',1)



create table Cinsiyet
(
CinsiyetID nvarchar(1) primary key,
Cinsiyet nvarchar(5)
)
insert Cinsiyet Values ('K','KADIN'),('E','ERKEK')



create table Personel
(
PersonelID int primary key identity(1,1) NOT NULL,
MeslekID int foreign key references Meslek(MeslekID),
PersonelAdi nvarchar(50) NOT NULL,
PersonelSoyadi nvarchar(50) NOT NULL,
TCKN char(11) NOT NULL check(len(TCKN)=11),
DogumTarihi date,
Cinsiyet nvarchar(1) foreign key references Cinsiyet(CinsiyetID),
TelefonNo nvarchar(12) check(len(TelefonNo)=12),
Mail nvarchar(50),
Adres nvarchar(100),
İseGirisTarihi date NOT NULL,
EnSonMezuniyetBilgisi nvarchar(50),
KanGrubuID nvarchar(5) foreign key references KanGrubu(KanGrubuID),
HastaneID int foreign key references HastaneBilgi(HastaneID) NOT NULL,
)


insert Personel values
(1,'Şennur','Ağnar','80455545109','03.02.1992','K','(676)9297712','sennur.agnar@gmail.com','Ahmet Mah. Akarcalı Sok. No:89 Istanbul','10.11.2019','Doktora','BN',1),
(1,'Rüya','Alp','36921865781','11.09.1991','K','(212)2220888','ruya.alp@mail.com','Reşadiye Mahallesi, İzzet Sancak Caddesi,No:25,Kat:3,Daire:14,Serhat Apartmanı','08.10.2019','Lisans','AP',1),
(1,'Mert','Alkan','34698745632','05.07.1987','E','(537)4784778','mert.alkan@mail.com','Saffet Mahallesi,Pınar Hisar Caddesi,Gündüz Apartmanı,Daire:22,İstanbul/Esenler','08.01.2017','Lisans','ABP',1),
(1,'Hamide','Pala','64686212457','12.12.1980','K','(535)5355535','hamide.pala@mail.com','Kaput mahallesi, Atatürk caddesi,89.Sokak,Daire:6/3,Şişli/İstanbul','12.12.2021','Doktora','0N',1),
(1,'Asaf','Yıldız','18191252878','07.02.1978','E','(555)6389802','asaf.yildiz@mail.com','Kocatepe mahallesi, Koca Caddesi,Güniz Sokağı,Aslı Apt.,Daire:2,Şişli/İstanbul','10.10.2012','Yüksek Lisans','ABN',1),
(1,'Adil','Özgür','78964512188','03.03.1978','E','(551)9455234','adil.ozgur@mail.com','Kemalpaşa mahallesi, Serdivan Caddesi,Artvin Sokağı,No:12,Daire:2,İstanbul', '10.12.2017','Yüksek Lisans','AP',1),
(1,'Bahar','Özge','72526911498','03.07.1988','K','(555)9877234','bahar.ozge@mail.com','Alibeyoğlu Mah. Alparslan Sok. No:64 Istanbul', '10.01.2020','Lisans','0N',1),
(1,'Ömer','Alparslan','14159521326','08.05.1975','E','(955)4612810','omer.alparslan@gmail.com','Altan Mah. Altay Sok. No:4 Istanbul','11.10.2020','Doktora','0N',1),
(1,'Ateş','Aycı','89054806986','02.08.1978','E','(512)2124565','ates.ayci@gmail.com','Aydoğan Yozgat Mah. Aygen Sok. No:77 Istanbul','10.01.2019','Lisans','ABN',1),
(1,'Zeynep Nihan','Aydınlıoğlu','16113521748','02.12.1972','K','(703)3110705','zeynepnihan.aydinlioglu@gmail.com','Aydoğdu Mah. Aykan Sok. No:85 Istanbul','01.08.2018','Yüksek Lisans','0P',1),
(1,'Saba','Atmaca','45891782994','05.04.1972','K','(577)8648488','saba.atmaca@gmail.com','Atol Mah. Avcı Özsoy Sok. No:21 Istanbul','10.04.2022','Doktora','AN',1),
(1,'Ata Kerem','Akman','55762441724','07.01.1982','E','(567)3479765','atakerem.akman@gmail.com','Akova Mah. Aksevim Sok. No:93 Istanbul','08.02.2019','Lisans','AP',1),
(1,'Nüket','Aksan','28187325726','04.03.1978','K','(860)9627289','nuket.aksan@gmail.com','Aksoy Mah. Akşamoğlu Sok. No:94 Istanbul','12.12.2021','Lisans','AN',1),
(1,'Kutlu','Alibeyoğlu','68807641744','01.01.1987','E','(646)9959765','kutlu.alibeyoglu@gmail.com','Alparslan Mah. Altan Sok. No:7 Istanbul','10.06.2018','Lisans','ABN',1),
(1,'Eda Sena','Akyıldız','94668689318','12.12.1970','K','(353)6975488','edasena.akyildiz@gmail.com','Al Mah. Aldağ Sok. No:23 Istanbul','01.08.2020','Lisans','BP',1),
(1,'Mazlum','Altan','82899482741','04.08.1978','E','(984)9763760','mazlum.altan@gmail.com','Altay Mah. Altınoklu Sok. No:71 Istanbul','10.12.2018','Doktora','0P',1),
(1,'Edip','Attila','90483987245','09.09.1989','E','(825)3794660','edip.attila@gmail.com','Avıandı Mah. Ay Sok. No:82 Istanbul','10.12.2019','Lisans','ABP',1),
(1,'Deniz Dilay','Arıcan','46067618150','01.02.1982','K','(779)2211397','denizdilay.arican@gmail.com','Arif Mah. Armutcu Sok. No:8 Istanbul','05.08.2019','Lisans','0N',1),
(1,'İsmail','Umut','30312674854','10.05.1992','E','(481)5502345','ismailumut@gmail.com','Ansen Mah. Aral Sok. No:90 Istanbul','08.06.2021','Doktora','ABP',1),
(1,'Leyla','Yakupoğlu','41718293655','02.12.1992','K','(555)6389878','leyla.yakupoglu@mail.com','Mareşal Mahallesi, Çalışlar cad. albay sok. adatepe apt.,İstanbul','01.05.2021','Lisans','AN',1),
(1,'Fatma Özlem','Acar','92024632890','12.08.1978','K','(210)5734040','fatmaozlem.acar@gmail.com','Adanır Mah. Ağca Sok. No:85 Istanbul','08.10.2019','Lisans','AN',1),
(1,'Özde','Acarkan','62660003491','08.12.1972','K','(733)3914794','ozde.acarkan@gmail.com','Adıgüzel Mah. Ağırağaç Sok. No:57 Istanbul','08.10.2020','Yüksek Lisans','BP',1),
(2,'Atahan','Adanır','99614197194','12.12.1982','E','(725)9372925','atahan.adanir@gmail.com','Ağca Mah. Ağıroğlu Sok. No:77 Istanbul','03.05.2019','Lisans','ABP',1),
(2,'Hacı Mehmet','Adıgüzel','13805084899','05.06.1986','E','(682)3218022','hacimehmet.adiguzel@gmail.com','Ağca Mah. Ağıroğlu Sok. No:77 Istanbul','01.11.2021','Lisans','BN',1),
(2,'Mükerrem Zeynep','Ağca','69632995001','10.08.1989','K','(968)5025652','mukerremzeynep.agca@gmail.com','Ağıroğlu Mah. Ahmadı Asl Sok. No:46 Istanbul','02.01.2022','Lisans','0P',1),
(2,'Bestami','Ağırağaç','17996088604','05.08.1991','E','(396)8437764','bestami.agiragaç@gmail.com','Ağnar Mah. Ahmet Sok. No:30 Istanbul','01.11.2021','Önlisans','BP',1),
(2,'Aykut','Ağıroğlu','66472849869','09.05.2019','E','(593)9489963','aykut.agiroglu@gmail.com','Ahmet Yesevi Mah. Ak Sok. No:52 Istanbul','12.08.2022','Önlisans','AN',1),
(2,'Tutkum','Asil','57182199935','03.08.1994','K','(492)8459612','tutkum.asil@gmail.com','Ak Mah. Akarçay Sok. No:75 Istanbul','12.07.2022','Önlisans','0N',1),
(2,'Mügenur','Ahmet','22743807388','07.12.1997','K','(267)2220672','mugenur.ahmet@gmail.com','Akarcalı Mah. Akarpınar Sok. No:55 Istanbul','04.02.2020','Önlisans','AN',1),
(3,'Sevinç','Ak','98860232636','09.08.1987','K','(311)8262888','sevinc.ak@gmail.com','Akarçay Mah. Akaş Sok. No:43 Istanbul','08.05.2020','Önlisans','AN',1),
(3,'Kayıhan Nedim','Akarcalı','62882631493','07.03.1992','E','(968)6170341','kayihannedim.akarcali@gmail.com','Akarpınar Mah. Akay Sok. No:2 Istanbul','08.12.2020','Önlisans','AP',1),
(3,'Lemi','Akarçay','64255644435','11.11.1991','E','(293)6064169','lemi.akarcay@gmail.com','Akaş Mah. Akbilmez Sok. No:30 Istanbul','03.12.2021','Önlisans','0P',1),
(3,'Cihan','Akarpınar','19679424576','08.02.1992','E','(408)3991381','cihan.akarpinar@gmail.com','Akay Mah. Akca Sok. No:83 Istanbul','03.10.2021','Önlisans','ABN',1),
(3,'Rafi','Akaş','22396247882','03.12.1988','E','(271)8772723','rafi.akas@gmail.com','Akbilmez Mah. Akçagunay Sok. No:57 Istanbul','10.05.2017','Önlisans','ABP',1),
(4,'Mehmetcan','Akay','63069500518','12.12.1985','E','(687)3278027','mehmetcan.akay@gmail.com','Akca Mah. Akçay Sok. No:62 Istanbul','08.12.2015','Önlisans','ABP',1),
(4,'Demircan','Baydil','26106573941','05.05.1985','E','(567)9643037','demircan.baydil@gmail.com','Baykan Mah. Bayrakoğlu Sok. No:84 Istanbul','08.08.2018','Önlisans','ABN',1),
(5,'Burçin Kübra','Baykal','22755694880','07.10.1978','K','(581)3442294','burcinkubra.baykal@gmail.com','Baykuş Mah. Bayram Sok. No:79 Istanbul','11.11.2021','Lisans','0N',1),
(5,'Derviş Haluk','Baykan','39948218832','01.01.1988','E','(437)2783315','dervishaluk.baykan@gmail.com','Bayrakoğlu Mah. Baytın Sok. No:56 Istanbul','03.11.2020','Lisans','0P',1),
(6,'Taylan Remzi','Baykuş','36661392747','02.03.1989','E','(794)2136130','taylanremzi.baykus@gmail.com','Bayram Mah. Begiç Sok. No:8 Istanbul','01.05.2015','İlkokul','0N',1),
(6,'Didem','Bıçaksız','71522586913','05.06.1987','K','(919)3540236','didem.bicaksiz@gmail.com','Bilgeç Mah. Bilgi Sok. No:59 Istanbul','10.10.2020','Önlisans','0N',1),
(6,'Halime','Beydağ','10334565256','06.08.1980','K','(822)5712962','halime.beydag@gmail.com','Ağca Mah. Ağıroğlu Sok. No:77 Istanbul','01.12.2021','Lise','AP',1),
(6,'Mihrinaz','Bilal','26671776647','12.08.1968','K','(727)7155857','mihrinaz.bilal@gmail.com','Bilgen Mah. Bilgiç Sok. No:43 Istanbul','18.12.2015','Lise','AP',1),
(6,'Onur Taylan','Boylu','11679536590','04.11.1987','E','(827)7224608','onurtaylan.boylu@gmail.com','Boz Mah. Bozdemir Sok. No:50 Istanbul','05.11.2019','Lise','AP',1),
(6,'Nuhaydar','Akbilmez','65785481392','01.01.1994','E','(308)9173655','nuhaydar.akbilmez@gmail.com','Boz Mah. Bozdemir Sok. No:50 Istanbul','12.12.2012','Lise','AN',1),
(6,'Emine Münevver','Akca','41504998275','01.05.1970','K','(831)4010748','eminemunevver.akca@gmail.com','Akçay Mah. Akfırat Sok. No:92 Istanbul','07.06.2020','Lise','BN',1),
(6,'Servet','Akçagunay','17464722886','09.05.1978','E','(546)3002554','servet.akcagunay@gmail.com','Akdoğan Mah. Akıllı Sok. No:17 Istanbul','03.12.2021','Lise','BN',1),
(6,'Çilem','Akçay','71938737244','09.05.1984','K','(675)7267737','cilem.akcay@gmail.com','Akfırat Mah. Akıncılar Sok. No:68 Istanbul','02.05.2018','Lise','BP',1),
(7,'Recep Ali Samet','Akdoğan','92688204139','08.09.1990','E','(608)3669976','recepalisamet.akdogan@gmail.com','Akıllı Mah. Akış Sok. No:58 Istanbul','11.12.2017','Önlisans','ABN',1),
(7,'Emre Ayberk','Akfırat','88481002022','09.10.1991','E','(234)2795602','emreayberk.akfirat@gmail.com','Akincilar Mah. Akkiray Sok. No:80 Istanbul','07.08.2018','Lise','ABN',1),
(7,'Kerime Hacer','Akıllı','59151778711','03.03.1987','K','(746)9044940','kerimehacer.akilli@gmail.com','Akış Mah. Akkoyun Sok. No:92 Istanbul','08.08.2018','Ömlisans','ABN',1),
(7,'Ercüment','Akıncılar','61318996288','05.02.1988','E','(925)5390544','ercument.akincilar@gmail.com','Akkiray Mah. Akküt Sok. No:37 Istanbul','02.02.2020','Önlisans','BP',1),
(7,'İclal','Akkoyun','30806098427','10.10.1990','K','(942)5014886','iclal.akkoyun@gmail.com','Aklar Çörekçi Mah. Akoğuz Sok. No:98 Istanbul','09.12.2021','Önlisans','AP',1),
(7,'Ahmet','Polat','77619098484','01.02.1991','E','(306)4867500','ahmet.polat@gmail.com','Akoğuz Mah. Aksan Sok. No:1 Istanbul','03.02.2020','Önlisans','0P',1),
(7,'Elif','Altaş','29973288986','05.12.1992','K','(623)7025254','elif.altas@gmail.com','Altın Mah. Altınöz Sok. No:71 Istanbul','12.12.2019','Önlisans','0P',1),
(8,'Elif Dilay','Altinkaya','58549601972','11.05.1991','K','(997)4100568','elifdilay.altinkaya@gmail.com','Altunbulak Mah. Aluç Sok. No:36 Istanbul','01.02.2017','Lisans','ABP',1),
(8,'Ömer','Alparslan','14159521326','07.11.1989','E','(955)4612810','omer.alparslan@gmail.com','Altan Mah. Altay Sok. No:4 Istanbul','12.12.2019','Yüksek Lisans','0N',1),
(8,'Büşra','Altundal','32104964420','10.12.1982','K','(322)3940585','busragul.altundal@gmail.com','Ala Mah. Ankara Sok. No:88 Istanbul','02.01.2021','Doktora','ABN',1),
(9,'Sarper','Akış','34709264708','07.03.1992','E','(844)5999772','sarper.akis@gmail.com','Akkoyun Mah. Aklar Çörekçi Sok. No:99 Istanbul','12.12.2017','Lisans','0N',1),
(9,'Berker','Yılmaz','97642189324','02.03.1980','E','(224)4344088','berkeryilmaz@gmail.com','Akküt Mah. Akman Sok. No:67 Istanbul','10.10.2020','Lisans','AN',1),
(10,'Merve','Kartal','15816924756','01.04.1981','K','(212)7808529','mervekartal@gmail.com','Nur Mah. Mecidiye Cad. No:71 Istanbul','08-10-2019','Lisans','AN',1),
(10,'Senem','Aksevim','97746537905','05.05.1985','K','(714)2436353','senemaksevim@gmail.com','Aksöz Mah. Aktuna Sok. No:25 Istanbul','01.10.2019','Yüksek Lisans','ABN',1),
(10,'Yaşar','Yaşamaz','45678932987','05.06.1986','E','(554)4612810','yasaryasamaz@gmail.com','Kırmızı Mah. Yeşil Sok. No:4 Istanbul','08.12.2017','Yüksek Lisans','BN',1),
(10,'Murat','Ayaz','32975827986','11.07.1987','E','(322)3940585','murat.ayaz@gmail.com','Aycı Mah. Aydoğan Yozgat Sok. No:23 Istanbul','05.12.2020','Lisans','AP',1),
(11,'Senem','Aksevim','97746537905','09.09.1988','K','(714)2436353','senemaksevim@gmail.com','Aksöz Mah. Aktuna Sok. No:25 Istanbul','08.10.2019','Lisans','AP',1),
(11,'Yaşar','Yaşamaz','45678932987','10.10.1986','E','(554)4612810','yasaryasamaz@gmail.com','Kırmızı Mah. Yeşil Sok. No:4 Istanbul','08.12.2019','Lisans','AP',1),
(11,'Kaan','Özgür','77076682779','02.11.1977','E','(363)4368585','kaan.ozgur@gmail.com','Ayaz Mah. Aydınlıoğlu Sok. No:45 Istanbul','10.10.2020','Lisans','0P',1),
(11,'Muharrem','Ay','98745632185','01.11.1988','E','(898)4545698','muharrem.ay@gmail.com','Ayaz Mah. Güneş Cad., Lale Sok., No:45 Istanbul','12.12.2021','Lisans','0N',1),
(12,'Feyza','Bal','52760836226','09.11.1980','K','(377)3542320','elif.bal@gmail.com','Aysan Mah. Azbay Sok. No:79 Istanbul','12.08.2020','Lisans','BN',1),
(12,'Gizem','Belli','42027127302','02.12.1987','K','(714)2436353','gizembelli@gmail.com','Bıçaksız Mah. Bilgeç Sok. No:19 Istanbul','12.12.2017','Yüksek Lisans','0P',1),
(12,'Özge','Demirel','93133761192','01.10.1978','K','(452)6875435','odemirel@gmail.com','Altay Mah. Aldağ Sok. No:77 Istanbul','01.05.2019','Yüksek Lisans','0N',1),
(13,'İbrahim','Hansu','65598880123','12.08.1979','E','(376)4478983','burakbalcii@gmail.com','Balcı Mah. Aygen Sok. No:20 Istanbul','08.12.2019','Lisans','BN',1),
(13,'Burak','Balcı','32975827986','10.11.1981','E','(636)9535300','burakbalcii@gmail.com','Atlı Mah. Aycı Sok. No:29 Istanbul','18.08.2019','Yüksek Lisans','ABN',1),
(13,'Selma','Ceylan','23824355930','11.05.1985','K','(775)5975910','selmaceylan@gmail.com','Baş Mah. Öğretmen Cad. No:25 Istanbul','02.06.2017','Yüksek Lisans','ABP',1),
(14,'Büşra','Cüce','25960977919','12.09.1989','K','(554)4612810','busracuce@gmail.com','Çağatay Mah. Çağlayan Sok. No:42 Istanbul','12.02.2021','Yüksek Lisans','0P',1),
(14,'Ali','Baş','35736941647','01.01.1977','E','(202)4953390','alibas@gmail.com','Çağan Mah. Çağlar Sok. No:98 Istanbul','01.10.2019','Yüksek Lisans','0N',1),
(14,'Melek','Nur','65598880123','02.09.1992','K','(376)4478983','meleknur@gmail.com','Balcı Mah. Aygen Sok. No:20 Istanbul','08.01.2017','Doktora','AN',1)



Create TABLE Izinler
(
IzinID int Primary Key identity(1,1),
PersonelID int foreign key references Personel(PersonelID) NOT NULL,
IzınTuru nvarchar (50) NOT NULL,
IzinBaslangic date NOT NULL,
IzinBitis date NOT NULL,
IzinAdresi nvarchar(250)
)
insert Izinler values
(1,'Ücretli Yıllık İzin','12.09.2022','23.09.2022','Reşadiye Mahallesi, İzzet Sancak Caddesi,No:25,Kat:3,Daire:14,Serhat Apartmanı'),
(2,'Mazeret İzni','19.10.2022','21.10.2022','Saffet Mahallesi,Pınar Hisar Caddesi,Gündüz Apartmanı,Daire:22,İstanbul/Esenler'),
(5,'Ücretsiz İzin','06.06.2022','17.06.2022','Kocatepe mahallesi, Koca Caddesi,Güniz Sokağı,Aslı Apt.,Daire:2,Şişli/İstanbul'),
(12,'Mazeret İzni','19.10.2022','21.10.2022','Akova Mah. Aksevim Sok. No:93 Istanbul'),
(41,'Hastalık İzni','12.09.2022','23.09.2022','Ağca Mah. Ağıroğlu Sok. No:77 Istanbul'),
(51,'Ücretli Yıllık İzin','10.10.2022','21.10.2022','Akkiray Mah. Akküt Sok. No:37 Istanbul'),
(18,'Ücretli Yıllık İzin','24.10.2022','04.11.2022','Arif Mah. Armutcu Sok. No:8 Istanbul'),
(22,'Mazeret İzni','19.10.2022','20.10.2022','Akova Mah. Aksevim Sok. No:93 Istanbul'),
(57,'Ücretsiz İzin','15.09.2022','16.09.2022','Ala Mah. Ankara Sok. No:88 Istanbul'),
(19,'Mazeret İzni','19.10.2022','21.10.2022','Ansen Mah. Aral Sok. No:90 Istanbul'),
(7,'Ücretli Yıllık İzin','08.08.2022','19.08.2022','Alibeyoğlu Mah. Alparslan Sok. No:64 Istanbul'),
(4,'Hsatlık İzni','18.08.2022','19.08.2022','Kaput mahallesi, Atatürk caddesi,89.Sokak,Daire:6/3,Şişli/İstanbul'),
(19,'Ücretli Yıllık İzin','12.09.2022','23.09.2022','Ansen Mah. Aral Sok. No:90 Istanbul'),
(32,'Mazeret İzni','19.10.2022','21.10.2022','Akaş Mah. Akbilmez Sok. No:30 Istanbul'),
(15,'Ücretsiz İzin','06.07.2022','07.07.2022','Al Mah. Aldağ Sok. No:23 Istanbul'),
(1,'Mazeret İzni','19.10.2022','21.10.2022','Reşadiye Mahallesi, İzzet Sancak Caddesi,No:25,Kat:3,Daire:14,Serhat Apartmanı'),
(12,'Ücretli Yıllık İzin','12.09.2022','23.09.2022','Akova Mah. Aksevim Sok. No:93 Istanbul'),
(22,'Hastalık İzni','12.09.2022','14.09.2022','Akova Mah. Aksevim Sok. No:93 Istanbul'),
(28,'Hastalık İzni','09.09.2022','11.09.2022','Ak Mah. Akarçay Sok. No:75 Istanbul'),
(13,'Ücretli Yıllık İzin','15.08.2022','26.08.2022','Aksoy Mah. Akşamoğlu Sok. No:94 Istanbul'),
(9,'Mazeret İzni','19.10.2022','21.10.2022','Aydoğan Yozgat Mah. Aygen Sok. No:77 Istanbul'),
(15,'Ücretsiz İzin','10.10.2022','14.10.2022','Al Mah. Aldağ Sok. No:23 Istanbul'),
(24,'Mazeret İzni','19.10.2022','21.10.2022','Ağca Mah. Ağıroğlu Sok. No:77 Istanbul'),
(61,'Ücretli Yıllık İzin','01.11.2022','11.11.2022','Aksöz Mah. Aktuna Sok. No:25 Istanbul'),
(76,'Hastalık İzni','18.09.2022','20.09.2022','Balcı Mah. Aygen Sok. No:20 Istanbul')



create table Doktorlar 
(
DoktorID int primary key identity(1,1) NOT NULL,
PoliklinikID int foreign key references Poliklinik(PoliklinikID),
PersonelID int foreign key references Personel(PersonelID) NOT NULL
)

INSERT Doktorlar(PoliklinikID,PersonelID) VALUES
(1,1), (2,2), (3,3), (4,4), 
(5,5), (6,6), (7,7), (8,8), 
(9,9), (10,10), (11,11), (3,12), 
(4,13), (5,14), (6,15), (7,16), 
(8,17), (9,18), (10,19), 
(11,20),(1,21),(2,22)


CREATE TABLE HastaGecmisi
(
HastaGecmisiID int primary key identity(1,1) NOT NULL,
KullandigiIlac nvarchar(50),
GecirdigiHastalik nvarchar(50),
GecirdigiAmeliyat nvarchar(50),
Alerjiler nvarchar(50)
)
insert into HastaGecmisi values 
('IbuCold','Grip','','Polen alerjisi'),
('Zoprotex','Yüksek Tansiyon','',''), 
('Dideral', 'Anjiyo', '','Evcil hayvan alerjisi'), 
('Desferal', 'Tip-2 Diyabet', 'Bademcik ameliyatı',''),
('Favira','Covid-19','','Konjonktivit'),
('Dermovat', 'Seboreik Dermatit', 'Apandisit Ameliyatı',''),
('Rennie', 'Ülser', 'Karaciğer Nakli',''),
('Tasigna','Kronik Lösemi','Diz Ameliyatı','Toz Alerjisi'),
('Stilex','Akut Ürtiker','Burun Ameliyatı','Penisilin Alerjisi'),
('Arveles','Uyluk Kemiği Kırılması','Bacak Ameliyatı','Domates Alerjisi'),

('Augmentin','Orta Kulak İltihabı','',''),
('Fomoser', 'Arpacık', 'Katarakt Ameliyatı','Polen Alerjisi'),
('Arveles','PCOS','',''),
('Exelon', 'Faranjit','',''),
('Galvus','Sistit','','Evcil Hayvan Alerjisi'),
('Nevanac','İdrar yolları enfeksiyonu','Geniz Eti Ameliyatı',''),
('Ritalin','Şizofreni','',''),
('Sandostatin','Böbrek taşı','',''),
('Starlix','Kalp yetmezliği','Bypass',''),
('Tobrex','Aritmi','',''),

('Voltaren','Guatr','','Penisilin Alerjisi'),
('Revolade','Ürtiker','',''),
('Jakavi','Böbrek Yetmezliği','Böbrek Taşı Ameliyatı',''),
('Diovan','Artrit','',''),
('Actifed','İdrar Yolları Enfeksiyonu','','Toz Alerjisi'),
('Travazol','Mantar Enfeksiyonu','Apandisit Ameliyatı',''),
('Katarin Forte','Soğuk Algınlığı','',''),
('Ventolin','Orta Kulak İltihabı','',''),
('Onceair','Sinüzit','',''),
('Avmigran','Migren','Safra Kesesi Ameliyatı',''),

('Atarax','Katarakt','Safra Kesesi Ameliyatı',''),
('Zespira','Panikatak','','Küf Alerjisi'),
('Üropan','Dermatit','',''),
('Asacol','Ülseratif Kolit','',''),
('Aricept','Hipertiroid','',''),
('Roxion','Hipertansiyon','','Süt alerjisi'),
('Sulcid','Kalp krizi','Açık Kalp Ameliyatı',''),
('Zinnat','Akciğer Kanseri','',''),
('Penbisin','Kalp yetmezliği','Mitral Kapak Ameliyatı',''),
('Kemoprim','Mide Kanseri','Mide Bypass',''),

('Cipro','Gıda Zehirlenmesi','Endoskopi',''),
('Cilapem','Hipotiroid','','Toz Alerjisi'),
('Genta','Pankreatit','Mide Kelepçe Ameliyatı',''),
('Flotic','Crohn Hastalığı','',''),
('Ketoral','Seboroik Dermatit','',''),
('Arveles','Artrit','',''),
('Serozil','Stoma','','Küf Alerjisi'),
('Aklovir','Fungal Akne','',''),
('Ornisid','Ürtiker','Anjiyo',''),
('Zofunol','Hipertansiyon','Açık Kalp Ameliyatı',''),

('Savler','Tip-1 diyabet','',''),
('Stocrin','OKB','Burun Ameliyatı','Çikolata Alerjisi'),
('Cidofovir','KOAH','Akciğer Ameliyatı',''),
('Savlex','Bronşit','',''),
('Ornisid','Hipotiroid','Katarakt Ameliyatı',''),
('Cipro','Sarkoidoz','',''),
('Apranax','Kronik bronşit','',''),
('Genta','Neoplazm','',''),
('Fucidin','Seboroik Dermatit','',''),
('Genta','İshal','',''),

('Aricept','Hepatit B','',''),
('Aspirin','Kalp Yetmezliği','','Toz Alerjisi'),
('Bilaxten','Siroz','Katarakt Ameliyatı',''),
('Zantac','Artrit','',''),
('Norsol Damla','Polip','',''),
('Aferin','Soğuk Algınlığı','',''),
('Roaccutane','Fungal Akne','','')


CREATE TABLE Hasta
(
HastaID int primary key identity(1,1) NOT NULL,
HastaAdi nvarchar (50) NOT NULL,
HastaSoyadi nvarchar(50) NOT NULL,
TCKN char(11) NOT NULL check(len(TCKN)=11),
DogumTarihi date NOT NULL,
Kilo decimal(18,2),
Cinsiyet nvarchar(1) foreign key references Cinsiyet(CinsiyetID),
HastaTelefonNo char(12) NOT NULL ,
HastaMail nvarchar(50),
HastaAdres nvarchar (200) NOT NULL,
HastaGecmisiID int foreign key references HastaGecmisi(HastaGecmisiID),
KanGrubuID nvarchar(5) foreign key references KanGrubu(KanGrubuID),
)

insert into Hasta values 
('Büşra','Yılmaz','14725836987','07.01.1998',46,'K','05468795269','busrayilmaz@hotmail.com','İbnisina sk. Menderes mah. No:15/6 Üsküdar/İstanbul',1,'AN'),
('Gizem','Topçu','96587412563','03.06.1986',56,'K','05398742569','gizemtopcu@gmail.com','Manisa sk. Güzelbahçe mah. No:214/9a Kadıköy/İstanbul',2,'BN'),
('Ali','Görmez','14523698541','09.03.1975',85,'E','05347895212','aligormez@hotmail.com','Fidan sk. Cumhuriyet mah. No:21/8 Beylikdüzü/İstanbul',3,'0P'),
('Murat','Yener','36521478541','07.11.1994',65,'E','05387896523','muratyener@outlook.com','1425.sk. Barış mah. No:1/3 Esenler/İstanbul',4,'AP'),
('Nermin','İnce','85478965214','07.01.1970',68,'K','05364785965','nerminince@gmail.com','Manolya sk. Vatan mah. No:113/6 Pendik/İstanbul',5,'ABN'),
('Tuncay','Yıldırım','10247856934','06.12.1968',90,'E','05412365478','tuncayyildirim@icloud.com','45.sk. Ata mah. No:28/3 Şile/İstanbul',6,'0N'),
('Sude', 'Doğan','90478125632','11.04.1995',59,'K','05214785236','sudedogan_95@gmail.com','Güneş sk. Başarı mah. No:65a/3 Zeytinburnu/İstanbul',7,'ABP'),
('Simay','Kaya','87412036587','05.11.1997',60,'K','05364789521','simaykaya@hotmail.com','Paris sk. Yıldırım mah. No:20/1 Bayrampaşa/İstanbul',8,'AN'),
('Berk','Ertaş','36521478529','01.06.1999',75,'E','05478526987','berkertas@gmail.com','Sümbül sk. Gazi mah. No:30/12 Bakırköy/İstanbul',9,'AP'),
('Sefa','Yüksel','30178942657','05.12.1988',81,'E','05235698744','yukselsefa@gmail.com','Kervan sk. Yenidoğan mah. No:14/2 Ümraniye/İstanbul',10,'ABP'),
('Zeynep','Eren','21354785698','11.05.1964',60,'K','05423658798','erenzeynep21@hotmail.com','Bahariye Cad. Atatürk Mah. No:54/4 Ataşehir/İstanbul',11,'AP'),
('Betul','Kırcı','14785412369','01.06.1985',59,'K','05687459899','betulkirci@hotmail.com','Derbent Köyü,22, 64000, Merkez/Istanbul',12,'ABN'),
('Ahmet','Erdoğdu','15963214587','03.12.2000',52,'E','05214785693','ahmeterdogdu54@outlook.com','Kiran,28, 28502, Tirebolu/Istanbul',13,'BN'),
('Gençay','Ergül','25418965412','08.02.1976',69,'E','05631458742','gencayergull@hotmail.com','Ortahaciahmetli Köyü,28, 40702, Çiçekdaği/Istanbul',14,'0P'),
('Abdürreşit','Arslan','56234875128','05.03.1966',70,'E','05326521423','abdurresitarslan@gmail.com','Armutlu Köyü,20, 72400, Kozluk/Istanbul',15,'0N'),
('Birsen','Erdoğan','12545896523','12.03.1958',54,'K','05366589687','birsenerdogan@gmail.com','Cumhuriyet,2, 11600, Söğüt/Istanbul',16,'ABP'),
('Onursu','Sakarya','12547856321','10.05.1965',87,'E','05305684545','onursusakarya@hotmail.com','Ölüdeniz,24, 48300, Fethiye/Istanbul',17,'0N'),
('Sevican','Aydar','15478521485','10.06.1964',64,'K','05321458569','sevicanaydar@gmail.com','Orman,29, 78000, Merkez/Istanbul',18,'AP'),
('Gül','İhsanoğlu','54685214785','09.11.1963',75,'K','05458965485','gulihsansanogluu@gmail.com','Yalinli,21, 63500, Akçakale/Istanbul',19,'BP'),
('Ömür','Fırat','15462135874','11.11.2011',60,'E','05045623121','omurfirat@gmail.com','Kurtuluş,26, 61450, Hayrat/Istanbul',20,'ABP'),
('Rümeysa','Avcı','56289647851','12.12.2010',58,'K','05035625487','rumeysaavci@gmail.com','Başköy Köyü,34, 37210, Merkez/Istanbul',21,'0P'),
('Aylin','Durmaz','19685471285','01.01.2001',54,'K','05047859666','aylindurmaz@hotmail.com','Necip Fazil,29, 34773, Ümraniye/Istanbul',22,'ABP'),
('Zeynep','Bardak','21056321445','11.10.1985',66,'K','05624785211','zeynepbardak@gmail.com','Yayla Evleri,35, 14850, Mengen/Istanbul',23,'0N'),
('Aykut','Sezen','25478563214','05.06.2002',63,'E','05326589647','aykutsezenn@hotmail.com','Ekincik,32, 18322, Bayramören/Istanbul',24,'BN'),
('Kerime','Şener','55478554126','08.06.2000',90,'K','05325899887','kerimesener@gmail.com','Seyrantepe,26, 66300, Akdağmadeni/Istanbul',25,'ABN'),
('Lâle','Akça','12547856985','02.03.1965',92,'K','05365411123','laleakca@gmail.com.com','Bakirköy,19, 35790, Beydağ/Istanbul',26,'ABN'),
('Çağlar','Şensoy','25415698521','05.11.1963',60,'E','05326588895','caglarsensoy@gmail.com','Ulaşli Köyü,30, 72402, Kozluk/Istanbul',27,'0P'),
('Dilara','Zorlu','21455623840','12.12.1966',86,'K','05345659641','dilarazorlu@gmail.com','Çomaklar,1, 67380, Ereğli/Istanbul',28,'0N'),
('Gökay','Derkay','56232102547','12.05.1967',87,'E','05321452232','gokayderkay@gmail.com','Mevlütler,22, 20800, Acipayam/Istanbul',29,'AP'),
('Gülen','Bilgin','12556321202','06.08.1999',95,'K','05621458962','gulenbilgin@hotmail.com','Emir,11, 16980, Orhaneli/Istanbul',30,'AN'),
('Demir','Hayrioğlu','54125632501','04.11.2000',63,'E','05314562103','demirhayrioglu@outlook.com','Karabucak,4, 7570, Demre/Istanbul',31,'BN'),
('Recep','Akdoğan','21452365892','05.06.2010',63,'E','05364521122','recepakdogan@hotmail.com','Doğanli,6, 13002, Merkez/Istanbul,',32,'BP'),
('Emre','Ayberk','12542036521','04.07.1985',56,'E','05632145899','ayberkemre@outlook.com','Terziler,12, 67960, Çaycuma/Istanbul',33,'AN'),
('Kerime','Hacer','10236521452','11.12.2021',90,'K','05314562233','kerimehacerrr@gmail.com','Kavak Yazisi,15, 14030, Merkez/Istanbul',34,'BP'),
('Ercüment','Akıncılar','12542362014','12.10.1963',91,'E','05624587799','ercumentak@hotmail.com','Balikçil,3, 46300, Elbistan/Istanbul',35,'ABN'),
('Sarper','Akış','12547856962','12.11.1964',62,'E','05314589966','sarper12@hotmail.com','Habiboğlu,20, 67802, Devrek/Istanbul',36,'ABP'),
('Berker','Akkiray','98563214585','09.04.1947',88,'E','05214587458','berkerakkiray@hotmail.com','Arapdede Köyü,5, 11802, Pazaryeri/Istanbul',37,'0P'),
('İclal','Akkoyun','68954125632','03.10.1974',77,'K','05321456958','iclalakkoyun21@hotmail.com','Sağanci,30, 35700, Bergama/Istanbul',38,'0N'),
('Ali','Samet','68954752145','03.07.1964',65,'E','05310236523','alisamet@hotmail.com','Çat,10, 2602, Çelikhan/Istanbul',39,'ABP'),
('Doğan','Akfırat','25478596521','03.01.1970',65,'E','05314587796','doganakfirat@hotmail.com','Sirganlik,1, 29832, Kürtün/Istanbul',40,'BN'),
('Gizem','Akıllı','25632145874','03.01.1963',45,'K','05361452211','akiligizem@gmail.com','Yarimburgaz,28, 34303, Küçükçekmece/Istanbul',41,'BP'),
('Elif','Altinkaya','12541256321','05.06.2010',56,'K','05624125632','elifaltinkaya@gmail.com','Savcilli,22, 9670, Buharkent/Istanbul',42,'AP'),
('Sırma','Altunbaş','12563214523','06.11.2006',54,'K','05318745623','sirmaaltunbas@gmail.com','Eminli,22, 29832, Kürtün/Istanbul',43,'BN'),
('Nefse','Altunbulak','12563214523','03.07.2003',65,'K','05316982145','nefsealtunbulak@hotmail.com','Gölyazi,1, 55600, Terme/Istanbul',44,'AP'),
('Büşra','Altundal','12563214521','09.11.2007',54,'K','05314562103','busraaltundal@gmail.com','Topsakal,2, 65900, Gürpinar/Istanbul',45,'AN'),
('Erna','Aluç','12563214583','03.09.2010',64,'K','05320321020','ernaaluc@hotmail.com','Akköy,13, 38800, Yeşilhisar/Istanbul',46,'AN'),
('Hikmet','Alver','12563214587','09.07.2001',72,'E','05302130321','hikmetalver@gmail.com','Sariyar,6, 19000, Merkez/Istanbul',47,'AN'),
('İsmail','Anık','12541230254','03.01.2011',67,'E','05319648596','ismailanik@hotmail.com','Esenevler,22, 80010, Merkez/Istanbul',48,'AP'),
('İlkay','Ankara','12563214589','07.09.2005',100,'E','05365412985','ilkayankara@hotmail.com','Sürek Köyü,4, 24402, Kemah/Istanbul',49,'AN'),
('Ramazan','Umut','12563214587','03.04.2007',120,'E','05314569854','ramazanumutt54@gmail.com','Yeşilpinar Köyü,20, 28612, Yağlidere/Istanbul',50,'AP'),
('Murat','Ayaz','12541256321','12.05.2010',65,'E','05315426565','muratayvaz@gmail.com','Dolma,2, 23802, Baskil/Istanbul',51,'AP'),
('Ateş','Aycı','96325874125','12.06.1956',56,'E','05345621212','atesavci@hotmail.com','Pinar Pazari,4, 32500, Eğirdir/Istanbul',52,'AP'),
('Zeynep','Aydınlıoğlu','20312036521','03.02.1945',102,'K','05215624512','zeynepaydinlioglu@gmail.com','Kirkişla,18, 42850, Cihanbeyli/Istanbul',53,'AP'),
('Kerime','Aydoğan','63201254896','04.06.1978',68,'K','05365478569','kerimeaydogan@outlook.com','Haciahmetler,14, 14782, Göynük/Istanbul',54,'AN'),
('Hami','Aydoğdu','63203214520','06.07.1986',96,'E','05365478569','hamiaydogdu@hotmail.com','Özbaği Köyü,34, 58302, Divriği/Istanbul',55,'AN'),
('Thomas','Aygen','52012365214','03.03.1949',88,'E','05314523021','thomasaygen@gmail.com','Palamutoba Köyü,19, 17722, Bayramiç/Istanbul',56,'AN'),
('Güneş','Aykan','52032145632','06.07.1950',92,'K','05310232154','gunesaykan@gmail.com','Kadi,14, 37210, Merkez/Istanbul',57,'BN'),
('Elif','Ayrım','85214520365','10.10.1960',98,'K','05311025632','elifayrim@gmail.com','Saca,6, 52300, Ünye/Istanbul',58,'BN'),
('Uğur','Aysal','63203214523','11.11.1970',103,'E','05320213232','uguraysal52@gmail.com','Post,13, 12702, Solhan/Istanbul',59,'BN'),
('Osman','Yasin','96320152365','12.12.1980',115,'E','05365412323','osmanyasin@gmail.com','Akinci Köyü,17, 28000, Merkez/Istanbul',60,'BN'),
('Adem','Ayvacık','85236541258','11.10.1984',56,'E','05312036598','ademayvacik@gmail.com','Düverdüzü Köyü,27, 81060, Merkez/Istanbul',61,'BP'),
('Serra','Azbay','96523014521','11.11.1952',59,'K','05324587451','serraazbay@gmail.com','Bahçelievler,30, 40322, Akpinar/Istanbul',62,'BN'),
('Ali','Babacan','85214569854','05.05.2003',87,'E','05314589896','alibabacan@gmail.com','Ağaçli Köyü,22, 2702, Gerger/Istanbul',63,'BN'),
('Sinan','İsmail','96547852141','07.01.1972',78,'E','05314788585','sinanismail@hotmail.com','Ebeköy,18, 16900, Yenişehir/Istanbul',64,'ABP'),
('Nihan','Yozgat','52145632012','01.05.1970',69,'K','05365412536','nihanyozgat@gmail.com','Kocaömer(Yuvanin),1, 19902, Kargi/Istanbul',65,'ABN'),
('Ali','Feyza','96541254125','08.09.1970',87,'E','05314523636','alifeyza@gmail.com','Koçköy Köyü,22, 66802, Şefaatli/Istanbul',66,'0N'),
('İsmail','Cansın','41021452365','03.08.1997',98,'E','05323203237','ismailcansin@hotmail.com','Memnuniye,13, 54600, Sapanca/Istanbul',67,'0P')



Create Table Ilaclar
(
BarkodID int primary key identity(1,1) NOT NULL,
IlacAdi nvarchar(150) NOT NULL,
İcerikBilgi nvarchar(250),
Fiyat decimal(18,2)
)

INSERT Ilaclar VALUES ('Paracetamol Ped.','Şurup, Sinir Sitemi, Analjezik','16.77'),
('Gastopal 680 MG/80 MG 48 Çiğneme Tableti','Sindirim Sistemi ve Metabolizma kategorisinde ve A02 MİDE sınıfında bulunur.','29.40'),
('Kortos Krem 30 GR','Kalp ve Damar Sistemi kategorisinde ve C05 Vazoprotektiflersınıfında bulunur.','50.28'),
('Paxera 20 MG 56','Sinir Sistemi kategorisinde ve Psikoanaleptikler sınıfında bulunur.',' 91.53'),
('Bemiks C Film Kaplı Tablet','Sindirim Sistemi ve Metabolizma kategorisinde ve Vitaminler sınıfında bulunur.','79.03'),
('Matisse 100 mg Film Kaplı Tablet','Sinir Sitemi kategorisinde ve ANTİEPİLEPTİKLER sınıfında bulunur.',' 413.32'),
('JIVI 1000 IU IV Enjeksionluk Çözelti Hazırlamak İçin Toz Ve Çözücü','Kan ve Kan Yapıcı Organlar kategorisinde ve ANTİHEMORAJİKLER sınıfında bulunur. ','5477.27'),
('ANLEV 1000 MG Film Kaplı Tablet','Sinir Sistemi kategorisinde ve ANTİEPİLEPTİKLER sınıfında bulunur.','344.36'),
('BENEFIX 1000 IU IV enjeksiyonluk çözelti için toz ve çözücü','Kan ve Yapıcı Organlar kategorisinde ve ANTİHEMORAJİKLER sınıfında bulunur.','6962.69'),
('CERTİCAN Tablet 0.25 mg 60 tablet','Antineoplastik ve İmmünomodülatör Ajanlar kategorisinde ve İMMÜNOSÜPRESANLAR sınıfında bulunur.','807.16'),
('DEXOJECT. ®. 8 mg/ 2 ml IM/IV Enjeksiyonluk Çözelti içeren Ampül','Endokrin Sistem (Cinsiyet Hormonları ve İnsülin Hariç) kategorisinde ve SİSTEMİK KORTİKOSTEROİDLER sınıfında bulunur.','9.44'),
('EXCALIBA PLUS 40 mg/ 10 mg/ 12.5 mg film kaplı tablet (28 tablet)','Kalp Damar Sistemi kategorisinde ve Renin Anjiyotensin Sistemi sınıfında bulunur. ','85.12'),
('FEBIND 500 mg suda dağılabilen 28 tablet ','Çeşitli kategorisinde ve Diğer Tüm Terapötikler sınıfında bulunur.','3111.50'),
('GLUCERNA 1.5 KCAL çilek aromalı 220 ml','TİTCK listesindeki ATC kodu V06DB ve ATC adı fat/carbohydrates/proteins/minerals/vitamins combinations.','21.29'),
('HOLOXAN 1 G IV infüzyonluk çözelti hazırlamak için toz Barkodu','Antineoplastik ve İmminomodülatör Ajanlar kategorisinde Antineoplastikler sınıfında bulunur.','414.34 '),
('INGLEX 120 mg 84 film tablet','Sindirim Sistemi ve Metabolizma kategorisinde ve Diyabet İlaçları sınıfında bulunur.','147.42'),
('JINARC 30 mg 28 tablet ',' JİNARC, “otozomal dominant polikistik böbrek hastalığı” (ADPKD) isimli hastalığın tedavisi için kullanılır.Kalp ve Damar Sistemi kategorisinde ve DİÜRETIKLER sınıfında bulunur.','10609.40'),
('KADCYLA 160 mg IV inf. çözelti konsantresi için toz içeren flakon','Antineoplastik ve İmmünomodülatör Ajanlar kategorisinde ve Antineoplastikler sınıfında bulunur.','15712.16'),
('LIPVAKOL 20 mg film tablet (28 tablet)','Kalp ve Damar Sistemi kategorisinde ve Lipid Metabolizmasına Etkili İlaçlar sınıfında bulunur.','21.29'),
('MIKROSID 30 Tablet','Antiefektifler(Sistemik) kategorisinde ve Sistemik AntiBakteriyeller sınıfında bulunur.','19.78'),
('NORM-ASİDOZ 1000 mg gastro rezistan tablet','Kan ve Kan Yapıcı Organlar kategorisinde ve Kan ve Perfüzyon Solüsyonları sınıfında bulunur.','336.20'),
('OCREVUS 300 mg/ 10ml infüzyonluk çözelti hazırlamak için konsantre (1 flakon) ',' Multipl Skleroz (MS) formlarının tedavisinde kullanılır. Antineoplastik ve İmminomodülatör Ajanlar kategorisinde ve İmmünosüpresanlar sınıfında bulunur.','34899.12'),
('POLTEOFILIN 200 IV inf. için enjektabl çözelti 100 ml setli','Solunum Sistemi kategorisinde ve Obstrüktis Solunum Sistemi Hastalıkları sınıfında bulunur.','29.31 '),
('ROACCUTANE 20 mg 30 kapsül','Dermatolojikler kategorisinde ve Akne İlaçları sınıfında bulunur.','159.64'),
('SODKOLIS 4.500.000 IU IM/IV enjeksiyonluk ve inhalasyonluk çözelti hazırlamak için liyofilize toz ve çözücü ','Antienfektifler (Sistemik) kategorisinde ve Sistemik Antibakteiyeller sınıfında bulunur.','165.61'),
('Timabak % 0,25 5 Ml Göz Damlası',' Duyu Organları kategorisinde ve Oftalmolojik İlaçlar sınıfında bulunur. ','45.25'),
('UREDERM %20 Krem','Dermatolojikler kategorisinde ve Yumuşatıcı ve Koruyucular sınıfında bulunur.','15.11'),
('VAGİFEM® 25 mikrogram film kaplı vajinal tablet','Ürogenital Sistem ve Cinsiyet Hormonları kategorisinde ve Cinsiyet Hormonları - Genital Sistem Modülatörleri sınıfında bulunur.','206.69'),
('XETANOR 20 MG 30 Tablet','Sinir Sistemi kategorisinde ve Psikoanaleptikler sınıfında bulunur.','48.79'),
('Yasmin 21 Film Tablet','Ürogenital Sistem ve Cinsiyet Hormonları kategorisinde ve Cinsiyet Hormonları - Genital Sistem Modülatörleri sınıfında bulunur.','97.06'),
('DESAL 40 MG 12 Tablet','Kalp ve Damar Sistemi kategorisinde ve Diüretikler sınıfında bulunur.','12.14'),
('ZALAIN % 2 20 gr Krem','Dermatolojikler kategorisinde ve Dermatolojik Antifungallarsınıfında bulunur.','33.04'),
('Zinko','Çinko eksikliğinin önlenmesinde ve tedavisinde, çinko emilim bozukluğunda (akrodermatitis enteropatika) ve vücutta aşırı derecede bakır birikmesi hastalığında (Wilson) kullanılır.','99.99'),
('Iburamin Cold','Solunum Sistemi Kategorisinde Nazal İlaçlar sınıfında bulunur','31.46'),
('Majezik 100 mg 30 Film','İskelet Sistemi kategorisinde ve Antienflamatuar ve Antiromatikler sınıfında bulunur.','40.64')

Create Table Randevu
(
RandevuID int primary key identity(1,1) NOT NULL,
HastaID int foreign key references Hasta(HastaID) not null,
DoktorID int foreign key references Doktorlar(DoktorID) NOT NULL,
Sikayet nvarchar(250),
Teshis nvarchar(250),
Tedavi nvarchar(250)
)


insert Randevu Values
(34,1,'Aşırı Ağlama','Kolik','İlaçla Tedavi'),
(20,1,'Aşı','Kızamık Aşısı','Aşı yapıldı'),
(48,1,'Ateş','Grip','İlaçla Tedavi'),
(21,1,'Kırmızı Benek','Kızamık','İlaçla Tedavi'),
(51,1,'Ağrılı Kulak','Kabakulak','İlaçla Tedavi'),
(42,1,'Öksürük','Akut Faranjit','İlaçla Tedavi'),
(32,1,'Geceleri altını ıslatma','Tanımlanmamış','İdrar Tahlili,Ultrason'),
(46,1,'İshal,Ateş,Öksürük','Covid19','İlaçla Tedavi'),
(3,2,'Sivilce','Yoğun akne gözlemi','İlaçla Tedavi'),
(4,2,'Ciltte kuruluk','Yoğun Kuruluk','İlaçla Tedavi'),
(6,2,'Sivilce','Yoğun Akne','İlaçla Tedavi'),
(9,2,'Deride kabarma','Alerjik Reaksiyon','Alerji testi'),
(10,2,'Siğil','Genital Siğil','HPV testi, Ameliyat için gün verildi'),
(13,2,'Ben','Anormal büyüklükte venüs','Cilt kanseri süphesiyle parça alınması için gün verildi'),
(14,2,'Kaşıntı','Ürtiker','Alerji testi'),
(15,3,'Kollarda Ağrı','Kireçlenme','Fizik Tedavi sevk'),
(16,3,'Bel Ağrısı','Bel Fıtığı','Fizik Tedavi sevk'),
(17,3,'Kolda yumru','Kolda Tanımlanmamış yumru','Ameliyat için gün verildi'),
(18,3,'Dizlerde Ağrı','Romatizma','İlaçla Tedavi'),
(19,3,'Bacakta ağrı','Varis','Ameliyat günü verildi'),
(20,3,'Bacakta Ağrı','Menisküs yırtığı','Ameliyat günü verildi'),
(22,3,'Düşme','Kırık','Ameliyata alındı'),
(47,3,'Manisküs yırtığı sebebiyle sevk','Artroskopi','Ameliyat günü verildi'),
(49,3,'Bacak eşitsizliği','Fonksiyonel eşitsizlik','Ameliyat günü verildi'),
(50,3,'Boy kısalığı','','Ameliyat günü verildi'),
(52,3,'Dizde kireçlenme sebebiyle sevk','Dizde Kireçlenme','Protez ameliyatı günü verildi'),
(53,3,'Sevk','Obeziteye bağlı Dizde Baskı','Ameliyat günü verildi'),
(54,3,'Elde ağrı','Elde kırık tedavisinin yanlış yapılması sebebiyle mikrocerrahi gerekli','ameliyat günü verildi'),
(31,4,'Halsizlik, hızlı kilo kaybı,aşırı su tüketimi','Diyabet','İlaçla tedavi'),
(32,4,'Aşırı Kilo','Obezite','Diyetisyene sevk, Hormon testleri istendi'),
(34,4,'Parmaklarda el ve ayaklarda büyüme','Hipofiz Bozuklukları','İlaçla Tedavi'),
(35,4,'Ses inceliği','Hormon Dengesizliği','İlaçla Tedavi'),
(36,4,'Boyunda şişlik','Guatr','İlaçla Tedavi'),
(37,4,'Gebelik dışında memelerden süt gelmesi','Prolaktin Dengesizliği','İlaçla Tedavi'),
(38,4,'İştahsızlık, halsizlik, güçsüzlük,kas güçsüzlüğü, kemik ağrısı','Paratiroid','İlaçla Tedavi'),
(30,4,'Halsizlik, hızlı kilo kaybı,aşırı su tüketimi','Diyabet','İlaçla tedavi'),
(63,5,'Skolyoz sebebiyle sevk','Skolyoz','Tedavi programı oluşturuldu'),
(64,5,'FSM sebebiyle sevk','Fibromiyalji','Tedavi programı oluşturuldu'),
(65,5,'MAS sebebiyle sevk','Miyofasiyal','Tedavi programı oluşturuldu'),
(66,5,'Bel fıtığı sebebiyle sevk','Fıtık','Tedavi programı oluşturuldu'),
(67,5,'Spazm sebebiyle sevk','Kas Spazmı','Tedavi programı oluşturuldu'),
(60,5,'Romatizma sebebiyle sevk','Romatizma','Tedavi programı oluşturuldu'),
(33,6,'Kemiklerde Ağrı','Osteoporoz',',İlaçla Tedavi'),
(43,7,'Göğüs ağrısı, kalp sesinin azalması','Perikard Tamponadı','İlaçla tedavi'),
(45,7,'Baş ağrısı, baş dönmesi, halsizlik, burun kanaması','Hpiertansiyon','İlaçla Tedavi'),
(55,8,'Bulanık Görme','Astigmat','Gözlük'),
(56,8,'Uzağı net görememe','Miyopi','Gözlük'),
(57,8,'Yakını net görememe','Hipermetrop','Gözlük'),
(59,8,'Görmede kararma','Katarakt','Ameliyat günü verildi'),
(60,8,'Çapaklanma','Konjoktivit','İlaçla Tedavi'),
(61,8,'Gözde ağrı','Glokom','İlaçla tedavi'),
(62,8,'Gözde rahatsızlık, batma hissi, kaşıntı','Blefarit','İlaçla tedavi'),
(23,9,'Öksürük','Akut Faranjit','İlaçla Tedavi'),
(24,9,'Halsizlik','D vitami eksikliği','İlaçla Tedavi'),
(25,9,'Eklem Ağrısı','D vitamini eksikliği','İlaçla Tedavi'),
(26,9,'Öksürük,Halsizlik','Covid19','İlaçla Tedavi'),
(27,9,'Burun Akıntısı, Öksürük','Mevsimsel Alerji','İlaçla tedavi, alerji testi için cildiyeye sevk'),
(28,9,'Vitamin değerlerinin kontrolu','Anemi','İlaçla Tedavi'),
(29,9,'İshal','Tanımlanmamış','Crohn şüphesiyle genel cerrahiye sevk'),
(1,10,'Vajinal Akıntı', 'Mantar Enfeksiyonu','İlaçla Tedavi, Fitil'),
(2,10,'Ağrılı Adet','Polikistik Over','İlaçla Tedavi, Doğum Kontrol Hapı'),
(5,10,'Genital Siğil','HPV','Genel Cerrahiye sevk'),
(7,10,'Adet Gecikmesi','Polikistik Over','İlacla Tedavi,Doğum Kontrol Hapı'),
(8,10,'Gebelik','Gebelik 2. ay','Folik Asit takviyesi,Ultrosonla kontrol'),
(11,10,'Gebelik Kontrol','Düşük','Kürtajla rahmin temizlenmesi'),
(12,10,'Gebelik kontrol','Gebelik 8. ay','Ultrasonla kontrol, sezeryanla doğum için gün verildi'),
(39,11,'Göğüs ağrısı, göğüste sıkışma hissi','Aort Darlığı','Ameliyat günü verildi'),
(40,11,'Nefes darlığı, göğüste ağrı','Mitral Kapak Yetmezliği','İlaçla Tedavi'),
(41,11,'Kalp çarpıntısı, ritim bozukluğu, göğüs ağrısı','Mitral kapak darlığı','Ameliyat günü verildi'),
(43,11,'Çarpıntı','Kardiyak Aritmi','İlaçla Tedavi'),
(44,11,'Göğüs Ağrısı','İskemik Kalp Hastalığı','Ameliyat günü verildi')



Create Table ReceteDetay
(
ReceteID int primary key identity(1,1) NOT NULL,
RandevuID int foreign key references Randevu(RandevuID) not null,--71
IlacAdet int NOT NULL,
IlacDozu nvarchar(50) NOT NULL,
KullanımSekli nvarchar(50),
BarkodNo int foreign key references Ilaclar(BarkodID) --35
)

Insert ReceteDetay Values
(1,1,'1x1','Oral',33),
(3,1,'1x2','Oral',34),
(4,1,'1x2','Oral',34),
(5,1,'1x2','Oral',34),
(6,1,'1x2','Oral',34),
(8,1,'1x2','Oral',34),
(9,1,'1x2','Oral',24),
(10,1,'1x3','Krem',27),
(11,1,'1x2','Oral',24),
(19,1,'1x2','Oral',35),
(29,1,'1x2','Enj',23),
(31,1,'1x2','Oral',8),
(32,1,'Haftada bir','Enj',11),
(33,1,'1x2','Oral',31),
(34,1,'15 günde bir','Enj',11),
(35,1,'1x2','Oral',5),
(36,1,'1x3','Oral',16),
(43,1,'1x2','Oral',1),
(44,1,'1x2','Oral',19),
(45,1,'1x3','Oral',21),
(50,1,'1x3','Damla',26),
(51,1,'1x3','Damla',26),
(52,1,'1x3','Damla',26),
(53,1,'1','Topikal',2),
(54,1,'1x2','Oral',5),
(55,1,'1x2','Oral',6),
(56,1,'1x1','Enj',7),
(57,1,'1x2','Oral',8),
(58,1,'1x1','Toz',9),
(60,1,'Gün Aşırı','Fitil',28),
(61,1,'1x1','Oral',30),
(63,1,'1x1','Oral',30),
(68,1,'1x1','Oral',31),
(70,1,'1x1','Oral',31)





Create Table RandevuDetay
(
RandevuID int foreign key references Randevu(RandevuID) NOT NULL,
RandevuTarihi date,
RandevuSaati time,
HastaGeldimi nvarchar(1),
YeniRandevuTarihi date
)

Insert RandevuDetay Values
(1,'03.11.2022','08:30:00','E',''),
(2,'03.11.2022','09:00:00','E',''),
(3,'03.11.2022','09:15:00','E',''),
(4,'03.11.2022','09:30:00','E',''),
(5,'03.11.2022','09:45:00','E',''),
(6,'03.11.2022','10:00:00','E',''),
(7,'03.11.2022','10:15:00','E',''),
(8,'03.11.2022','10:30:00','E',''),
(9,'03.11.2022','08:30:00','E',''),
(10,'03.11.2022','09:00:00','E',''),
(11,'03.11.2022','09:30:00','E',''),
(12,'03.11.2022','10:00:00','E',''),
(13,'03.11.2022','10:30:00','E',''),
(14,'03.11.2022','11:00:00','E',''),
(15,'03.11.2022','11:30:00','E',''),
(16,'03.11.2022','08:30:00','E',''),
(17,'03.11.2022','09:00:00','E',''),
(18,'03.11.2022','09:30:00','E',''),
(19,'03.11.2022','10:00:00','E',''),
(20,'03.11.2022','10:30:00','E',''),
(21,'03.11.2022','11:00:00','E',''),
(22,'03.11.2022','11:30:00','E',''),
(23,'03.11.2022','12:00:00','E',''),
(24,'03.11.2022','12:30:00','E',''),
(25,'03.11.2022','13:30:00','E',''),
(26,'03.11.2022','14:00:00','E',''),
(27,'03.11.2022','14:30:00','E',''),
(28,'03.11.2022','15:00:00','E',''),
(29,'03.11.2022','08:30:00','E',''),
(30,'03.11.2022','09:00:00','E',''),
(31,'03.11.2022','09:30:00','E',''),
(32,'03.11.2022','10:00:00','E',''),
(33,'03.11.2022','10:30:00','E',''),
(34,'03.11.2022','11:00:00','E',''),
(35,'03.11.2022','11:30:00','E',''),
(36,'03.11.2022','12:00:00','E',''),
(37,'03.11.2022','08:30:00','E',''),
(38,'03.11.2022','09:00:00','E',''),
(39,'03.11.2022','09:30:00','E',''),
(40,'03.11.2022','10:00:00','E',''),
(41,'03.11.2022','10:30:00','E',''),
(42,'03.11.2022','11:00:00','E',''),
(43,'03.11.2022','09:00:00','E',''),
(44,'03.11.2022','08:30:00','E',''),
(45,'03.11.2022','09:00:00','E',''),
(46,'03.11.2022','08:30:00','E',''),
(47,'03.11.2022','09:00:00','E',''),
(48,'03.11.2022','09:30:00','E',''),
(49,'03.11.2022','10:00:00','E',''),
(50,'03.11.2022','10:30:00','E',''),
(51,'03.11.2022','11:00:00','E',''),
(52,'03.11.2022','11:30:00','E',''),
(53,'03.11.2022','12:00:00','E',''),
(54,'03.11.2022','12:30:00','E',''),
(55,'03.11.2022','13:30:00','E',''),
(55,'03.11.2022','14:00:00','E',''),
(56,'03.11.2022','14:30:00','E',''),
(57,'03.11.2022','15:00:00','E',''),
(58,'03.11.2022','15:30:00','E',''),
(59,'03.11.2022','16:00:00','E',''),
(60,'03.11.2022','08:30:00','E',''),
(61,'03.11.2022','09:00:00','E',''),
(62,'03.11.2022','09:30:00','E',''),
(63,'03.11.2022','10:00:00','E',''),
(64,'03.11.2022','10:30:00','E','')

-------------------------JOINLER---------------------------
/*
-->Hastanede çalışan personellerin kan gruplarını getiren sorgu
select PersonelAdi,PersonelSoyadi,KanGrubuTuru 
from Personel 
join KanGrubu on Personel.KanGrubuID =kangrubu.KanGrubuID
*/
/*
-->iznini 5 günden fazla kullanan personelin personel adı soyadı id telefon meslek
select p.PersonelID, p.PersonelAdi,p.PersonelSoyadi,p.TelefonNo,m.Meslekturu,DAtediff(day,i.IzinBaslangic,i.IzinBitis) as [Izin Gun Sayisi]
from Izinler i 
Join Personel p ON i.PersonelID=p.PersonelID 
Join Meslek m ON p.MeslekID=m.MeslekID 
Group BY p.PersonelID, p.PersonelAdi,p.PersonelSoyadi,p.TelefonNo,m.Meslekturu, DAtediff(day,i.IzinBaslangic,i.IzinBitis)
Having DAtediff(day,i.IzinBaslangic,i.IzinBitis)>5
*/
/*
-->ID'si 1 olan doktora giden 18 yaş altı hastaların adı ve soyadı, doktor adı ve soyadı ve eğer alerjisi varsa alerji bilgisi
select h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi],hg.Alerjiler,p.PersonelAdi+' '+P.PersonelSoyadi as [Doktor Adi ve Soyadi]
from Hasta h 
join HastaGecmisi hg on h.HastaGecmisiID=hg.HastaGecmisiID 
join Randevu r on h.HastaID=r.HastaID 
join Doktorlar dr on r.DoktorID=dr.DoktorID 
join Personel p on dr.PersonelID=p.PersonelID where dr.DoktorID=1
group by h.HastaAdi,h.HastaSoyadi,hg.Alerjiler,p.PersonelAdi,P.PersonelSoyadi,datediff(year,h.DogumTarihi,getdate()) 
Having datediff(year,h.DogumTarihi,getdate())<18  order by h.HastaAdi
*/
/*
-->Kan grubu AP olan doktorların adı soyadi,TCKNO,Tel,Adres ve hastalarının adı ve soyadı
select h.HastaAdi+' '+h.HastaSoyadi as [Hasta Adı Soyadi], h.TCKN,h.KanGrubuID,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi soyadi],p.TelefonNo 
from Hasta h 
join KanGrubu kg on h.KanGrubuID=kg.KanGrubuID 
join Randevu r on h.HastaID=r.HastaID 
join Doktorlar dr on r.DoktorID=dr.DoktorID 
join Personel p on dr.PersonelID=p.PersonelID 
where h.KanGrubuID like 'AP'
*/
/*
-->Ameliyat olacak hastaların teşhisi, kullandığı ilaçları, ameliyat edecek doktoru hastaların ismine göre listeleyen sorgu
select h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi],r.Teshis,hg.KullandigiIlac,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi Soyadi] 
from Hasta h 
join Randevu r on h.HastaID=r.HastaID 
join Doktorlar dr on r.DoktorID=dr.DoktorID 
join HastaGecmisi hg on h.HastaGecmisiID=hg.HastaGecmisiID 
join Personel p on dr.PersonelID=p.PersonelID 
where Tedavi like 'ameliyat%'
order by h.HastaAdi+ ' '+h.HastaSoyadi
*/
/*
--18 yaş altı hastalardan 1 IDli doktora gidenlerin adı ve soyadı, doktor adı ve soyadı, alerji bilgisi
select h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi],hg.Alerjiler,p.PersonelAdi+' '+P.PersonelSoyadi as [Doktor Adi ve Soyadi]
 from Hasta h 
join HastaGecmisi hg on h.HastaGecmisiID=hg.HastaGecmisiID 
join Randevu r on h.HastaID=r.HastaID 
join Doktorlar dr on r.DoktorID=dr.DoktorID 
join Personel p on dr.PersonelID=p.PersonelID 
where dr.DoktorID=1
group by h.HastaAdi,h.HastaSoyadi,hg.Alerjiler,p.PersonelAdi,P.PersonelSoyadi,datediff(year,h.DogumTarihi,getdate()) 
Having datediff(year,h.DogumTarihi,getdate())<18  
order by h.HastaAdi
*/
/*
--Başka bölüme sevk edilen hastaların sevk edildikleri bölüm ve doktorları
select h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi], pk.PoliklinkAdi,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi Soyadi] 
from hasta h join Randevu r on h.HastaID=r.HastaID 
join Doktorlar dr on r.DoktorID=dr.DoktorID 
join Poliklinik pk on dr.PoliklinikID=pk.PoliklinikID 
join Personel p on dr.PersonelID=p.PersonelID 
where r.Sikayet like '%sevk%'
*/
-----------------------FUNCTION---------------------
/*
--> ID si verilen doktorun ismini getiren fonksiyon
CREATE FUNCTION fn_DoktorAdiSoyadi
(@doktorID int)
RETURNS nvarchar(100)
AS
BEGIN
	declare @doktorAdiSoyadi nvarchar(100)
	select @doktorAdiSoyadi=(p.personeladi + ' ' + p.personelsoyadi)
	from doktorlar d
	join personel p on d.personelId=p.personelID
	where d.doktorID=@doktorID
	
	RETURN @doktorAdiSoyadi
END

select dbo.fn_DoktorAdiSoyadi(22)

*/
/*
-->ID si verilen poliklinik adını getirir
CREATE FUNCTION fn_PoliklinikAdi
(@doktorID int)
RETURNS nvarchar(50)
AS
BEGIN
	declare @poliklinikAdi nvarchar(50)
	select @poliklinikAdi=p.PoliklinkAdi
	from doktorlar d
	join poliklinik p on d.poliklinikId=p.poliklinikId
	where d.doktorID=@doktorID
	
	RETURN @poliklinikAdi
END

select dbo.fn_PoliklinikAdi(5)

*/
------------------------PROCEDURE-------------------
/*
--aynı hasta için 1 güne 2 randevu verilmesin
create proc sp_yeni_randevu_giris(
@RandevuTarihi2 date,
@RandevuSaati2 time(7),
@HastaGeldimi nvarchar(1),
@YeniRandevuTarihi date
)
AS
BEGIN
If exists (Select * from RandevuDetay where RandevuSaati=@RandevuSaati2 and RandevuTarihi=@RandevuTarihi2)
	begin 
		print 'Hastanın Aynı Saatte Başka bir randevusu var'
	end
else
	begin 
		insert RandevuDetay(RandevuTarihi,RandevuSaati,YeniRandevuTarihi,HastaGeldimi) values (@RandevuTarihi2,@RandevuSaati2,@YeniRandevuTarihi,@HastaGeldimi)
	end
END
 exec sp_yeni_randevu_giris '03.11.2022','08:30','e',''
 exec sp_yeni_randevu_giris '03.11.2022','08:30','e',''

 select * from RandevuDetay

 */

 /*
--Daha önceden sisteme kayıtlı olup oladığını sorgulayıp ona göre hasta kaydı yapan prosedür
go
create proc sp_hastakayıt
(
@HastaAdi nvarchar (50),
@HastaSoyadi nvarchar(50),
@TCKN char(11),
@DogumTarihi date,
@Kilo decimal(18,2),
@Cinsiyet nvarchar(1),
@HastaTelefonNo char(12),
@HastaMail nvarchar(50),
@HastaAdres nvarchar (200),
@KanGrubuID nvarchar(5))
as
begin
	if exists (select * from Hasta where TCKN= @TCKN)
	begin 
		print 'Hasta sistemde kayıtlıdır!'
	end
else
	begin
		insert Hasta(HastaAdi,HastaSoyadi,TCKN,DogumTarihi,Kilo,Cinsiyet,HastaTelefonNo,HastaMail,HastaAdres,KanGrubuID) values (@HastaAdi,@HastaSoyadi,@TCKN,@dogumtarihi,@kilo,@cinsiyet,@HastaTelefonNo,@hastamail,@hastaadres,@kangrubuID)
	end
end

go
exec sp_hastakayıt 'ali','ahmet','14725836987','01.01.2000',50,'e','05321523652','aabbcc@gmail.com','asfdfa',an
--TC kayıtlı olduğu için kayıt olunur.
exec sp_hastakayıt 'ali','ahmet','14725836988','01.01.2000',50,'e','05321523652','aabbcc@gmail.com','asfdfa',an
--Aynı Tc ile daha önce kayıt olduğu için hayıt olunamaz ve hata mesajı yazdırır.
*/
-----------------------TRIGGERLAR------------

/* 
-->Personel tablosuna yeni veri eklendiğinde meslekID=1 ise doktor tablosuna da kayıt yapmaya yarayan trigger
--NOT:Daha önce çalıştı ama sonradan denediğimde olmadı.Bunun sebebi Doktorlar tablosunda PoliklinikID'nin NOT Null olması olabilir diye orayı düzelttim ama sonuç alamadım. 
go
create trigger trg_DoktorEkleme on Personel
after insert
as 
declare @PersonelID int,@PoliklinikID int,@MeslekID int
select @PersonelID=PersonelID from inserted
if(@MeslekID=1)
Begin
insert Doktorlar values(@PoliklinikID,@PersonelID) 

end
go

insert Personel values(1,'Nur','Altan','52827193515','05.07.1987','K','(537)4445578','nur.altan@mail.com','Selam Mahallesi,Pınar Caddesi,Akşam Apartmanı,Daire:2,İstanbul','08.08.2017','Lisans','AP',1)

select*from personel
select * from Doktorlar 
*/

/*
Hastaların sistemden silinmesini engelleyen trigger
create trigger trg_HastaSilmeEngelleme on Hasta
instead of delete 
as
declare @HastaID int
select @HastaID=HastaID from deleted
if(@HastaID=@HastaID)
  begin
    Print 'Hastalar Sistemden Silinemez'
  end
 else
   begin
     delete from Hasta where HastaID=@HastaID
   end
go
delete from Hasta where HastaID=1
*/


----------------VIEWLER---------------
/*
--Çocuk Sağlığı ve Hastalığı doktor ve hastalarını veren view
create view vw_CocukSagligiveHastaligi as select pk.PoliklinkAdi,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi Soyadi],h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi] 
from Poliklinik pk 
join Doktorlar dr on pk.PoliklinikID=dr.PoliklinikID 
join Randevu r on dr.DoktorID=r.DoktorID 
join Hasta h on r.HastaID=h.HastaID 
join Personel p on p.PersonelID=dr.PersonelID 
where pk.PoliklinikID=1

select * from vw_CocukSagligiveHastaligi
*/
/*
--Cildiye doktor ve hastalarını veren view
create view vw_Cildiye as select pk.PoliklinkAdi,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi Soyadi],h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi] 
from Poliklinik pk 
join Doktorlar dr on pk.PoliklinikID=dr.PoliklinikID 
join Randevu r on dr.DoktorID=r.DoktorID 
join Hasta h on r.HastaID=h.HastaID j
oin Personel p on p.PersonelID=dr.PersonelID 
where pk.PoliklinikID=2

select * from vw_Cildiye
*/
/*
--Ortopedi ve Travmatoloji doktor ve hastalarını veren view
create view vw_OrtopediveTravmatoloji as select pk.PoliklinkAdi,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi Soyadi],h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi] 
from Poliklinik pk 
join Doktorlar dr on pk.PoliklinikID=dr.PoliklinikID 
join Randevu r on dr.DoktorID=r.DoktorID 
join Hasta h on r.HastaID=h.HastaID 
join Personel p on p.PersonelID=dr.PersonelID
where pk.PoliklinikID=3

select * from vw_OrtopediveTravmatoloji

/*
--Ortopedi ve Travmatoloji doktor ve hastalarını veren view

create view vw_EndokrinolojiveMetaboliz as select pk.PoliklinkAdi,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi Soyadi],h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi] 
from Poliklinik pk 
join Doktorlar dr on pk.PoliklinikID=dr.PoliklinikID 
join Randevu r on dr.DoktorID=r.DoktorID 
join Hasta h on r.HastaID=h.HastaID 
join Personel p on p.PersonelID=dr.PersonelID 
where pk.PoliklinikID=4

select * from vw_EndokrinolojiveMetaboliz
*/

/*
--create view vw_FizikTedaviveRehabilitasyon as select pk.PoliklinkAdi,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi Soyadi],h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi] 
from Poliklinik pk 
join Doktorlar dr on pk.PoliklinikID=dr.PoliklinikID 
join Randevu r on dr.DoktorID=r.DoktorID 
join Hasta h on r.HastaID=h.HastaID 
join Personel p on p.PersonelID=dr.PersonelID 
where pk.PoliklinikID=5

select * from vw_FizikTedaviveRehabilitasyon

*/
/*
--Genel Cerrahi doktor ve hastalarını veren view
create view vw_GenelCerrahi as select pk.PoliklinkAdi,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi Soyadi],h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi] 
from Poliklinik pk 
join Doktorlar dr on pk.PoliklinikID=dr.PoliklinikID 
join Randevu r on dr.DoktorID=r.DoktorID 
join Hasta h on r.HastaID=h.HastaID 
join Personel p on p.PersonelID=dr.PersonelID 
where pk.PoliklinikID=6

select * from vw_GenelCerrahi
*/
/*
--Gögüs Cerrahisi doktor ve hastalarını veren view
create view vw_GogusCerrahisi as select pk.PoliklinkAdi,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi Soyadi],h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi] 
from Poliklinik pk 
join Doktorlar dr on pk.PoliklinikID=dr.PoliklinikID 
join Randevu r on dr.DoktorID=r.DoktorID 
join Hasta h on r.HastaID=h.HastaID 
join Personel p on p.PersonelID=dr.PersonelID 
where pk.PoliklinikID=7

select * from vw_GogusCerrahisi
*/
/*
--Göz Sağlığı ve Hastalıkları doktor ve hastalarını veren view
create view vw_GozSagligiveHastalikleri as select pk.PoliklinkAdi,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi Soyadi],h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi] 
from Poliklinik pk 
join Doktorlar dr on pk.PoliklinikID=dr.PoliklinikID 
join Randevu r on dr.DoktorID=r.DoktorID 
join Hasta h on r.HastaID=h.HastaID 
join Personel p on p.PersonelID=dr.PersonelID 
where pk.PoliklinikID=8

select * from vw_GozSagligiveHastalikleri
*/
/*
--İç Hastaliklari doktor ve hastalarını veren view
create view vw_IcHastaliklari as select pk.PoliklinkAdi,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi Soyadi],h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi]
from Poliklinik pk 
join Doktorlar dr on pk.PoliklinikID=dr.PoliklinikID 
join Randevu r on dr.DoktorID=r.DoktorID 
join Hasta h on r.HastaID=h.HastaID 
join Personel p on p.PersonelID=dr.PersonelID 
where pk.PoliklinikID=9


select * from vw_IcHastaliklari

*/
/*
--Kadin Hastaliklari ve Doğum doktor ve hastalarını veren view
create view vw_KadinHastaliklariveDogum as select pk.PoliklinkAdi,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi Soyadi],h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi] 
from Poliklinik pk 
join Doktorlar dr on pk.PoliklinikID=dr.PoliklinikID 
join Randevu r on dr.DoktorID=r.DoktorID 
join Hasta h on r.HastaID=h.HastaID 
join Personel p on p.PersonelID=dr.PersonelID 
where pk.PoliklinikID=10

select * from vw_KadinHastaliklariveDogum
*/
/*
--Kardiyoloji doktor ve hastalarını veren view
create view vw_Kardiyoloji as select pk.PoliklinkAdi,p.PersonelAdi+' '+p.PersonelSoyadi as [Doktor Adi Soyadi],h.HastaAdi+ ' '+h.HastaSoyadi as [Hasta Adi Soyadi] 
from Poliklinik pk 
join Doktorlar dr on pk.PoliklinikID=dr.PoliklinikID 
join Randevu r on dr.DoktorID=r.DoktorID 
join Hasta h on r.HastaID=h.HastaID 
join Personel p on p.PersonelID=dr.PersonelID 
where pk.PoliklinikID=11

select * from vw_Kardiyoloji
*/
