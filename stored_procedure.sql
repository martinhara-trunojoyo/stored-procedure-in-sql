-- belajar mengenai stored procedure
USE umkm_jawa_barat;

-- membuat sp yang melihat seluruh data pemilik umkm di jabar
DELIMITER //
CREATE PROCEDURE sp_pemilik ()

BEGIN 

SELECT * FROM pemilik_umkm;

END //

DELIMITER ;

CALL sp_pemilik();

-- stored procedure yang memiliki parameter in
-- parameter in akan digunakan untuk mencari tahun berdirinya sebuah umkm
-- select nama_usaha, alamat_usaha, tahun_berdiri from umkm where tahun_berdiri = 2018;

DELIMITER //

CREATE PROCEDURE sp_GetUmkmByYear (IN tahun YEAR)

BEGIN 

SELECT nama_usaha, alamat_usaha, tahun_berdiri FROM umkm WHERE tahun_berdiri = tahun;

END //

DELIMITER ;

CALL sp_GetUmkmByYear (2010);

-- coba menggunakan int

DELIMITER //

CREATE PROCEDURE sp_GetUmkmByYear2 (IN tahun INT)

BEGIN 

SELECT nama_usaha, alamat_usaha, tahun_berdiri FROM umkm WHERE tahun_berdiri = tahun;

END //

DELIMITER ;

CALL sp_GetUmkmByYear2 (2010);


-- mengisikan tabel menggunakan stored procedure

-- insert into kategori_umkm (nama_kategori, deskripsi) values ( "Kriya","Umkm Kriya")

DELIMITER //

CREATE PROCEDURE sp_InsertKategoriUmkm ( IN nama VARCHAR(100), IN deksripsi TEXT(300))
BEGIN

INSERT INTO kategori_umkm (nama_kategori, deskripsi) VALUES (nama,deksripsi);

END//

DELIMITER;

CALL sp_InsertKategoriUmkm ("akik","Umkm yang bergerak pada bidang usaha batu akik");

SELECT * FROM kategori_umkm;


-- parameter out 
-- mengecek berapa banyak kategori umkm yang ada di tabel kategori

DELIMITER //

CREATE PROCEDURE sp_OutJumlahKategori (OUT jumlah INT)

BEGIN

SELECT COUNT(id_kategori) INTO jumlah FROM kategori_umkm;

END //

DELIMITER ;

CALL sp_OutJumlahKategori (@jumlah);

SELECT @jumlah AS jumlah_kategori;


-- parameter inout
-- cek tahun berdiri menggunakan inout return = jumlah umkm yang berdiri ditahun yang sama

-- pendekatan pertama
DELIMITER //

CREATE PROCEDURE sp_GetUmkmByYear3 (INOUT tahun INT)

BEGIN 

SELECT COUNT(tahun_berdiri)INTO tahun FROM umkm WHERE tahun_berdiri = tahun;
 
END //

DELIMITER ;

SET @tahun = 2018;

CALL sp_GetUmkmByYear3 (@tahun)

SELECT @tahun AS umkm_yang_berdiri_pada_2018;

-- drop procedure sp_GetUmkmByYear4

-- pendekatan inout kedua

DELIMITER //

CREATE PROCEDURE sp_GetUmkmByYear4 (IN tahun INT, OUT jumlah INT)

BEGIN

SELECT COUNT(tahun_berdiri) INTO jumlah FROM umkm WHERE tahun_berdiri = tahun ;

END //

DELIMITER ;

CALL sp_GetUmkmByYear4 (2019,@jumlah)

SELECT @jumlah AS umkm_yang_berdiri_pada_2019;
SELECT nama_usaha FROM umkm WHERE tahun_berdiri = 2019 ;
