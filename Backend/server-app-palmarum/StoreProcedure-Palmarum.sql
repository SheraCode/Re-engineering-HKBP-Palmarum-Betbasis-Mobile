DELIMITER 
//

CREATE PROCEDURE GetJemaat(IN jemaat_id INT)
BEGIN
    SELECT
        j.id_jemaat,
        j.nama_depan,
        j.nama_belakang,
        j.jenis_kelamin,
        j.alamat,
        j.id_bidang_pendidikan,
        j.id_pekerjaan,
        j.no_hp,
        j.isBaptis,
        j.isSidi,
        j.isMenikah,
        j.isMeninggal,
        j.keterangan,
        j.id_pendidikan
    FROM
        jemaat j
    WHERE
        j.id_jemaat = jemaat_id;
END//

DELIMITER ;






DELIMITER //

CREATE PROCEDURE UpdateJemaatProcedure(
    IN jemaatID INT,
    IN namaDepan VARCHAR(225),
    IN namaBelakang VARCHAR(225),
    IN jenisKelamin VARCHAR(225),
    IN alamat VARCHAR(455),
    IN idBidangPendidikan INT,
    IN idPekerjaan INT,
    IN noHP VARCHAR(225),
    IN isBaptis VARCHAR(225),
    IN isMenikah VARCHAR(225),
    IN isMeninggal VARCHAR(225),
    IN keterangan VARCHAR(500),
    IN email VARCHAR(225),
    IN PASSWORD VARCHAR(225),
    IN bidangPendidikanLainnya VARCHAR(225),
    IN namaPekerjaanLainnya VARCHAR(225)
)
BEGIN
    UPDATE jemaat SET
        nama_depan = namaDepan,
        nama_belakang = namaBelakang,
        jenis_kelamin = jenisKelamin,
        alamat = alamat,
        id_bidang_pendidikan = idBidangPendidikan,
        id_pekerjaan = idPekerjaan,
        no_hp = noHP,
        isBaptis = isBaptis,
        isMenikah = isMenikah,
        isMeninggal = isMeninggal,
        keterangan = keterangan,
        email = email,
        PASSWORD = PASSWORD,
        bidang_pendidikan_lainnya = bidangPendidikanLainnya,
        nama_pekerjaan_lainnya = namaPekerjaanLainnya
    WHERE id_jemaat = jemaatID;
END //

DELIMITER ;



DELIMITER //
CREATE PROCEDURE GetImageNameFromDatabaseProcedure(IN jemaatID VARCHAR(50), OUT imageName VARCHAR(255))
BEGIN
    SELECT foto_jemaat INTO imageName FROM jemaat WHERE id_jemaat = jemaatID;
    
    IF imageName IS NULL THEN
        SET imageName = 'image not found';
    END IF;
END //
DELIMITER ;


DELIMITER //

CREATE PROCEDURE LoginProcedure(
    IN userEmail VARCHAR(100),
    IN userPassword VARCHAR(100),
    OUT jemaatID INT,
    OUT jemaatNamaDepan VARCHAR(100),
    OUT jemaatNamaBelakang VARCHAR(100),
    OUT jemaatEmail VARCHAR(100),
    OUT jemaatAlamat TEXT,
    OUT jemaatFotoJemaat VARCHAR(255),
    OUT idHubKeluarga INT, 
    OUT namaHubKeluarga VARCHAR(100),
    OUT nomorhp INT -- Tetapkan tipe data menjadi INT
)
BEGIN
    DECLARE rowCount INT DEFAULT 0;
    
    -- Hitung jumlah baris yang sesuai dengan email dan password yang diberikan
    SELECT COUNT(*) INTO rowCount FROM jemaat WHERE email = userEmail AND PASSWORD = userPassword;
    
    -- Jika ada baris yang sesuai, ambil data jemaat, id_hub_keluarga, nama_hub_keluarga, dan no_hp dari hubungan_keluarga
    IF rowCount = 1 THEN
        SELECT j.id_jemaat, j.nama_depan, j.nama_belakang, j.email, j.alamat, j.foto_jemaat, h.id_hub_keluarga, h.nama_hub_keluarga, j.no_hp
        INTO jemaatID, jemaatNamaDepan, jemaatNamaBelakang, jemaatEmail, jemaatAlamat, jemaatFotoJemaat, idHubKeluarga, namaHubKeluarga, nomorhp
        FROM jemaat j
        INNER JOIN hubungan_keluarga h ON j.id_hub_keluarga = h.id_hub_keluarga
        WHERE j.email = userEmail AND j.PASSWORD = userPassword;
    ELSE
        -- Jika tidak ada baris yang sesuai, set nilai NULL untuk output
        SET jemaatID = NULL;
        SET jemaatNamaDepan = NULL;
        SET jemaatNamaBelakang = NULL;
        SET jemaatEmail = NULL;
        SET jemaatAlamat = NULL;
        SET jemaatFotoJemaat = NULL;
        SET idHubKeluarga = NULL;
        SET namaHubKeluarga = NULL;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'invalid credentials';
    END IF;
END //

DELIMITER ;

-- login yang dipakek

DELIMITER //

CREATE PROCEDURE LoginProcedure(
    IN userEmail VARCHAR(100),
    IN userPassword VARCHAR(100),
    OUT jemaatID INT,
    OUT jemaatNamaDepan VARCHAR(225),
    OUT jemaatNamaBelakang VARCHAR(225),
    OUT jemaatEmail VARCHAR(225),
    OUT jemaatPassword VARCHAR(225),
    OUT jemaatGelarDepan VARCHAR(225),
    OUT jemaatGelarBelakang VARCHAR(225),
    OUT jemaatTempatLahir VARCHAR(50),
    OUT jemaatJenisKelamin VARCHAR(225),
    OUT jemaatIDHubKeluarga INT,
    OUT jemaatIDStatusPernikahan INT,
    OUT jemaatIDStatusAmaIna INT,
    OUT jemaatIDStatusAnak INT,
    OUT jemaatIDPendidikan INT,
    OUT jemaatIDBidangPendidikan INT,
    OUT jemaatBidangPendidikanLainnya VARCHAR(225),
    OUT jemaatIDPekerjaan INT,
    OUT jemaatNamaPekerjaanLainnya VARCHAR(225),
    OUT jemaatGolDarah VARCHAR(225),
    OUT jemaatAlamat VARCHAR(455),
    OUT jemaatIsSidi VARCHAR(225),
    OUT jemaatIDKecamatan INT,
    OUT jemaatNoTelepon INT,
    OUT jemaatNoHP INT,
    OUT jemaatFotoJemaat VARCHAR(500),
    OUT jemaatKeterangan VARCHAR(500),
    OUT jemaatIsBaptis VARCHAR(225),
    OUT jemaatIsMenikah VARCHAR(225),
    OUT jemaatIsMeninggal VARCHAR(225),
    OUT jemaatIsRPP VARCHAR(225),
    OUT jemaatCreateAt TIMESTAMP,
    OUT jemaatUpdateAt TIMESTAMP,
    OUT jemaatIsDeleted TIMESTAMP
)
BEGIN
    DECLARE rowCount INT DEFAULT 0;

    -- Hitung jumlah baris yang sesuai dengan email dan password yang diberikan
    SELECT COUNT(*) INTO rowCount FROM jemaat WHERE email = userEmail AND PASSWORD = userPassword;

    -- Jika ada baris yang sesuai, ambil data jemaat
    IF rowCount = 1 THEN
        SELECT id_jemaat, nama_depan, nama_belakang, email, PASSWORD, gelar_depan, gelar_belakang, tempat_lahir,
               jenis_kelamin, id_hub_keluarga, id_status_pernikahan, id_status_ama_ina, id_status_anak, id_pendidikan,
               id_bidang_pendidikan, bidang_pendidikan_lainnya, id_pekerjaan, nama_pekerjaan_lainnya, gol_darah,
               alamat, isSidi, id_kecamatan, no_telepon, no_hp, foto_jemaat, keterangan, isBaptis, isMenikah,
               isMeninggal, isRPP, create_at, update_at, is_deleted
        INTO jemaatID, jemaatNamaDepan, jemaatNamaBelakang, jemaatEmail, jemaatPassword, jemaatGelarDepan,
             jemaatGelarBelakang, jemaatTempatLahir, jemaatJenisKelamin, jemaatIDHubKeluarga, jemaatIDStatusPernikahan,
             jemaatIDStatusAmaIna, jemaatIDStatusAnak, jemaatIDPendidikan, jemaatIDBidangPendidikan,
             jemaatBidangPendidikanLainnya, jemaatIDPekerjaan, jemaatNamaPekerjaanLainnya, jemaatGolDarah, jemaatAlamat,
             jemaatIsSidi, jemaatIDKecamatan, jemaatNoTelepon, jemaatNoHP, jemaatFotoJemaat, jemaatKeterangan,
             jemaatIsBaptis, jemaatIsMenikah, jemaatIsMeninggal, jemaatIsRPP, jemaatCreateAt, jemaatUpdateAt, jemaatIsDeleted
        FROM jemaat
        WHERE email = userEmail AND PASSWORD = userPassword;
    ELSE
        -- Jika tidak ada baris yang sesuai, kembalikan NULL untuk semua output
        SET jemaatID = NULL;
        SET jemaatNamaDepan = NULL;
        SET jemaatNamaBelakang = NULL;
        SET jemaatEmail = NULL;
        SET jemaatPassword = NULL;
        SET jemaatGelarDepan = NULL;
        SET jemaatGelarBelakang = NULL;
        SET jemaatTempatLahir = NULL;
        SET jemaatJenisKelamin = NULL;
        SET jemaatIDHubKeluarga = NULL;
        SET jemaatIDStatusPernikahan = NULL;
        SET jemaatIDStatusAmaIna = NULL;
        SET jemaatIDStatusAnak = NULL;
        SET jemaatIDPendidikan = NULL;
        SET jemaatIDBidangPendidikan = NULL;
        SET jemaatBidangPendidikanLainnya = NULL;
        SET jemaatIDPekerjaan = NULL;
        SET jemaatNamaPekerjaanLainnya = NULL;
        SET jemaatGolDarah = NULL;
        SET jemaatAlamat = NULL;
        SET jemaatIsSidi = NULL;
        SET jemaatIDKecamatan = NULL;
        SET jemaatNoTelepon = NULL;
        SET jemaatNoHP = NULL;
        SET jemaatFotoJemaat = NULL;
        SET jemaatKeterangan = NULL;
        SET jemaatIsBaptis = NULL;
        SET jemaatIsMenikah = NULL;
        SET jemaatIsMeninggal = NULL;
        SET jemaatIsRPP = NULL;
        SET jemaatCreateAt = NULL;
        SET jemaatUpdateAt = NULL;
        SET jemaatIsDeleted = NULL;
    END IF;
END //

DELIMITER ;

-- batas login yang di pakai


-- login coba coba (role)
DELIMITER //

CREATE PROCEDURE LoginProcedure(
    IN userEmail VARCHAR(100),
    IN userPassword VARCHAR(100),
    OUT jemaatID INT,
    OUT rolejemaat VARCHAR(225),
    OUT jemaatNamaDepan VARCHAR(225),
    OUT jemaatNamaBelakang VARCHAR(225),
    OUT jemaatEmail VARCHAR(225),
    OUT jemaatPassword VARCHAR(225),
    OUT jemaatGelarDepan VARCHAR(225),
    OUT jemaatGelarBelakang VARCHAR(225),
    OUT jemaatTempatLahir VARCHAR(50),
    OUT jemaatJenisKelamin VARCHAR(225),
    OUT jemaatIDHubKeluarga INT,
    OUT jemaatIDStatusPernikahan INT,
    OUT jemaatIDStatusAmaIna INT,
    OUT jemaatIDStatusAnak INT,
    OUT jemaatIDPendidikan INT,
    OUT jemaatIDBidangPendidikan INT,
    OUT jemaatBidangPendidikanLainnya VARCHAR(225),
    OUT jemaatIDPekerjaan INT,
    OUT jemaatNamaPekerjaanLainnya VARCHAR(225),
    OUT jemaatGolDarah VARCHAR(225),
    OUT jemaatAlamat VARCHAR(455),
    OUT jemaatIsSidi VARCHAR(225),
    OUT jemaatIDKecamatan INT,
    OUT jemaatNoTelepon INT,
    OUT jemaatNoHP INT,
    OUT jemaatFotoJemaat VARCHAR(500),
    OUT jemaatKeterangan VARCHAR(500),
    OUT jemaatIsBaptis VARCHAR(225),
    OUT jemaatIsMenikah VARCHAR(225),
    OUT jemaatIsMeninggal VARCHAR(225),
    OUT jemaatIsRPP VARCHAR(225),
    OUT jemaatCreateAt TIMESTAMP,
    OUT jemaatUpdateAt TIMESTAMP,
    OUT jemaatIsDeleted TIMESTAMP
)
BEGIN
    DECLARE rowCount INT DEFAULT 0;

    -- Hitung jumlah baris yang sesuai dengan email dan password yang diberikan
    SELECT COUNT(*) INTO rowCount FROM jemaat WHERE email = userEmail AND PASSWORD = userPassword;

    -- Jika ada baris yang sesuai, ambil data jemaat
    IF rowCount = 1 THEN
        SELECT id_jemaat, role_jemaat,nama_depan, nama_belakang, email, PASSWORD, gelar_depan, gelar_belakang, tempat_lahir,
               jenis_kelamin, id_hub_keluarga, id_status_pernikahan, id_status_ama_ina, id_status_anak, id_pendidikan,
               id_bidang_pendidikan, bidang_pendidikan_lainnya, id_pekerjaan, nama_pekerjaan_lainnya, gol_darah,
               alamat, isSidi, id_kecamatan, no_telepon, no_hp, foto_jemaat, keterangan, isBaptis, isMenikah,
               isMeninggal, isRPP, create_at, update_at, is_deleted
        INTO jemaatID, rolejemaat,jemaatNamaDepan, jemaatNamaBelakang, jemaatEmail, jemaatPassword, jemaatGelarDepan,
             jemaatGelarBelakang, jemaatTempatLahir, jemaatJenisKelamin, jemaatIDHubKeluarga, jemaatIDStatusPernikahan,
             jemaatIDStatusAmaIna, jemaatIDStatusAnak, jemaatIDPendidikan, jemaatIDBidangPendidikan,
             jemaatBidangPendidikanLainnya, jemaatIDPekerjaan, jemaatNamaPekerjaanLainnya, jemaatGolDarah, jemaatAlamat,
             jemaatIsSidi, jemaatIDKecamatan, jemaatNoTelepon, jemaatNoHP, jemaatFotoJemaat, jemaatKeterangan,
             jemaatIsBaptis, jemaatIsMenikah, jemaatIsMeninggal, jemaatIsRPP, jemaatCreateAt, jemaatUpdateAt, jemaatIsDeleted
        FROM jemaat
        WHERE email = userEmail AND PASSWORD = userPassword;
    ELSE
        -- Jika tidak ada baris yang sesuai, kembalikan NULL untuk semua output
        SET jemaatID = NULL;
        SET rolejemaat = NULL;
        SET jemaatNamaDepan = NULL;
        SET jemaatNamaBelakang = NULL;
        SET jemaatEmail = NULL;
        SET jemaatPassword = NULL;
        SET jemaatGelarDepan = NULL;
        SET jemaatGelarBelakang = NULL;
        SET jemaatTempatLahir = NULL;
        SET jemaatJenisKelamin = NULL;
        SET jemaatIDHubKeluarga = NULL;
        SET jemaatIDStatusPernikahan = NULL;
        SET jemaatIDStatusAmaIna = NULL;
        SET jemaatIDStatusAnak = NULL;
        SET jemaatIDPendidikan = NULL;
        SET jemaatIDBidangPendidikan = NULL;
        SET jemaatBidangPendidikanLainnya = NULL;
        SET jemaatIDPekerjaan = NULL;
        SET jemaatNamaPekerjaanLainnya = NULL;
        SET jemaatGolDarah = NULL;
        SET jemaatAlamat = NULL;
        SET jemaatIsSidi = NULL;
        SET jemaatIDKecamatan = NULL;
        SET jemaatNoTelepon = NULL;
        SET jemaatNoHP = NULL;
        SET jemaatFotoJemaat = NULL;
        SET jemaatKeterangan = NULL;
        SET jemaatIsBaptis = NULL;
        SET jemaatIsMenikah = NULL;
        SET jemaatIsMeninggal = NULL;
        SET jemaatIsRPP = NULL;
        SET jemaatCreateAt = NULL;
        SET jemaatUpdateAt = NULL;
        SET jemaatIsDeleted = NULL;
    END IF;
END //

DELIMITER ;

-- batas login yang di pakek





DELIMITER //

CREATE PROCEDURE UpdateJemaatProfileProcedure(
    IN jemaatID INT,
    IN namaDepan VARCHAR(225),
    IN namaBelakang VARCHAR(225),
    IN tempatLahir VARCHAR(225),
    IN noHP VARCHAR(225),
    IN alamat VARCHAR(455),
    IN email VARCHAR(225)
)
BEGIN
    UPDATE jemaat SET
        nama_depan = namaDepan,
        nama_belakang = namaBelakang,
        tempat_lahir = tempatLahir,
        no_hp = noHP,
        alamat = alamat,
        email = email
    WHERE id_jemaat = jemaatID;
END //

DELIMITER ;




CALL GetWaktuKegiatan
DELIMITER //

CREATE PROCEDURE GetWaktuKegiatan()
BEGIN
    SELECT id_waktu_kegiatan, id_jenis_kegiatan, id_gereja, nama_kegiatan, lokasi_kegiatan, waktu_kegiatan, foto_kegiatan, keterangan
    FROM waktu_kegiatan;
END//

DELIMITER ;


DELIMITER //

CREATE PROCEDURE GetWaktuKegiatanByID(IN id INT)
BEGIN
    SELECT id_waktu_kegiatan, id_jenis_kegiatan, id_gereja, nama_kegiatan, lokasi_kegiatan, waktu_kegiatan, foto_kegiatan, keterangan
    FROM waktu_kegiatan
    WHERE id_waktu_kegiatan = id;
END//

DELIMITER ;

CALL GetWaktuKegiatanByID(59)



DELIMITER //

CREATE PROCEDURE GetWaktuKegiatanHome()
BEGIN
    SELECT id_waktu_kegiatan, id_jenis_kegiatan, id_gereja, nama_kegiatan, lokasi_kegiatan, waktu_kegiatan,foto_kegiatan, keterangan
    FROM waktu_kegiatan
    ORDER BY id_waktu_kegiatan DESC
    LIMIT 5;
END//

DELIMITER ;






DELIMITER //

CREATE PROCEDURE LoginProcedure(
    IN userEmail VARCHAR(100),
    IN userPassword VARCHAR(100),
    OUT jemaatID INT,
    OUT jemaatNamaDepan VARCHAR(225),
    OUT jemaatNamaBelakang VARCHAR(225),
    OUT jemaatEmail VARCHAR(225),
    OUT jemaatPassword VARCHAR(225),
    OUT jemaatGelarDepan VARCHAR(225),
    OUT jemaatGelarBelakang VARCHAR(225),
    OUT jemaatTempatLahir VARCHAR(50),
    OUT jemaatJenisKelamin VARCHAR(225),
    OUT jemaatIDHubKeluarga INT,
    OUT jemaatIDStatusPernikahan INT,
    OUT jemaatIDStatusAmaIna INT,
    OUT jemaatIDStatusAnak INT,
    OUT jemaatIDPendidikan INT,
    OUT jemaatIDBidangPendidikan INT,
    OUT jemaatBidangPendidikanLainnya VARCHAR(225),
    OUT jemaatIDPekerjaan INT,
    OUT jemaatNamaPekerjaanLainnya VARCHAR(225),
    OUT jemaatGolDarah VARCHAR(225),
    OUT jemaatAlamat VARCHAR(455),
    OUT jemaatIsSidi VARCHAR(225),
    OUT jemaatIDKecamatan INT,
    OUT jemaatNoTelepon INT,
    OUT jemaatNoHP INT,
    OUT jemaatFotoJemaat VARCHAR(500),
    OUT jemaatKeterangan VARCHAR(500),
    OUT jemaatIsBaptis VARCHAR(225),
    OUT jemaatIsMenikah VARCHAR(225),
    OUT jemaatIsMeninggal VARCHAR(225),
    OUT jemaatIsRPP VARCHAR(225),
    OUT jemaatCreateAt TIMESTAMP,
    OUT jemaatUpdateAt TIMESTAMP,
    OUT jemaatIsDeleted TIMESTAMP,
    OUT isMajelis BOOL -- Output untuk menunjukkan apakah pengguna adalah bagian dari majelis atau tidak
)
BEGIN
    DECLARE rowCount INT DEFAULT 0;
    DECLARE isMajelisTemp BOOL DEFAULT FALSE; -- Variabel sementara untuk menandai status majelis
    
    -- Hitung jumlah baris yang sesuai dengan email dan password yang diberikan
    SELECT COUNT(*) INTO rowCount FROM jemaat WHERE email = userEmail AND PASSWORD = userPassword;
    
    -- Jika ada baris yang sesuai, ambil data jemaat dan periksa status majelis
    IF rowCount = 1 THEN
        -- Ambil data jemaat
        SELECT * INTO jemaatID, jemaatNamaDepan, jemaatNamaBelakang, jemaatEmail, jemaatPassword, 
                      jemaatGelarDepan, jemaatGelarBelakang, jemaatTempatLahir, jemaatJenisKelamin, 
                      jemaatIDHubKeluarga, jemaatIDStatusPernikahan, jemaatIDStatusAmaIna, jemaatIDStatusAnak, 
                      jemaatIDPendidikan, jemaatIDBidangPendidikan, jemaatBidangPendidikanLainnya, jemaatIDPekerjaan, 
                      jemaatNamaPekerjaanLainnya, jemaatGolDarah, jemaatAlamat, jemaatIsSidi, jemaatIDKecamatan, 
                      jemaatNoTelepon, jemaatNoHP, jemaatFotoJemaat, jemaatKeterangan, jemaatIsBaptis, jemaatIsMenikah, 
                      jemaatIsMeninggal, jemaatIsRPP, jemaatCreateAt, jemaatUpdateAt, jemaatIsDeleted
        FROM jemaat
        WHERE email = userEmail AND PASSWORD = userPassword;
        
        -- Periksa apakah jemaat adalah bagian dari majelis
        SELECT COUNT(*) INTO isMajelisTemp FROM majelis WHERE id_jemaat = jemaatID;
        
        -- Set variabel isMajelis
        IF isMajelisTemp = 1 THEN
            SET isMajelis = TRUE;
        ELSE
            SET isMajelis = FALSE;
        END IF;
    ELSE
        -- Jika tidak ada baris yang sesuai, kembalikan NULL untuk semua output
        SET jemaatID = NULL;
        SET jemaatNamaDepan = NULL;
        SET jemaatNamaBelakang = NULL;
        SET jemaatEmail = NULL;
        SET jemaatPassword = NULL;
        SET jemaatGelarDepan = NULL;
        SET jemaatGelarBelakang = NULL;
        SET jemaatTempatLahir = NULL;
        SET jemaatJenisKelamin = NULL;
        SET jemaatIDHubKeluarga = NULL;
        SET jemaatIDStatusPernikahan = NULL;
        SET jemaatIDStatusAmaIna = NULL;
        SET jemaatIDStatusAnak = NULL;
        SET jemaatIDPendidikan = NULL;
        SET jemaatIDBidangPendidikan = NULL;
        SET jemaatBidangPendidikanLainnya = NULL;
        SET jemaatIDPekerjaan = NULL;
        SET jemaatNamaPekerjaanLainnya = NULL;
        SET jemaatGolDarah = NULL;
        SET jemaatAlamat = NULL;
        SET jemaatIsSidi = NULL;
        SET jemaatIDKecamatan = NULL;
        SET jemaatNoTelepon = NULL;
        SET jemaatNoHP = NULL;
        SET jemaatFotoJemaat = NULL;
        SET jemaatKeterangan = NULL;
        SET jemaatIsBaptis = NULL;
        SET jemaatIsMenikah = NULL;
        SET jemaatIsMeninggal = NULL;
        SET jemaatIsRPP = NULL;
        SET jemaatCreateAt = NULL;
        SET jemaatUpdateAt = NULL;
        SET jemaatIsDeleted = NULL;
        SET isMajelis = FALSE; -- Set isMajelis ke FALSE jika kredensial tidak valid
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Invalid credentials';
    END IF;
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE tambah_data_kegiatan(
    IN jenis_kegiatan_id INT,
    IN gereja_id INT,
    IN kegiatan_nama VARCHAR(225),
    IN kegiatan_lokasi VARCHAR(225),
    IN kegiatan_foto VARCHAR(400),
    IN keterangan TEXT
)
BEGIN
    INSERT INTO waktu_kegiatan (id_jenis_kegiatan, id_gereja, nama_kegiatan, lokasi_kegiatan, foto_kegiatan, keterangan)
    VALUES (jenis_kegiatan_id, gereja_id, kegiatan_nama, kegiatan_lokasi, kegiatan_foto, keterangan);
END //
DELIMITER ;


CALL tambah_data_kegiatan(1, 1, 'Kegiatan Test', 'Lokasi Test', '2024-04-10 08:00:00', 'foto_test.jpg', 'Keterangan Test');

SELECT foto_kegiatan FROM waktu_kegiatan WHERE id_waktu_kegiatan = 20


-- getAllWarta
DELIMITER //

CREATE PROCEDURE GetDataWarta()
BEGIN
    SELECT id_warta, warta, create_at FROM warta;
END //

DELIMITER ;


CALL GetDataWarta()

-- getWartaByID
DELIMITER //

CREATE PROCEDURE GetWartaByID(IN id_warta_param INT)
BEGIN
    SELECT id_warta, warta, create_at FROM warta WHERE id_warta = id_warta_param;
END //

DELIMITER ;

CALL GetWartaByID(1)

-- getWartaHome
DELIMITER //

CREATE PROCEDURE GetDataWartaHome()
BEGIN
    SELECT id_warta, warta, create_at FROM warta
    ORDER BY create_at DESC
    LIMIT 5;
END //

DELIMITER ;

-- warta
DELIMITER //

CREATE PROCEDURE CreateWarta(IN warta_text TEXT)
BEGIN
    INSERT INTO warta (warta) VALUES (warta_text);
END //

DELIMITER ;



DELIMITER //

CREATE PROCEDURE GetPelayanGereja ()
BEGIN
  SELECT 
    majelis.*,
    pelayan_gereja.nama_pelayan,
    status.status
  FROM 
    majelis
  INNER JOIN 
    pelayan_gereja ON majelis.id_pelayan = pelayan_gereja.id_pelayan
  INNER JOIN 
    STATUS ON majelis.id_status_pelayan = status.id_status;
END//

DELIMITER ;

CALL GetPelayanGereja



SELECT p.nama_pelayanan_ibadah, p.keterangan, j.sesi_ibadah, j.tgl_ibadah
FROM pelayan_ibadah PI
INNER JOIN pelayanan_ibadah p ON pi.id_pelayanan_ibadah = p.id_pelayanan_ibadah
INNER JOIN jadwal_ibadah j ON pi.id_jadwal_ibadah = j.id_jadwal_ibadah
WHERE j.tgl_ibadah >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 DAY);



DELIMITER //

CREATE PROCEDURE GetPelayanIbadahData()
BEGIN
    SELECT pi.id_pelayanan_ibadah, pi.id_jadwal_ibadah, p.nama_pelayanan_ibadah, p.keterangan, j.sesi_ibadah, j.tgl_ibadah
    FROM pelayan_ibadah PI
    INNER JOIN pelayanan_ibadah p ON pi.id_pelayanan_ibadah = p.id_pelayanan_ibadah
    INNER JOIN jadwal_ibadah j ON pi.id_jadwal_ibadah = j.id_jadwal_ibadah
    WHERE j.tgl_ibadah >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 DAY);
END//

DELIMITER ;


DROP PROCEDURE GetPelayanIbadahData

-- READ PELAYAN_IBADAH
DELIMITER //

CREATE PROCEDURE ReadPelayananIbadah()
BEGIN
    SELECT id_pelayanan_ibadah, nama_pelayanan_ibadah, keterangan, create_at ,is_deleted, update_at
    FROM pelayanan_ibadah;
END//

DELIMITER ;


-- UPDATE PELAYAN_IBADAH
DELIMITER //

CREATE PROCEDURE EditPelayananIbadah(
    IN p_id_pelayanan_ibadah INT,
    IN p_nama_pelayanan_ibadah VARCHAR(225),
    IN p_keterangan TEXT
)
BEGIN
    UPDATE pelayanan_ibadah
    SET nama_pelayanan_ibadah = p_nama_pelayanan_ibadah,
        keterangan = p_keterangan,
        update_at = CURRENT_TIMESTAMP
    WHERE id_pelayanan_ibadah = p_id_pelayanan_ibadah;
END//

DELIMITER ;


CALL GetPelayanIbadahData()

SELECT j.id_jadwal_ibadah, jm.nama_jenis_minggu, j.tgl_ibadah, j.sesi_ibadah, j.keterangan
FROM jadwal_ibadah j
INNER JOIN jenis_minggu jm ON j.id_jenis_minggu = jm.id_jenis_minggu;


DELIMITER //

CREATE PROCEDURE GetJadwalIbadah()
BEGIN
    SELECT j.id_jadwal_ibadah, jm.nama_jenis_minggu, j.tgl_ibadah, j.sesi_ibadah, j.keterangan, j.id_jenis_minggu
    FROM jadwal_ibadah j
    INNER JOIN jenis_minggu jm ON j.id_jenis_minggu = jm.id_jenis_minggu;
END//

DELIMITER ;

CALL GetJadwalIbadah()


DELIMITER //

CREATE PROCEDURE EditJadwalIbadah(
    IN p_id_jadwal_ibadah INT,
    IN p_id_jenis_minggu INT,
    IN p_tgl_ibadah VARCHAR(225),
    IN p_sesi_ibadah VARCHAR(225),
    IN p_keterangan TEXT
)
BEGIN
    UPDATE jadwal_ibadah
    SET id_jenis_minggu = p_id_jenis_minggu,
        tgl_ibadah = p_tgl_ibadah,
        sesi_ibadah = p_sesi_ibadah,
        keterangan = p_keterangan,
        update_at = CURRENT_TIMESTAMP
    WHERE id_jadwal_ibadah = p_id_jadwal_ibadah;
END//

DELIMITER ;



-- INSERT data pelayan_ibadah
DELIMITER //

CREATE PROCEDURE CreatePelayanIbadahData(
 p_id_jadwal_ibadah INT,
    p_id_pelayanan_ibadah INT,
    p_keterangan VARCHAR(255)
)
BEGIN
    INSERT INTO pelayan_ibadah (id_jadwal_ibadah, id_pelayanan_ibadah, keterangan)
    VALUES (p_id_jadwal_ibadah, p_id_pelayanan_ibadah, p_keterangan);
END//

DELIMITER ;

CALL CreatePelayanIbadahData(2,3,'Song Leader')

DROP PROCEDURE CreatePelayanIbadahData


-- CREATE pelayanan_ibadah
DELIMITER //

CREATE PROCEDURE CreatePelayananIbadahData(
    p_nama_pelayanan_ibadah VARCHAR(255),
    p_keterangan VARCHAR(255)
)
BEGIN
    INSERT INTO pelayanan_ibadah (nama_pelayanan_ibadah, keterangan)
    VALUES (p_nama_pelayanan_ibadah, p_keterangan);
END//

DELIMITER ;

CALL CreatePelayananIbadahData('Duta', 'Singer');


-- create pelayan gereja data
DELIMITER //

CREATE PROCEDURE CreatePelayanGerejaData(
    p_nama_pelayan VARCHAR(255),
    p_keterangan TEXT
)
BEGIN
    INSERT INTO pelayan_gereja (nama_pelayan, keterangan)
    VALUES (p_nama_pelayan, p_keterangan);
END//

DELIMITER ;

-- Edit PelayanGereja

	DELIMITER //

	CREATE PROCEDURE EditPelayanGerejaData(
	    p_id_pelayan INT,
	    p_nama_pelayan VARCHAR(255),
	    p_keterangan TEXT
	)
	BEGIN
	    UPDATE pelayan_gereja
	    SET nama_pelayan = p_nama_pelayan,
		keterangan = p_keterangan
	    WHERE id_pelayan = p_id_pelayan;
	END//

	DELIMITER ;
	
	
-- Update Sejarah Gereja


	DELIMITER //

	CREATE PROCEDURE `update_sejarah_gereja` (
	    IN p_id_sejarah INT,
	    IN p_sejarah TEXT
	)
	BEGIN
	    UPDATE sejarahgereja
	    SET
		sejarah = p_sejarah
	    WHERE
		id_sejarah = p_id_sejarah;
	END //

	DELIMITER ;
	
	CALL update_sejarah_gereja(1,'Miranda')
	
	-- Read Sejarah Gereja

DELIMITER //

CREATE PROCEDURE `read_sejarah_gereja` ()
BEGIN
    SELECT *
    FROM sejarahgereja;
END //

DELIMITER ;

DROP PROCEDURE read_sejarah_gereja
	
	CALL read_sejarah_gereja(1);
	
-- Mengambil Jemaat Berulang Tahun
DELIMITER //

CREATE PROCEDURE GetJemaatBirthdayToday()
BEGIN
    DECLARE today_month_day VARCHAR(5);
    
    -- Ambil bulan dan tanggal hari ini dalam format MM-DD
    SET today_month_day = DATE_FORMAT(NOW(), '%m-%d');
    
    -- Query untuk mengambil jemaat yang berulang tahun hari ini
    SELECT
        id_jemaat,
        nama_depan,
        nama_belakang,
        tgl_lahir,
        foto_jemaat  -- Menambahkan kolom foto_jemaat
    FROM
        jemaat
    WHERE
        DATE_FORMAT(tgl_lahir, '%m-%d') = today_month_day;
END //

DELIMITER ;

DROP PROCEDURE GetJemaatBirthdayToday


CALL GetJemaatBirthdayToday();



-- Create Pengeluaran
DELIMITER //

CREATE PROCEDURE tambah_pengeluaran(
    IN p_jumlah_pengeluaran INT,
    IN p_tanggal_pengeluaran VARCHAR(225),
    IN p_keterangan_pengeluaran VARCHAR(225),
    IN p_id_kategori_pengeluaran INT,
    IN p_id_bank INT,
    IN p_bukti_pengeluaran VARCHAR(500)
)
BEGIN
    INSERT INTO pengeluaran (
        jumlah_pengeluaran,
        tanggal_pengeluaran,
        keterangan_pengeluaran,
        id_kategori_pengeluaran,
        id_bank,
        bukti_pengeluaran
    ) VALUES (
        p_jumlah_pengeluaran,
        p_tanggal_pengeluaran,
        p_keterangan_pengeluaran,
        p_id_kategori_pengeluaran,
        p_id_bank,
        p_bukti_pengeluaran
    );
END //

DELIMITER ;

DROP PROCEDURE ambil_pengeluaran

-- GET PENGELUARAN
DELIMITER //

CREATE PROCEDURE ambil_pengeluaran()
BEGIN
    SELECT
	P.id_pengeluaran,
        p.jumlah_pengeluaran,
        p.tanggal_pengeluaran,
        p.keterangan_pengeluaran,
        b.nama_bank,
        kp.kategori_pengeluaran,
        p.bukti_pengeluaran,
        p.id_kategori_pengeluaran,
        p.id_bank
    FROM
        pengeluaran p
    INNER JOIN
        bank b ON p.id_bank = b.id_bank
    INNER JOIN
        kategori_pengeluaran kp ON p.id_kategori_pengeluaran = kp.id_kategori_pengeluaran;
END //

DELIMITER ;

CALL ambil_pengeluaran();

-- Update Pengeluaran
DELIMITER //

CREATE PROCEDURE ubah_pengeluaran(
    IN p_IDpengeluaran INT,
    IN p_bukti_pengeluaran VARCHAR(500),
    IN p_jumlah_pengeluaran INT,
    IN p_tanggal_pengeluaran VARCHAR(255),
    IN p_keterangan_pengeluaran VARCHAR(255),
    IN p_id_kategori_pengeluaran INT,
    IN p_id_bank INT
)
BEGIN
    UPDATE pengeluaran
    SET
        jumlah_pengeluaran = p_jumlah_pengeluaran,
        tanggal_pengeluaran = p_tanggal_pengeluaran,
        keterangan_pengeluaran = p_keterangan_pengeluaran,
        id_kategori_pengeluaran = p_id_kategori_pengeluaran,
        id_bank = p_id_bank,
        bukti_pengeluaran = p_bukti_pengeluaran
    WHERE
        id_pengeluaran = p_IDpengeluaran;
END //

DELIMITER ;

DROP PROCEDURE ubah_pengeluaran

-- GETBYID Pengeluaran
DELIMITER //

CREATE PROCEDURE getById_pengeluaran(
    IN p_id_pengeluaran INT
)
BEGIN
    SELECT
        p.id_pengeluaran,
        p.jumlah_pengeluaran,
        p.tanggal_pengeluaran,
        p.keterangan_pengeluaran,
        b.nama_bank,
        kp.kategori_pengeluaran,
        p.bukti_pengeluaran,
        p.id_bank,
        p.id_kategori_pengeluaran
    FROM
        pengeluaran p
    INNER JOIN
        bank b ON p.id_bank = b.id_bank
    INNER JOIN
        kategori_pengeluaran kp ON p.id_kategori_pengeluaran = kp.id_kategori_pengeluaran
    WHERE
        p.id_pengeluaran = p_id_pengeluaran;
END //

DELIMITER ;

CALL getById_pengeluaran(13)

USE DATABASE db_gereja_hkbp


-- CREATE PEMASUKAN
DELIMITER //

CREATE PROCEDURE `insert_pemasukan` (
    IN `p_id_pemasukan` INT,
    IN `p_tanggal_pemasukan` DATE,
    IN `p_total_pemasukan` INT,
    IN `p_bentuk_pemasukan` VARCHAR(225),
    IN `p_id_kategori_pemasukan` INT,
    IN `p_bukti_pemasukan` VARCHAR(500),
    IN `p_id_bank` INT
)
BEGIN
    INSERT INTO `pemasukan` (
        `id_pemasukan`,
        `tanggal_pemasukan`,
        `total_pemasukan`,
        `bentuk_pemasukan`,
        `id_kategori_pemasukan`,
        `bukti_pemasukan`,
        `id_bank`
    ) VALUES (
        p_id_pemasukan,
        p_tanggal_pemasukan,
        p_total_pemasukan,
        p_bentuk_pemasukan,
        p_id_kategori_pemasukan,
        p_bukti_pemasukan,
        p_id_bank
    );
END //

DELIMITER ;

-- GET ALL PEMASUKAN

DELIMITER //

CREATE PROCEDURE `GetAllPemasukan` ()
BEGIN
    SELECT
        p.id_pemasukan,
        p.tanggal_pemasukan,
        p.bukti_pemasukan,
        p.total_pemasukan,
        p.bentuk_pemasukan,
        b.nama_bank AS nama_bank,
        kp.kategori_pemasukan AS nama_kategori,
        p.id_bank,
        p.id_kategori_pemasukan
    FROM
        pemasukan p
    INNER JOIN
        bank b ON p.id_bank = b.id_bank
    INNER JOIN
        kategori_pemasukab kp ON p.id_kategori_pemasukan = kp.id_kategori_pemasukan;
END //

DELIMITER ;

CALL GetAllPemasukan

DROP PROCEDURE GetAllPemasukan


DELIMITER //

CREATE PROCEDURE `update_pemasukan` (
    IN `p_id_pemasukan` INT,
    IN `p_tanggal_pemasukan` DATE,
    IN `p_total_pemasukan` INT,
    IN `p_bentuk_pemasukan` VARCHAR(225),
    IN `p_id_kategori_pemasukan` INT,
    IN `p_bukti_pemasukan` VARCHAR(500),
    IN `p_id_bank` INT
)
BEGIN
    UPDATE pemasukan
    SET
        tanggal_pemasukan = p_tanggal_pemasukan,
        total_pemasukan = p_total_pemasukan,
        bentuk_pemasukan = p_bentuk_pemasukan,
        id_kategori_pemasukan = p_id_kategori_pemasukan,
        bukti_pemasukan = p_bukti_pemasukan,
        id_bank = p_id_bank
    WHERE
        id_pemasukan = p_id_pemasukan;
END //

DELIMITER ;

-- GetPemasukanBYID
DELIMITER //

CREATE PROCEDURE `getByIdPemasukan` (
    IN `p_id_pemasukan` INT
)
BEGIN
    SELECT
        p.id_pemasukan,
        p.tanggal_pemasukan,
        p.total_pemasukan,
        p.bentuk_pemasukan,
        kp.kategori_pemasukan,
        p.bukti_pemasukan,
        b.nama_bank,
        p.id_bank,
        p.id_kategori_pemasukan
    FROM
        pemasukan p
    INNER JOIN
        bank b ON p.id_bank = b.id_bank
    INNER JOIN
        kategori_pemasukab kp ON p.id_kategori_pemasukan = kp.id_kategori_pemasukan
    WHERE
        p.id_pemasukan = p_id_pemasukan;
END //

DELIMITER ;

DROP PROCEDURE getByIdPemasukan

CALL getByIdPemasukan(1)


-- CREATE BAPTIS
DELIMITER //

CREATE PROCEDURE `registrasi_baptis`(
    IN `p_id_jemaat` INT,
    IN `p_nama_ayah` VARCHAR(225),
    IN `p_nama_ibu` VARCHAR(225),
    IN `p_nama_lengkap` VARCHAR(225),
    IN `p_tempat_lahir` VARCHAR(225),
    IN `p_tanggal_lahir` VARCHAR(225), -- Ubah tipe data menjadi VARCHAR
    IN `p_jenis_kelamin` VARCHAR(25),
    IN `p_id_hub_keluarga` INT
)
BEGIN
    INSERT INTO `registrasi_baptis` (
        `id_jemaat`,
        `nama_ayah`,
        `nama_ibu`,
        `nama_lengkap`,
        `tempat_lahir`,
        `tanggal_lahir`,
        `jenis_kelamin`,
        `id_hub_keluarga`
    ) VALUES (
        p_id_jemaat,
        p_nama_ayah,
        p_nama_ibu,
        p_nama_lengkap,
        p_tempat_lahir,
        p_tanggal_lahir,
        p_jenis_kelamin,
        p_id_hub_keluarga
    );
END //

DELIMITER ;


-- UPDATE Baptis
DELIMITER //

CREATE PROCEDURE `update_registrasi_baptis`(
    IN `p_id_registrasi_baptis` INT,
    IN `p_no_surat_baptis` VARCHAR(225),
    IN `p_nama_pendeta_baptis` VARCHAR(225),
    IN `p_file_surat_baptis` VARCHAR(400),
    IN `p_tanggal_baptis` VARCHAR(225)
)
BEGIN
    UPDATE `registrasi_baptis`
    SET
        `no_surat_baptis` = p_no_surat_baptis,
        `nama_pendeta_baptis` = p_nama_pendeta_baptis,
        `file_surat_baptis` = p_file_surat_baptis,
        `tanggal_baptis` = p_tanggal_baptis,
        `update_at` = CURRENT_TIMESTAMP
    WHERE
        `id_registrasi_baptis` = p_id_registrasi_baptis;
END //

DELIMITER ;

use DATABASE db_gereja_hkbp

-- getbyid baptis
DELIMITER //

CREATE PROCEDURE GetByIdBaptis(IN p_id_registrasi_baptis INT)
BEGIN
    SELECT 
        id_registrasi_baptis,
        id_jemaat,
        nama_ayah,
        nama_ibu,
        nama_lengkap,
        tempat_lahir,
        tanggal_lahir,
        jenis_kelamin,
        id_hub_keluarga,
        tanggal_baptis,
        no_surat_baptis,
        nama_pendeta_baptis,
        file_surat_baptis,
        id_status
    FROM registrasi_baptis
    WHERE id_registrasi_baptis = p_id_registrasi_baptis;
END//

DELIMITER ;

CALL GetByIdBaptis(1)