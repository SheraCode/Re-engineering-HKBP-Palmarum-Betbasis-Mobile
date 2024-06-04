-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 04, 2024 at 09:42 AM
-- Server version: 10.4.24-MariaDB
-- PHP Version: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_gereja_hkbp`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`` PROCEDURE `add_pelayan_gereja` (IN `p_id_jemaat` INT, IN `p_nama_pelayan` VARCHAR(225), IN `p_isTahbisan` TINYINT(1), IN `p_keterangan` TEXT)   BEGIN
    INSERT INTO pelayan_gereja (id_jemaat, nama_pelayan, isTahbisan, keterangan)
    VALUES (p_id_jemaat, p_nama_pelayan, p_isTahbisan, p_keterangan);
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ambil_pengeluaran` ()   BEGIN
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
END$$

CREATE DEFINER=`` PROCEDURE `CreateJadwalIbadah` (IN `p_id_jemaat` INT, IN `p_id_jenis_minggu` INT, IN `p_tgl_ibadah` VARCHAR(225), IN `p_sesi_ibadah` VARCHAR(225), IN `p_keterangan` TEXT)   BEGIN
    INSERT INTO jadwal_ibadah (id_jemaat, id_jenis_minggu, tgl_ibadah, sesi_ibadah, keterangan, create_at, update_at)
    VALUES (p_id_jemaat, p_id_jenis_minggu, p_tgl_ibadah, p_sesi_ibadah, p_keterangan, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
END$$

CREATE DEFINER=`` PROCEDURE `CreatePelayananIbadahData` (`p_id_jemaat` INT, `p_nama_pelayanan_ibadah` VARCHAR(255), `p_keterangan` VARCHAR(255))   BEGIN
    INSERT INTO pelayanan_ibadah (id_jemaat, nama_pelayanan_ibadah, keterangan)
    VALUES (p_id_jemaat, p_nama_pelayanan_ibadah, p_keterangan);
END$$

CREATE DEFINER=`` PROCEDURE `CreatePelayanGerejaData` (`p_id_jemaat` INT, `p_nama_pelayan` VARCHAR(255), `p_keterangan` TEXT)   BEGIN
    INSERT INTO pelayan_gereja (id_jemaat, nama_pelayan, keterangan)
    VALUES (p_id_jemaat, p_nama_pelayan, p_keterangan);
END$$

CREATE DEFINER=`` PROCEDURE `CreatePelayanIbadahData` (`p_id_jemaat` INT, `p_id_jadwal_ibadah` INT, `p_id_pelayanan_ibadah` INT, `p_keterangan` VARCHAR(255))   BEGIN
    INSERT INTO pelayan_ibadah (id_jemaat, id_jadwal_ibadah, id_pelayanan_ibadah, keterangan)
    VALUES (p_id_jemaat, p_id_jadwal_ibadah, p_id_pelayanan_ibadah, p_keterangan);
END$$

CREATE DEFINER=`` PROCEDURE `CreateRegistrasiPernikahan` (IN `p_id_jemaat` INT, IN `p_nama_gereja_laki` VARCHAR(225), IN `p_nama_laki` VARCHAR(225), IN `p_nama_ayah_laki` VARCHAR(225), IN `p_nama_ibu_laki` VARCHAR(225), IN `p_nama_gereja_perempuan` VARCHAR(225), IN `p_nama_perempuan` VARCHAR(225), IN `p_nama_ayah_perempuan` VARCHAR(225), IN `p_nama_ibu_perempuan` VARCHAR(225))   BEGIN
    INSERT INTO registrasi_pernikahan (
        id_jemaat,
        nama_gereja_laki,
        nama_laki,
        nama_ayah_laki,
        nama_ibu_laki,
        nama_gereja_perempuan,
        nama_perempuan,
        nama_ayah_perempuan,
        nama_ibu_perempuan
    ) VALUES (
        p_id_jemaat,
        p_nama_gereja_laki,
        p_nama_laki,
        p_nama_ayah_laki,
        p_nama_ibu_laki,
        p_nama_gereja_perempuan,
        p_nama_perempuan,
        p_nama_ayah_perempuan,
        p_nama_ibu_perempuan
    );
END$$

CREATE DEFINER=`` PROCEDURE `createRegistrasiSidi` (IN `p_id_jemaat` INT, IN `p_nama_ayah` VARCHAR(225), IN `p_nama_ibu` VARCHAR(225), IN `p_nama_lengkap` VARCHAR(225), IN `p_tempat_lahir` VARCHAR(50), IN `p_tanggal_lahir` DATE, IN `p_jenis_kelamin` VARCHAR(15), IN `p_id_hub_keluarga` INT, IN `p_id_status` INT, IN `p_file_surat_baptis` VARCHAR(225))   BEGIN
    INSERT INTO registrasi_sidi (
        id_jemaat, 
        nama_ayah, 
        nama_ibu, 
        nama_lengkap, 
        tempat_lahir, 
        tanggal_lahir, 
        jenis_kelamin, 
        id_hub_keluarga,
        id_status,
        file_surat_baptis
    ) VALUES (
        p_id_jemaat, 
        p_nama_ayah, 
        p_nama_ibu, 
        p_nama_lengkap, 
        p_tempat_lahir, 
        p_tanggal_lahir, 
        p_jenis_kelamin, 
        p_id_hub_keluarga,
        p_id_status,
        p_file_surat_baptis
    );
END$$

CREATE DEFINER=`` PROCEDURE `CreateWarta` (IN `warta_text` TEXT, IN `id_jemaat` INT)   BEGIN
    INSERT INTO warta (warta, id_jemaat) VALUES (warta_text, id_jemaat);
END$$

CREATE DEFINER=`` PROCEDURE `create_jemaat` (IN `p_nama_depan` VARCHAR(225), IN `p_nama_belakang` VARCHAR(225), IN `p_id_registrasi_keluarga` INT, IN `p_id_hub_keluarga` INT)   BEGIN
    INSERT INTO `jemaat` (
        `nama_depan`,
        `nama_belakang`,
        `id_registrasi_keluarga`,
        `id_hub_keluarga`
    ) VALUES (
        p_nama_depan,
        p_nama_belakang,
        p_id_registrasi_keluarga,
        p_id_hub_keluarga
    );
END$$

CREATE DEFINER=`` PROCEDURE `create_registrasi_keluarga` (IN `p_no_kk` INT, IN `p_id_jemaat` INT, IN `p_nama_kepala_keluarga` VARCHAR(225))   BEGIN
    INSERT INTO `registrasi_keluarga` (
        `no_kk`,
        `id_jemaat`,
        `nama_kepala_keluarga`,
        `create_at`,
        `updated_at`,
        `id_deleted`
    ) VALUES (
        p_no_kk,
        p_id_jemaat,
        p_nama_kepala_keluarga,
        current_timestamp(),
        current_timestamp(),
        current_timestamp()
    );
END$$

CREATE DEFINER=`` PROCEDURE `DeletePelayanIbadahById` (IN `p_id_pelayan_ibadah` INT)   BEGIN
    DELETE FROM pelayan_ibadah
    WHERE id_pelayan_ibadah = p_id_pelayan_ibadah;
END$$

CREATE DEFINER=`` PROCEDURE `delete_pelayan_gereja` (IN `p_id_pelayan` INT)   BEGIN
    DELETE FROM pelayan_gereja
    WHERE id_pelayan = p_id_pelayan;
END$$

CREATE DEFINER=`` PROCEDURE `delete_pelayan_ibadah` (IN `id_to_delete` INT)   BEGIN
    DELETE FROM pelayan_ibadah WHERE id_jadwal_ibadah = id_to_delete;
END$$

CREATE DEFINER=`` PROCEDURE `delete_pelayan_ibadah_by_create_at` (IN `delete_date` TIMESTAMP)   BEGIN
    DELETE FROM pelayan_ibadah WHERE DATE(create_at) = DATE(delete_date);
END$$

CREATE DEFINER=`` PROCEDURE `EditJadwalIbadah` (IN `p_id_jadwal_ibadah` INT, IN `p_id_jemaat` INT, IN `p_id_jenis_minggu` INT, IN `p_tgl_ibadah` VARCHAR(225), IN `p_sesi_ibadah` VARCHAR(225), IN `p_keterangan` TEXT)   BEGIN
    UPDATE jadwal_ibadah
    SET id_jemaat = p_id_jemaat,
	id_jenis_minggu = p_id_jenis_minggu,
        tgl_ibadah = p_tgl_ibadah,
        sesi_ibadah = p_sesi_ibadah,
        keterangan = p_keterangan,
        update_at = CURRENT_TIMESTAMP
    WHERE id_jadwal_ibadah = p_id_jadwal_ibadah;
END$$

CREATE DEFINER=`` PROCEDURE `EditPelayananIbadah` (IN `p_id_pelayanan_ibadah` INT, IN `p_id_jemaat` INT, IN `p_nama_pelayanan_ibadah` VARCHAR(225), IN `p_keterangan` TEXT)   BEGIN
    UPDATE pelayanan_ibadah
    SET id_jemaat = p_id_jemaat,
	nama_pelayanan_ibadah = p_nama_pelayanan_ibadah,
        keterangan = p_keterangan,
        update_at = CURRENT_TIMESTAMP
    WHERE id_pelayanan_ibadah = p_id_pelayanan_ibadah;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `EditPelayanGerejaData` (`p_id_pelayan` INT, `p_nama_pelayan` VARCHAR(255), `p_keterangan` TEXT)   BEGIN
    UPDATE pelayan_gereja
    SET nama_pelayan = p_nama_pelayan,
        keterangan = p_keterangan
    WHERE id_pelayan = p_id_pelayan;
END$$

CREATE DEFINER=`` PROCEDURE `EditWarta` (IN `warta_id` INT, IN `warta_text` TEXT, IN `id_jemaat` INT)   BEGIN
    UPDATE warta
    SET warta = warta_text, id_jemaat = id_jemaat
    WHERE id_warta = warta_id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetAllPemasukan` ()   BEGIN
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
END$$

CREATE DEFINER=`` PROCEDURE `GetAllRegistrasiBaptis` ()   BEGIN
    SELECT 
        rb.id_registrasi_baptis, 
        rb.id_jemaat, 
        rb.nama_ayah, 
        rb.nama_ibu, 
        rb.nama_lengkap, 
        rb.tempat_lahir, 
        rb.tanggal_lahir, 
        rb.jenis_kelamin, 
        rb.id_hub_keluarga,
        hk.nama_hub_keluarga, 
        rb.id_status,
        s.status
    FROM 
        registrasi_baptis rb
    INNER JOIN 
        STATUS s ON rb.id_status = s.id_status
    INNER JOIN
        hubungan_keluarga hk ON rb.id_hub_keluarga = hk.id_hub_keluarga
    WHERE 
        s.status = 'Menunggu Persetujuan';
END$$

CREATE DEFINER=`` PROCEDURE `GetAllRegistrasiPernikahan` ()   BEGIN
    SELECT 
        rp.id_registrasi_nikah,
        rp.id_jemaat,
        rp.id_status,
        rp.nama_gereja_laki,
        rp.nama_laki,
        rp.nama_ayah_laki,
        rp.nama_ibu_laki,
        rp.nama_gereja_perempuan,
        rp.nama_perempuan,
        rp.nama_ayah_perempuan,
        rp.nama_ibu_perempuan,
        rp.keterangan,
        s.status
    FROM 
        registrasi_pernikahan rp
    INNER JOIN 
        STATUS s ON rp.id_status = s.id_status
    WHERE
        rp.id_status = 11;
END$$

CREATE DEFINER=`` PROCEDURE `GetAllRegistrasiSidiByIdJemaat` (IN `jemaat_id` INT)   BEGIN
    SELECT 
        rs.id_registrasi_sidi,
        rs.id_jemaat,
        rs.nama_ayah,
        rs.nama_ibu,
        rs.nama_lengkap,
        rs.tempat_lahir,
        rs.tanggal_lahir,
        rs.jenis_kelamin,
        rs.id_hub_keluarga,
        hk.nama_hub_keluarga,
        rs.tanggal_sidi,
        rs.nats_sidi,
        rs.nomor_surat_sidi,
        rs.nama_pendeta_sidi,
        rs.file_surat_baptis,
        rs.id_status,
        st.status
    FROM 
        registrasi_sidi rs
    INNER JOIN 
        hubungan_keluarga hk ON rs.id_hub_keluarga = hk.id_hub_keluarga
    INNER JOIN 
        STATUS st ON rs.id_status = st.id_status
    WHERE 
        rs.id_jemaat = jemaat_id;
END$$

CREATE DEFINER=`` PROCEDURE `GetByIdBaptis` (IN `p_id_registrasi_baptis` INT)   BEGIN
    SELECT 
        rb.id_registrasi_baptis,
        rb.id_jemaat,
        rb.nama_ayah,
        rb.nama_ibu,
        rb.nama_lengkap,
        rb.tempat_lahir,
        rb.tanggal_lahir,
        rb.jenis_kelamin,
        rb.id_hub_keluarga,
        hk.nama_hub_keluarga,
        rb.tanggal_baptis,
        rb.no_surat_baptis,
        rb.nama_pendeta_baptis,
        rb.file_surat_baptis,
        rb.id_status,
        s.status
    FROM registrasi_baptis rb
    INNER JOIN status s ON rb.id_status = s.id_status
    INNER JOIN hubungan_keluarga hk ON rb.id_hub_keluarga = hk.id_hub_keluarga
    WHERE rb.id_registrasi_baptis = p_id_registrasi_baptis;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getByIdPemasukan` (IN `p_id_pemasukan` INT)   BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `getById_pengeluaran` (IN `p_id_pengeluaran` INT)   BEGIN
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
END$$

CREATE DEFINER=`` PROCEDURE `GetDataAnak` (IN `p_id_registrasi_keluarga` INT)   BEGIN
    SELECT 
	id_jemaat,
        nama_depan, 
        nama_belakang, 
        id_hub_keluarga,
        jenis_kelamin,
        tgl_lahir,
        tempat_lahir,
        id_registrasi_keluarga
    FROM 
        jemaat
    WHERE 
        id_registrasi_keluarga = p_id_registrasi_keluarga
        AND id_hub_keluarga = 3;
END$$

CREATE DEFINER=`` PROCEDURE `GetDataJemaatByIdREQ` (IN `p_id_jemaat` INT)   BEGIN
    SELECT 
        id_jemaat,
        nama_depan, 
        nama_belakang, 
        id_hub_keluarga,
        jenis_kelamin,
        tgl_lahir,
        tempat_lahir,
        id_registrasi_keluarga
    FROM 
        jemaat
    WHERE 
        id_jemaat = p_id_jemaat;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDataWarta` ()   BEGIN
    SELECT id_warta, warta, create_at FROM warta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetDataWartaHome` ()   BEGIN
    SELECT id_warta, warta, create_at FROM warta
    ORDER BY create_at DESC
    LIMIT 5;
END$$

CREATE DEFINER=`` PROCEDURE `GetFileSuratBaptisById` (IN `p_id_registrasi_baptis` INT)   BEGIN
    SELECT file_surat_baptis
    FROM registrasi_baptis
    WHERE id_registrasi_baptis = p_id_registrasi_baptis;
END$$

CREATE DEFINER=`` PROCEDURE `GetFileSuratSidiById` (IN `p_id_registrasi_sidi` INT)   BEGIN
    SELECT file_surat_baptis
    FROM registrasi_sidi
    WHERE id_registrasi_sidi = p_id_registrasi_sidi;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetImageNameFromDatabaseProcedure` (IN `jemaatID` VARCHAR(50), OUT `imageName` VARCHAR(255))   BEGIN
    SELECT foto_jemaat INTO imageName FROM jemaat WHERE id_jemaat = jemaatID;
    
    IF imageName IS NULL THEN
        SET imageName = 'image not found';
    END IF;
END$$

CREATE DEFINER=`` PROCEDURE `GetIsteriKeluarga` (IN `p_id_registrasi_keluarga` INT)   BEGIN
    SELECT 
        nama_depan, 
        nama_belakang, 
        id_hub_keluarga
    FROM 
        jemaat
    WHERE 
        id_registrasi_keluarga = p_id_registrasi_keluarga
        AND id_hub_keluarga = 2;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetJadwalIbadah` ()   BEGIN
    SELECT j.id_jadwal_ibadah, jm.nama_jenis_minggu, j.tgl_ibadah, j.sesi_ibadah, j.keterangan, j.id_jenis_minggu
    FROM jadwal_ibadah j
    INNER JOIN jenis_minggu jm ON j.id_jenis_minggu = jm.id_jenis_minggu;
END$$

CREATE DEFINER=`` PROCEDURE `GetJadwalIbadahByID` (IN `p_id_jadwal_ibadah` INT)   BEGIN
    SELECT j.id_jadwal_ibadah, jm.nama_jenis_minggu, j.tgl_ibadah, j.sesi_ibadah, j.keterangan, j.id_jenis_minggu
    FROM jadwal_ibadah j
    INNER JOIN jenis_minggu jm ON j.id_jenis_minggu = jm.id_jenis_minggu
    WHERE j.id_jadwal_ibadah = p_id_jadwal_ibadah;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetJemaat` (IN `jemaat_id` INT)   BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetJemaatBirthdayToday` ()   BEGIN
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
END$$

CREATE DEFINER=`` PROCEDURE `GetJemaatByRegistrasiKeluarga` (IN `p_id_registrasi_keluarga` INT)   BEGIN
    SELECT 
        nama_depan, 
        nama_belakang, 
        id_hub_keluarga
    FROM 
        jemaat
    WHERE 
        id_registrasi_keluarga = p_id_registrasi_keluarga
        AND id_hub_keluarga = 1;
END$$

CREATE DEFINER=`` PROCEDURE `GetPelayananIbadahByID` (IN `p_id_pelayanan_ibadah` INT)   BEGIN
    SELECT id_pelayanan_ibadah, nama_pelayanan_ibadah, keterangan, create_at, is_deleted, update_at
    FROM pelayanan_ibadah
    WHERE id_pelayanan_ibadah = p_id_pelayanan_ibadah;
END$$

CREATE DEFINER=`` PROCEDURE `GetPelayanGereja` ()   BEGIN
  SELECT 
    majelis.*,
    status.status,
    jemaat.nama_depan
  FROM 
    majelis
  INNER JOIN 
    status ON majelis.id_status_pelayan = status.id_status
  INNER JOIN
    jemaat ON majelis.id_jemaat = jemaat.id_jemaat;
END$$

CREATE DEFINER=`` PROCEDURE `GetPelayanIbadahData` ()   BEGIN
    SELECT pi.id_pelayan_ibadah, pi.id_pelayanan_ibadah, pi.id_jadwal_ibadah, p.nama_pelayanan_ibadah, p.keterangan, j.sesi_ibadah, j.tgl_ibadah
    FROM pelayan_ibadah PI
    INNER JOIN pelayanan_ibadah p ON pi.id_pelayanan_ibadah = p.id_pelayanan_ibadah
    INNER JOIN jadwal_ibadah j ON pi.id_jadwal_ibadah = j.id_jadwal_ibadah
    WHERE pi.create_at >= DATE_SUB(CURRENT_DATE(), INTERVAL 6 DAY);
END$$

CREATE DEFINER=`` PROCEDURE `GetPernikahanById` (IN `registrasiNikahId` INT)   BEGIN
    SELECT 
	rp.id_registrasi_nikah,
        rp.id_jemaat,
        rp.id_status,
        rp.nama_gereja_laki,
        rp.nama_laki,
        rp.nama_ayah_laki,
        rp.nama_ibu_laki,
        rp.nama_gereja_perempuan,
        rp.nama_perempuan,
        rp.nama_ayah_perempuan,
        rp.nama_ibu_perempuan,
        rp.keterangan,
        s.status
    FROM 
        registrasi_pernikahan rp
    INNER JOIN 
        status s ON rp.id_status = s.id_status
    WHERE 
        rp.id_registrasi_nikah = registrasiNikahId;
END$$

CREATE DEFINER=`` PROCEDURE `GetRegistrasiBaptisByIdJemaat` (IN `jemaat_id` INT)   BEGIN
    SELECT 
        rb.id_registrasi_baptis, 
        rb.id_jemaat, 
        rb.nama_ayah, 
        rb.nama_ibu, 
        rb.nama_lengkap, 
        rb.tempat_lahir, 
        rb.tanggal_lahir, 
        rb.jenis_kelamin, 
        rb.id_hub_keluarga,
        hk.nama_hub_keluarga, 
        rb.id_status,
        s.status
    FROM 
        registrasi_baptis rb
    INNER JOIN 
        status s ON rb.id_status = s.id_status
    INNER JOIN
        hubungan_keluarga hk ON rb.id_hub_keluarga = hk.id_hub_keluarga
    WHERE 
        rb.id_jemaat = jemaat_id;
END$$

CREATE DEFINER=`` PROCEDURE `GetRegistrasiPernikahanByJemaat` (IN `jemaatID` INT)   BEGIN
    SELECT
	rp.id_registrasi_nikah,
        rp.id_jemaat,
        rp.id_status,
        rp.nama_gereja_laki,
        rp.nama_laki,
        rp.nama_ayah_laki,
        rp.nama_ibu_laki,
        rp.nama_gereja_perempuan,
        rp.nama_perempuan,
        rp.nama_ayah_perempuan,
        rp.nama_ibu_perempuan,
        rp.keterangan,
        s.status
    FROM 
        registrasi_pernikahan rp
    INNER JOIN 
        status s ON rp.id_status = s.id_status
    WHERE
        rp.id_jemaat = jemaatID;
END$$

CREATE DEFINER=`` PROCEDURE `GetRegistrasiPernikahanByStatus` ()   BEGIN
    SELECT 
        rp.id_registrasi_nikah,
        rp.id_jemaat,
        rp.id_status,
        rp.nama_gereja_laki,
        rp.nama_laki,
        rp.nama_ayah_laki,
        rp.nama_ibu_laki,
        rp.nama_gereja_perempuan,
        rp.nama_perempuan,
        rp.nama_ayah_perempuan,
        rp.nama_ibu_perempuan,
        rp.keterangan,
        s.status
    FROM 
        registrasi_pernikahan rp
    INNER JOIN 
        STATUS s ON rp.id_status = s.id_status
    WHERE
        rp.id_status = 11;
END$$

CREATE DEFINER=`` PROCEDURE `getRegistrasiSidi` ()   BEGIN
    SELECT 
        rs.id_registrasi_sidi,
        rs.id_jemaat,
        rs.nama_ayah,
        rs.nama_ibu,
        rs.nama_lengkap,
        rs.tempat_lahir,
        rs.tanggal_lahir,
        rs.jenis_kelamin,
        rs.id_hub_keluarga,
        hk.nama_hub_keluarga,
        rs.tanggal_sidi,
        rs.nats_sidi,
        rs.nomor_surat_sidi,
        rs.nama_pendeta_sidi,
        rs.file_surat_baptis,
        rs.id_status,
        st.status
    FROM 
        registrasi_sidi rs
    INNER JOIN 
        hubungan_keluarga hk ON rs.id_hub_keluarga = hk.id_hub_keluarga
    INNER JOIN 
        status st ON rs.id_status = st.id_status
    WHERE
        st.status = 'Menunggu Persetujuan';
  
END$$

CREATE DEFINER=`` PROCEDURE `GetRegistrasiSidiById` (IN `input_id_registrasi_sidi` INT)   BEGIN
    SELECT 
        rs.id_registrasi_sidi,
        rs.id_jemaat,
        rs.nama_ayah,
        rs.nama_ibu,
        rs.nama_lengkap,
        rs.tempat_lahir,
        rs.tanggal_lahir,
        rs.jenis_kelamin,
        rs.id_hub_keluarga,
        rs.tanggal_sidi,
        rs.nats_sidi,
        rs.nomor_surat_sidi,
        rs.nama_pendeta_sidi,
        rs.id_status AS id_status, -- Memberikan alias yang tepat untuk kolom id_status
        s.status AS STATUS, -- Menambahkan alias untuk kolom status agar sesuai dengan atribut status
        hk.nama_hub_keluarga,
        rs.file_surat_baptis
    FROM 
        `registrasi_sidi` rs
    INNER JOIN 
        `status` s ON rs.id_status = s.id_status
    INNER JOIN 
        `hubungan_keluarga` hk ON rs.id_hub_keluarga = hk.id_hub_keluarga
    WHERE 
        rs.`id_registrasi_sidi` = input_id_registrasi_sidi;
END$$

CREATE DEFINER=`` PROCEDURE `GetWaktuKegiatan` ()   BEGIN
    SELECT id_waktu_kegiatan, id_jenis_kegiatan, id_jemaat, nama_kegiatan, lokasi_kegiatan, waktu_kegiatan, foto_kegiatan, keterangan
    FROM waktu_kegiatan;
END$$

CREATE DEFINER=`` PROCEDURE `GetWaktuKegiatanByID` (IN `id` INT)   BEGIN
    SELECT id_waktu_kegiatan, id_jenis_kegiatan, id_jemaat, nama_kegiatan, lokasi_kegiatan, waktu_kegiatan, foto_kegiatan, keterangan
    FROM waktu_kegiatan
    WHERE id_waktu_kegiatan = id;
END$$

CREATE DEFINER=`` PROCEDURE `GetWaktuKegiatanHome` ()   BEGIN
    SELECT id_waktu_kegiatan, id_jenis_kegiatan, id_jemaat, nama_kegiatan, lokasi_kegiatan, waktu_kegiatan,foto_kegiatan, keterangan
    FROM waktu_kegiatan
    ORDER BY id_waktu_kegiatan DESC
    LIMIT 5;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `GetWartaByID` (IN `id_warta_param` INT)   BEGIN
    SELECT id_warta, warta, create_at FROM warta WHERE id_warta = id_warta_param;
END$$

CREATE DEFINER=`` PROCEDURE `get_all_keluarga` ()   BEGIN
    SELECT 
        `id_registrasi_keluarga`,
        `no_kk`,
        `id_jemaat`,
        `nama_kepala_keluarga`
    FROM 
        `registrasi_keluarga`;
END$$

CREATE DEFINER=`` PROCEDURE `get_jemaat` ()   BEGIN
    SELECT id_jemaat,nama_depan
    FROM jemaat
    WHERE role_jemaat = 'jemaat';
END$$

CREATE DEFINER=`` PROCEDURE `get_pelayan_gereja` ()   BEGIN
    SELECT
        id_pelayan,
        nama_pelayan,
        isTahbisan,
        keterangan
    FROM
        pelayan_gereja;
END$$

CREATE DEFINER=`` PROCEDURE `get_pelayan_gereja_by_id` (IN `p_id_pelayan` INT)   BEGIN
    SELECT 
        id_pelayan, 
        nama_pelayan, 
        isTahbisan, 
        keterangan
    FROM 
        pelayan_gereja
    WHERE 
        id_pelayan = p_id_pelayan;
END$$

CREATE DEFINER=`` PROCEDURE `insert_pemasukan` (IN `p_id_jemaat` INT, IN `p_tanggal_pemasukan` DATE, IN `p_total_pemasukan` INT, IN `p_bentuk_pemasukan` VARCHAR(225), IN `p_id_kategori_pemasukan` INT, IN `p_bukti_pemasukan` VARCHAR(500), IN `p_id_bank` INT)   BEGIN
    INSERT INTO `pemasukan` (
	`id_jemaat`,
        `tanggal_pemasukan`,
        `total_pemasukan`,
        `bentuk_pemasukan`,
        `id_kategori_pemasukan`,
        `bukti_pemasukan`,
        `id_bank`
    ) VALUES (
	p_id_jemaat,
        p_tanggal_pemasukan,
        p_total_pemasukan,
        p_bentuk_pemasukan,
        p_id_kategori_pemasukan,
        p_bukti_pemasukan,
        p_id_bank
    );
END$$

CREATE DEFINER=`` PROCEDURE `LoginProcedure` (IN `userEmail` VARCHAR(100), IN `userPassword` VARCHAR(100), OUT `jemaatID` INT, OUT `rolejemaat` VARCHAR(225), OUT `jemaatNamaDepan` VARCHAR(225), OUT `jemaatNamaBelakang` VARCHAR(225), OUT `jemaatEmail` VARCHAR(225), OUT `jemaatPassword` VARCHAR(225), OUT `jemaatGelarDepan` VARCHAR(225), OUT `jemaatGelarBelakang` VARCHAR(225), OUT `jemaatTempatLahir` VARCHAR(50), OUT `jemaatJenisKelamin` VARCHAR(225), OUT `jemaatIDHubKeluarga` INT, OUT `jemaatIDStatusPernikahan` INT, OUT `jemaatIDStatusAmaIna` INT, OUT `jemaatIDStatusAnak` INT, OUT `jemaatIDPendidikan` INT, OUT `jemaatIDBidangPendidikan` INT, OUT `jemaatBidangPendidikanLainnya` VARCHAR(225), OUT `jemaatIDPekerjaan` INT, OUT `jemaatNamaPekerjaanLainnya` VARCHAR(225), OUT `jemaatGolDarah` VARCHAR(225), OUT `jemaatAlamat` VARCHAR(455), OUT `jemaatIsSidi` VARCHAR(225), OUT `jemaatIDKecamatan` INT, OUT `jemaatNoTelepon` INT, OUT `jemaatNoHP` INT, OUT `jemaatFotoJemaat` VARCHAR(500), OUT `jemaatKeterangan` VARCHAR(500), OUT `jemaatIsBaptis` VARCHAR(225), OUT `jemaatIsMenikah` VARCHAR(225), OUT `jemaatIsMeninggal` VARCHAR(225), OUT `jemaatIsRPP` VARCHAR(225), OUT `jemaatCreateAt` TIMESTAMP, OUT `jemaatUpdateAt` TIMESTAMP, OUT `jemaatIsDeleted` TIMESTAMP, OUT `jemaatNoRegistrasi` INT)   BEGIN
    DECLARE rowCount INT DEFAULT 0;

    -- Hitung jumlah baris yang sesuai dengan email dan password yang diberikan
    SELECT COUNT(*) INTO rowCount FROM jemaat WHERE email = userEmail AND PASSWORD = userPassword;

    -- Jika ada baris yang sesuai, ambil data jemaat
    IF rowCount = 1 THEN
        SELECT id_jemaat, role_jemaat,nama_depan, nama_belakang, email, PASSWORD, gelar_depan, gelar_belakang, tempat_lahir,
               jenis_kelamin, id_hub_keluarga, id_status_pernikahan, id_status_ama_ina, id_status_anak, id_pendidikan,
               id_bidang_pendidikan, bidang_pendidikan_lainnya, id_pekerjaan, nama_pekerjaan_lainnya, gol_darah,
               alamat, isSidi, id_kecamatan, no_telepon, no_hp, foto_jemaat, keterangan, isBaptis, isMenikah,
               isMeninggal, isRPP, create_at, update_at, is_deleted, id_registrasi_keluarga
        INTO jemaatID, rolejemaat,jemaatNamaDepan, jemaatNamaBelakang, jemaatEmail, jemaatPassword, jemaatGelarDepan,
             jemaatGelarBelakang, jemaatTempatLahir, jemaatJenisKelamin, jemaatIDHubKeluarga, jemaatIDStatusPernikahan,
             jemaatIDStatusAmaIna, jemaatIDStatusAnak, jemaatIDPendidikan, jemaatIDBidangPendidikan,
             jemaatBidangPendidikanLainnya, jemaatIDPekerjaan, jemaatNamaPekerjaanLainnya, jemaatGolDarah, jemaatAlamat,
             jemaatIsSidi, jemaatIDKecamatan, jemaatNoTelepon, jemaatNoHP, jemaatFotoJemaat, jemaatKeterangan,
             jemaatIsBaptis, jemaatIsMenikah, jemaatIsMeninggal, jemaatIsRPP, jemaatCreateAt, jemaatUpdateAt, jemaatIsDeleted, jemaatNoRegistrasi
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
        SET jemaatNoRegistrasi = NULL;
    END IF;
END$$

CREATE DEFINER=`` PROCEDURE `majelis_BYID` (IN `p_id_majelis` INT)   BEGIN
    SELECT *
    FROM majelis
    WHERE id_majelis = p_id_majelis;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ReadPelayananIbadah` ()   BEGIN
    SELECT id_pelayanan_ibadah, nama_pelayanan_ibadah, keterangan, create_at ,is_deleted, update_at
    FROM pelayanan_ibadah;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `read_sejarah_gereja` ()   BEGIN
    SELECT *
    FROM sejarahgereja;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registrasi_baptis` (IN `p_id_jemaat` INT, IN `p_nama_ayah` VARCHAR(225), IN `p_nama_ibu` VARCHAR(225), IN `p_nama_lengkap` VARCHAR(225), IN `p_tempat_lahir` VARCHAR(225), IN `p_tanggal_lahir` VARCHAR(225), IN `p_jenis_kelamin` VARCHAR(25), IN `p_id_hub_keluarga` INT)   BEGIN
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
END$$

CREATE DEFINER=`` PROCEDURE `registrasi_keluarga_by_id` (IN `p_id_registrasi_keluarga` INT)   BEGIN
    SELECT 
        `id_registrasi_keluarga`,
        `id_jemaat`,
        `no_kk`,
        `nama_kepala_keluarga`
    FROM 
        `registrasi_keluarga`
    WHERE 
        `id_registrasi_keluarga` = p_id_registrasi_keluarga;
END$$

CREATE DEFINER=`` PROCEDURE `sp_create_majelis` (IN `p_id_jemaat` INT, IN `p_tgl_tahbis` DATE, IN `p_tgl_akhir_jabatan` DATE, IN `p_id_status_pelayan` INT)   BEGIN
    -- Insert into majelis table
    INSERT INTO majelis (
        id_jemaat,
        tgl_tahbis,
        tgl_akhir_jabatan,
        id_status_pelayan
    ) VALUES (
        p_id_jemaat,
        p_tgl_tahbis,
        p_tgl_akhir_jabatan,
        p_id_status_pelayan
    );

    -- Update role_jemaat in jemaat table
    UPDATE jemaat
    SET role_jemaat = 'majelis'
    WHERE id_jemaat = p_id_jemaat;
END$$

CREATE DEFINER=`` PROCEDURE `sp_delete_majelis` (IN `p_id_majelis` INT)   BEGIN
    DECLARE v_id_jemaat INT;

    -- Dapatkan id_jemaat yang terkait dengan id_majelis
    SELECT id_jemaat INTO v_id_jemaat
    FROM majelis
    WHERE id_majelis = p_id_majelis;

    -- Hapus data majelis berdasarkan id_majelis
    DELETE FROM majelis
    WHERE id_majelis = p_id_majelis;

    -- Update role_jemaat di tabel jemaat menjadi 'jemaat'
    UPDATE jemaat
    SET role_jemaat = 'jemaat'
    WHERE id_jemaat = v_id_jemaat;
END$$

CREATE DEFINER=`` PROCEDURE `sp_get_jemaat` ()   BEGIN
    SELECT 
	`id_jemaat`,
        `nama_depan`,
        `nama_belakang`,
        `id_registrasi_keluarga`,
        `id_hub_keluarga`
    FROM 
        `jemaat`;
END$$

CREATE DEFINER=`` PROCEDURE `sp_get_jemaat_by_id` (IN `p_id_jemaat` INT)   BEGIN
    SELECT 
	`id_jemaat`,
        `nama_depan`,
        `nama_belakang`,
        `id_registrasi_keluarga`,
        `id_hub_keluarga`
    FROM 
        `jemaat`
    WHERE 
        `id_jemaat` = p_id_jemaat;
END$$

CREATE DEFINER=`` PROCEDURE `sp_update_jemaat` (IN `p_id_jemaat` INT, IN `p_nama_depan` VARCHAR(225), IN `p_nama_belakang` VARCHAR(225), IN `p_id_registrasi_keluarga` INT, IN `p_id_hub_keluarga` INT)   BEGIN
    UPDATE `jemaat`
    SET 
        `nama_depan` = p_nama_depan,
        `nama_belakang` = p_nama_belakang,
        `id_registrasi_keluarga` = p_id_registrasi_keluarga,
        `id_hub_keluarga` = p_id_hub_keluarga,
        `update_at` = CURRENT_TIMESTAMP()
    WHERE 
        `id_jemaat` = p_id_jemaat;
END$$

CREATE DEFINER=`` PROCEDURE `sp_update_majelis` (IN `p_id_majelis` INT, IN `p_tgl_tahbis` VARCHAR(225), IN `p_tgl_akhir_jabatan` VARCHAR(225), IN `p_id_status_pelayan` INT)   BEGIN
    UPDATE majelis
    SET
        tgl_tahbis = p_tgl_tahbis,
        tgl_akhir_jabatan = p_tgl_akhir_jabatan,
        id_status_pelayan = p_id_status_pelayan,
        update_at = CURRENT_TIMESTAMP()
    WHERE
        id_majelis = p_id_majelis;
END$$

CREATE DEFINER=`` PROCEDURE `tambah_data_kegiatan` (IN `jenis_kegiatan_id` INT, IN `jemaatID` INT, IN `kegiatan_nama` VARCHAR(225), IN `kegiatan_lokasi` VARCHAR(225), IN `kegiatan_foto` VARCHAR(400), IN `keterangan` TEXT)   BEGIN
    INSERT INTO waktu_kegiatan (id_jenis_kegiatan, id_jemaat, nama_kegiatan, lokasi_kegiatan, foto_kegiatan, keterangan)
    VALUES (jenis_kegiatan_id, jemaatID, kegiatan_nama, kegiatan_lokasi, kegiatan_foto, keterangan);
END$$

CREATE DEFINER=`` PROCEDURE `tambah_pengeluaran` (IN `p_id_jemaat` INT, IN `p_jumlah_pengeluaran` INT, IN `p_tanggal_pengeluaran` VARCHAR(225), IN `p_keterangan_pengeluaran` VARCHAR(225), IN `p_id_kategori_pengeluaran` INT, IN `p_id_bank` INT, IN `p_bukti_pengeluaran` VARCHAR(500))   BEGIN
    INSERT INTO pengeluaran (
	id_jemaat,
        jumlah_pengeluaran,
        tanggal_pengeluaran,
        keterangan_pengeluaran,
        id_kategori_pengeluaran,
        id_bank,
        bukti_pengeluaran
    ) VALUES (
	p_id_jemaat,
        p_jumlah_pengeluaran,
        p_tanggal_pengeluaran,
        p_keterangan_pengeluaran,
        p_id_kategori_pengeluaran,
        p_id_bank,
        p_bukti_pengeluaran
    );
END$$

CREATE DEFINER=`` PROCEDURE `ubah_data_kegiatan` (IN `id_kegiatan` INT, IN `jenis_kegiatan_id` INT, IN `jemaatID` INT, IN `kegiatan_nama` VARCHAR(225), IN `kegiatan_foto` VARCHAR(400), IN `keterangan` TEXT)   BEGIN
    UPDATE waktu_kegiatan 
    SET 
        id_jenis_kegiatan = jenis_kegiatan_id,
        id_jemaat = jemaatID,
        nama_kegiatan = kegiatan_nama,
        foto_kegiatan = kegiatan_foto,
        keterangan = keterangan
    WHERE
        id_waktu_kegiatan = id_kegiatan;
END$$

CREATE DEFINER=`` PROCEDURE `ubah_pengeluaran` (IN `p_IDpengeluaran` INT, IN `p_IDJemaat` INT, IN `p_bukti_pengeluaran` VARCHAR(500), IN `p_jumlah_pengeluaran` INT, IN `p_tanggal_pengeluaran` VARCHAR(255), IN `p_keterangan_pengeluaran` VARCHAR(255), IN `p_id_kategori_pengeluaran` INT, IN `p_id_bank` INT)   BEGIN
    UPDATE pengeluaran
    SET
	id_jemaat = p_IDJemaat,
        jumlah_pengeluaran = p_jumlah_pengeluaran,
        tanggal_pengeluaran = p_tanggal_pengeluaran,
        keterangan_pengeluaran = p_keterangan_pengeluaran,
        id_kategori_pengeluaran = p_id_kategori_pengeluaran,
        id_bank = p_id_bank,
        bukti_pengeluaran = p_bukti_pengeluaran
    WHERE
        id_pengeluaran = p_IDpengeluaran;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateJemaatProcedure` (IN `jemaatID` INT, IN `namaDepan` VARCHAR(225), IN `namaBelakang` VARCHAR(225), IN `jenisKelamin` VARCHAR(225), IN `alamat` VARCHAR(455), IN `idBidangPendidikan` INT, IN `idPekerjaan` INT, IN `noHP` VARCHAR(225), IN `isBaptis` VARCHAR(225), IN `isMenikah` VARCHAR(225), IN `isMeninggal` VARCHAR(225), IN `keterangan` VARCHAR(500), IN `email` VARCHAR(225), IN `PASSWORD` VARCHAR(225), IN `bidangPendidikanLainnya` VARCHAR(225), IN `namaPekerjaanLainnya` VARCHAR(225))   BEGIN
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
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `UpdateJemaatProfileProcedure` (IN `jemaatID` INT, IN `namaDepan` VARCHAR(225), IN `namaBelakang` VARCHAR(225), IN `tempatLahir` VARCHAR(225), IN `noHP` VARCHAR(225), IN `alamat` VARCHAR(455), IN `email` VARCHAR(225))   BEGIN
    UPDATE jemaat SET
        nama_depan = namaDepan,
        nama_belakang = namaBelakang,
        tempat_lahir = tempatLahir,
        no_hp = noHP,
        alamat = alamat,
        email = email
    WHERE id_jemaat = jemaatID;
END$$

CREATE DEFINER=`` PROCEDURE `UpdateRegistrasiSidi` (IN `p_id_registrasi_sidi` INT, IN `p_tanggal_sidi` DATE, IN `p_nats_sidi` VARCHAR(225), IN `p_nomor_surat_sidi` INT, IN `p_nama_pendeta_sidi` VARCHAR(225), IN `p_id_status` INT)   BEGIN
    UPDATE registrasi_sidi
    SET
        tanggal_sidi = p_tanggal_sidi,
        nats_sidi = p_nats_sidi,
        nomor_surat_sidi = p_nomor_surat_sidi,
        nama_pendeta_sidi = p_nama_pendeta_sidi,
        id_status = p_id_status
    WHERE
        id_registrasi_sidi = p_id_registrasi_sidi;
END$$

CREATE DEFINER=`` PROCEDURE `UpdateStatusAndKeteranganPernikahanByIdRegistrasiNikah` (IN `registrasiNikahID` INT, IN `newStatusID` INT, IN `newKeterangan` VARCHAR(255))   BEGIN
    UPDATE registrasi_pernikahan
    SET id_status = newStatusID,
        keterangan = newKeterangan
    WHERE id_registrasi_nikah = registrasiNikahID;
END$$

CREATE DEFINER=`` PROCEDURE `update_pelayan_gereja` (IN `p_id_pelayan` INT, IN `p_id_jemaat` INT, IN `p_nama_pelayan` VARCHAR(225), IN `p_is_tahbisan` TINYINT, IN `p_keterangan` TEXT)   BEGIN
    UPDATE pelayan_gereja
    SET 
	id_jemaat = p_id_jemaat,
        nama_pelayan = p_nama_pelayan,
        isTahbisan = p_is_tahbisan,
        keterangan = p_keterangan,
        update_at = CURRENT_TIMESTAMP()
    WHERE 
        id_pelayan = p_id_pelayan;
END$$

CREATE DEFINER=`` PROCEDURE `update_pemasukan` (IN `p_id_pemasukan` INT, IN `p_id_jemaat` INT, IN `p_tanggal_pemasukan` DATE, IN `p_total_pemasukan` INT, IN `p_bentuk_pemasukan` VARCHAR(225), IN `p_id_kategori_pemasukan` INT, IN `p_bukti_pemasukan` VARCHAR(500), IN `p_id_bank` INT)   BEGIN
    UPDATE pemasukan
    SET
	id_jemaat = p_id_jemaat,
        tanggal_pemasukan = p_tanggal_pemasukan,
        total_pemasukan = p_total_pemasukan,
        bentuk_pemasukan = p_bentuk_pemasukan,
        id_kategori_pemasukan = p_id_kategori_pemasukan,
        bukti_pemasukan = p_bukti_pemasukan,
        id_bank = p_id_bank
    WHERE
        id_pemasukan = p_id_pemasukan;
END$$

CREATE DEFINER=`` PROCEDURE `update_registrasi_baptis` (IN `p_id_registrasi_baptis` INT, IN `p_no_surat_baptis` VARCHAR(225), IN `p_nama_pendeta_baptis` VARCHAR(225), IN `p_file_surat_baptis` VARCHAR(400), IN `p_tanggal_baptis` VARCHAR(225), IN `p_id_status` INT)   BEGIN
    UPDATE `registrasi_baptis`
    SET
        `no_surat_baptis` = p_no_surat_baptis,
        `nama_pendeta_baptis` = p_nama_pendeta_baptis,
        `file_surat_baptis` = p_file_surat_baptis,
        `tanggal_baptis` = p_tanggal_baptis,
        `id_status` = p_id_status,
        `update_at` = CURRENT_TIMESTAMP
    WHERE
        `id_registrasi_baptis` = p_id_registrasi_baptis;
END$$

CREATE DEFINER=`` PROCEDURE `update_registrasi_keluarga` (IN `p_id_registrasi_keluarga` INT, IN `p_no_kk` VARCHAR(225), IN `p_id_jemaat` INT, IN `p_nama_kepala_keluarga` VARCHAR(225))   BEGIN
    UPDATE `registrasi_keluarga`
    SET 
        `no_kk` = p_no_kk,
        `id_jemaat` = p_id_jemaat,
        `nama_kepala_keluarga` = p_nama_kepala_keluarga,
        `updated_at` = CURRENT_TIMESTAMP()
    WHERE 
        `id_registrasi_keluarga` = p_id_registrasi_keluarga;
END$$

CREATE DEFINER=`` PROCEDURE `update_sejarah_gereja` (IN `p_id_sejarah` INT, IN `p_id_jemaat` INT, IN `p_sejarah` TEXT)   BEGIN
    UPDATE sejarahgereja
    SET
        sejarah = p_sejarah,
        id_jemaat = p_id_jemaat
    WHERE
        id_sejarah = p_id_sejarah;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `bank`
--

CREATE TABLE `bank` (
  `id_bank` int(11) NOT NULL,
  `nama_bank` varchar(225) NOT NULL,
  `keterangan` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bank`
--

INSERT INTO `bank` (`id_bank`, `nama_bank`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'BRI', 'Bank Rakyat Indonesia', '2024-04-27 15:22:33', '2024-04-27 15:22:33', '2024-04-27 15:22:33'),
(2, 'BNI', 'Bank Negara Indonesia', '2024-04-27 15:22:45', '2024-04-27 15:22:45', '2024-04-27 15:22:45'),
(3, 'Bank Mayapada', 'Bank Mayapada', '2024-04-27 15:23:03', '2024-04-27 15:23:03', '2024-04-27 15:23:03'),
(4, 'BCA', 'Bank Central Asia', '2024-04-27 15:23:41', '2024-04-27 15:23:41', '2024-04-27 15:23:41'),
(5, 'Dana', 'Platform Dana', '2024-04-27 15:23:58', '2024-04-27 15:23:58', '2024-04-27 15:23:58'),
(6, 'Mandiri', 'Bank Mandiri', '2024-04-27 15:24:11', '2024-04-27 15:24:11', '2024-04-27 15:24:11'),
(7, 'BSI', 'Bank Syariah Indonesia', '2024-04-27 15:24:27', '2024-04-27 15:24:27', '2024-04-27 15:24:27'),
(8, 'Bank Aceh', 'Bank Aceh', '2024-04-27 15:24:42', '2024-04-27 15:24:42', '2024-04-27 15:24:42'),
(9, 'Bank Lainnya', 'Bank Lainnya yang terdaftar di Indonesia', '2024-04-27 15:25:20', '2024-04-27 15:25:20', '2024-04-27 15:25:20'),
(10, 'Tunai', 'Secara Tunai', '2024-04-29 12:42:03', '2024-04-29 12:42:03', '2024-04-29 12:42:03');

-- --------------------------------------------------------

--
-- Table structure for table `bidang_pendidikan`
--

CREATE TABLE `bidang_pendidikan` (
  `id_bidang_pendidikan` int(11) NOT NULL,
  `nama_bidang_pendidikan` varchar(225) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `bidang_pendidikan`
--

INSERT INTO `bidang_pendidikan` (`id_bidang_pendidikan`, `nama_bidang_pendidikan`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(0, 'Pilih Pendidikan', 'Pilih Pendidikan Anda', '2024-04-02 06:47:53', '2024-04-02 06:47:53', '2024-04-02 06:47:53'),
(1, 'Pendidikan Formal (SD,SMP,SMA)', 'Pendidikan umum merupakan pendidikan dasar dan menengah yang mengutamakan perluasan pengetahuan yang diperlukan oleh peserta didik untuk melanjutkan pendidikan ke jenjang yang lebih tinggi.', '2024-04-01 03:33:53', '2024-04-01 03:33:53', '2024-04-01 03:33:53'),
(2, 'Pendidikan Kejuruan (SMK)', 'Pendidikan kejuruan merupakan pendidikan menengah yang mempersiapkan peserta didik terutama untuk bekerja dalam bidang tertentu.', '2024-04-01 03:34:50', '2024-04-01 03:34:50', '2024-04-01 03:34:50'),
(3, 'Pendidikan Profesi', 'Pendidikan profesi merupakan pendidikan tinggi setelah program sarjana yang mempersiapkan peserta didik untuk memasuki suatu profesi atau menjadi seorang profesional.', '2024-04-01 03:35:54', '2024-04-01 03:35:54', '2024-04-01 03:35:54'),
(4, 'Pendidikan Vokasi', 'Pendidikan vokasi merupakan pendidikan tinggi yang mempersiapkan peserta didik untuk memiliki pekerjaan dengan keahlian terapan tertentu maksimal dalam jenjang diploma 4 setara dengan program sarjana (strata 1).', '2024-04-01 03:36:15', '2024-04-01 03:36:15', '2024-04-01 03:36:15'),
(5, 'Pendidikan Keagamaan', 'Pendidikan keagamaan merupakan pendidikan dasar, menengah, dan tinggi yang mempersiapkan peserta didik untuk dapat menjalankan peranan yang menuntut penguasaan pengetahuan dan pengalaman terhadap ajaran agama ', '2024-04-01 03:36:46', '2024-04-01 03:36:46', '2024-04-01 03:36:46'),
(6, 'Pendidikan Khusus', 'Pendidikan khusus merupakan penyelenggaraan pendidikan untuk peserta didik yang berkebutuhan khusus atau peserta didik yang memiliki kecerdasan luar biasa yang diselenggarakan secara inklusif (bergabung dengan sekolah biasa) ', '2024-04-01 03:37:14', '2024-04-01 03:37:14', '2024-04-01 03:37:14'),
(7, 'Pilih Bidang Pendidikan Anda', 'Pilih Bidang Pendidikan Anda Sekarang', '2024-04-01 08:17:43', '2024-04-01 08:17:43', '2024-04-01 08:17:43');

-- --------------------------------------------------------

--
-- Table structure for table `hubungan_keluarga`
--

CREATE TABLE `hubungan_keluarga` (
  `id_hub_keluarga` int(11) NOT NULL,
  `nama_hub_keluarga` varchar(225) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `hubungan_keluarga`
--

INSERT INTO `hubungan_keluarga` (`id_hub_keluarga`, `nama_hub_keluarga`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(0, 'Isi Hubungan Keluarga', 'Isi Hubungan Keluarga Anda', '2024-04-01 08:14:40', '2024-04-01 08:14:40', '2024-04-01 08:14:40'),
(1, 'Ayah', 'Orang Tua Dalam Keluarga', '2024-04-01 03:15:49', '2024-04-01 03:16:23', '2024-04-01 03:16:23'),
(2, 'Ibu', 'Orang Tua Dalam Keluarga', '2024-04-01 03:16:30', '2024-04-01 03:16:50', '2024-04-01 03:16:50'),
(3, 'Anak', 'Anak Dalam Keluarga', '2024-04-01 03:17:34', '2024-04-01 03:17:34', '2024-04-01 03:17:34'),
(4, 'Saudara Kandung', 'Saudara Kandung Di Dalam Keluarga', '2024-04-01 03:18:05', '2024-04-01 03:18:05', '2024-04-01 03:18:05');

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_ibadah`
--

CREATE TABLE `jadwal_ibadah` (
  `id_jadwal_ibadah` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL,
  `id_jenis_minggu` int(11) NOT NULL,
  `tgl_ibadah` timestamp NOT NULL DEFAULT current_timestamp(),
  `sesi_ibadah` varchar(225) NOT NULL,
  `keterangan` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jadwal_ibadah`
--

INSERT INTO `jadwal_ibadah` (`id_jadwal_ibadah`, `id_jemaat`, `id_jenis_minggu`, `tgl_ibadah`, `sesi_ibadah`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(79, 3, 12, '2024-05-27 17:00:00', 'Sesi 1', 'Rayakan 25 Tahun Berdirinya HKBP Palmarum', '2024-05-28 02:16:41', '2024-05-28 02:16:41', '2024-05-28 02:16:41'),
(80, 3, 4, '2024-05-27 17:00:00', 'Sesi 2', 'Perayaan berdirinya HKBP Palmarum Distrik II SilindunPerayaan berdirinya HKBP Palmarum Distrik II Silindung', '2024-05-28 02:35:09', '2024-05-28 02:35:09', '2024-05-28 02:35:09'),
(81, 3, 2, '2023-12-23 17:00:00', 'Sesi 3', 'Ibadah Malam Natal', '2024-05-28 02:37:38', '2024-05-28 02:37:38', '2024-05-28 02:37:38');

-- --------------------------------------------------------

--
-- Table structure for table `jemaat`
--

CREATE TABLE `jemaat` (
  `id_jemaat` int(11) NOT NULL,
  `id_registrasi_keluarga` int(50) NOT NULL,
  `role_jemaat` varchar(225) NOT NULL DEFAULT 'jemaat',
  `nama_depan` varchar(225) NOT NULL,
  `nama_belakang` varchar(225) NOT NULL,
  `tgl_lahir` varchar(225) NOT NULL DEFAULT 'Isi tgl lahir',
  `email` varchar(225) DEFAULT 'Isi Email Anda',
  `password` varchar(225) DEFAULT 'Isi Password Anda',
  `gelar_depan` varchar(225) DEFAULT 'Isi Gelar Anda',
  `gelar_belakang` varchar(225) DEFAULT 'Isi Gelar Anda',
  `tempat_lahir` varchar(50) DEFAULT 'Isi Tempat Lahir',
  `jenis_kelamin` varchar(225) DEFAULT 'Isi Jenis Kelamin',
  `id_hub_keluarga` int(11) DEFAULT 0,
  `id_status_pernikahan` int(11) DEFAULT 0,
  `id_status_ama_ina` int(11) DEFAULT 0,
  `id_status_anak` int(11) DEFAULT 0,
  `id_pendidikan` int(11) DEFAULT 0,
  `id_bidang_pendidikan` int(11) DEFAULT 0,
  `bidang_pendidikan_lainnya` varchar(225) DEFAULT 'Isi Bidang Pendidikan Lainnya(opsional)',
  `id_pekerjaan` int(11) DEFAULT 0,
  `nama_pekerjaan_lainnya` varchar(225) DEFAULT 'Isi Bidang Pendidikan Lainnya',
  `gol_darah` varchar(225) DEFAULT 'Pilih Gol Darah',
  `alamat` varchar(455) DEFAULT 'Isi Alamat Anda',
  `isSidi` varchar(225) DEFAULT 'Pilih Status Sidi Anda',
  `id_kecamatan` int(11) DEFAULT 0,
  `no_telepon` varchar(50) DEFAULT '0',
  `no_hp` int(11) DEFAULT 0,
  `foto_jemaat` varchar(500) DEFAULT 'avatarjemaat.jpg',
  `keterangan` varchar(500) DEFAULT 'Isi Ketarangan',
  `isBaptis` varchar(225) DEFAULT 'Pilih Status Baptis',
  `isMenikah` varchar(225) DEFAULT 'Pilih Status Menikah',
  `isMeninggal` varchar(225) DEFAULT 'tidak',
  `isRPP` varchar(225) DEFAULT 'tidak',
  `create_at` timestamp NULL DEFAULT current_timestamp(),
  `update_at` timestamp NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jemaat`
--

INSERT INTO `jemaat` (`id_jemaat`, `id_registrasi_keluarga`, `role_jemaat`, `nama_depan`, `nama_belakang`, `tgl_lahir`, `email`, `password`, `gelar_depan`, `gelar_belakang`, `tempat_lahir`, `jenis_kelamin`, `id_hub_keluarga`, `id_status_pernikahan`, `id_status_ama_ina`, `id_status_anak`, `id_pendidikan`, `id_bidang_pendidikan`, `bidang_pendidikan_lainnya`, `id_pekerjaan`, `nama_pekerjaan_lainnya`, `gol_darah`, `alamat`, `isSidi`, `id_kecamatan`, `no_telepon`, `no_hp`, `foto_jemaat`, `keterangan`, `isBaptis`, `isMenikah`, `isMeninggal`, `isRPP`, `create_at`, `update_at`, `is_deleted`) VALUES
(2, 4, 'majelis', 'Miranda', 'Angeliaa', '2004-4-27', 'mirandaangelia@gmail.com', 'eran123', 'Isi Gelar Anda', 'Isi Gelar Anda', 'Jakarta Selatan', 'Laki-laki', 2, 0, 0, 0, 4, 0, 'Pendidikan Hobi', 5, 'Software Developer', 'AB', 'Jln Sudirman Nomor 136', 'Sidi', 10, '0', 0, 'Blue Abstract Geometric Nature Photo Collage Aesthetic Desktop Wallpaper.png', '', 'Baptis', 'Menikah', '', 'tidak', '2024-04-01 08:25:09', '2024-05-29 14:00:48', '2024-04-01 08:25:09'),
(3, 4, 'majelis', 'Johannes Bastian Jasa', 'Sipayung', '2005-4-27', 'johannesssipayung27@gmail.com', 'oan123', 'Isi Gelar Anda', 'Isi Gelar Anda', 'Isi Tempat Lahir', 'Laki-laki', 3, 0, 0, 0, 5, 3, '', 3, '', 'B', 'Sempurna Garden No 14', 'Sidi', 5, '0', 0, '31. Johannes Sipayung.JPG', '', 'Baptis', 'Belum Menikah', '', 'tidak', '2024-04-26 09:49:31', '2024-05-29 14:05:05', '2024-04-26 09:49:31'),
(4, 3, 'jemaat', 'Pangeran', 'Silaen', '2024-05-15', 'eran@gmail.com', 'eran123', 'Isi Gelar Anda', 'Isi Gelar Anda', 'Isi Tempat Lahir', 'Perempuan', 3, 0, 0, 0, 3, 2, '', 1, '', 'B', 'Porsea', 'Sidi', 11, '0', 818461691, '9cd0d7a3-143d-4ffe-9fa2-d38ef5ff9c581601109962879451765.jpg', '', 'Baptis', 'Belum Menikah', '', 'tidak', '2024-05-15 01:35:02', '2024-05-15 01:35:02', '2024-05-15 01:35:02'),
(5, 4, 'jemaat', 'Rado', 'Radel', '1992-05-27', 'rado@gmail.com', 'rado123', 'Isi Gelar Anda', 'Isi Gelar Anda', 'Medan', 'Laki-laki', 1, 0, 0, 0, 5, 3, '', 3, '', 'B', 'Tarutung Kota', 'Sidi', 15, '0', 2147483647, '1000161418.jpg', '', 'Baptis', 'Menikah', '', 'tidak', '2024-05-27 03:50:47', '2024-05-29 09:08:42', '2024-05-27 03:50:47'),
(27, 6, 'jemaat', 'Putri', 'Simamora', '2024-06-03', 'putri@gmail.com', 'putri123', 'Isi Gelar Anda', 'Isi Gelar Anda', 'Isi Tempat Lahir', 'Laki-laki', 2, 0, 0, 0, 6, 2, '', 4, '', 'B', 'Kota Medan', 'Sidi', 9, '0', 27497242, 'dc632daa-6f5d-4e17-a798-23e578ba4f1c8644940942985676578.jpg', '', 'Baptis', 'Belum Menikah', '', 'tidak', '2024-05-29 14:14:15', '2024-05-29 14:14:15', '2024-05-29 14:14:15'),
(28, 6, 'jemaat', 'Johannes', 'Sipayung', '2024-05-29', 'johan@gmail.com', 'johan', 'Isi Gelar Anda', 'Isi Gelar Anda', 'Isi Tempat Lahir', 'Laki-laki', 1, 0, 0, 0, 4, 2, '', 4, '', 'AB', 'Medan', 'Sidi', 13, '0', 397537053, '9cbc2c10-eb2d-4515-9e15-a9fab9a1ac875215267458425854923.jpg', '', 'Baptis', 'Menikah', '', 'tidak', '2024-05-29 14:16:24', '2024-05-29 14:16:24', '2024-05-29 14:16:24'),
(29, 6, 'jemaat', 'Bastian', 'Sipayung', '2024-05-15', 'bastian@gmail.com', 'bastian', 'Isi Gelar Anda', 'Isi Gelar Anda', 'Medan', 'Laki-laki', 3, 0, 0, 0, 4, 1, '', 0, '', 'B', 'Medan', 'Belum Sidi', 13, '0', 85895, '487ba8e7-b48e-484d-9bd4-ac62a5177a677841920866733917208.jpg', '', 'Belum Baptis', 'Belum Menikah', '', 'tidak', '2024-05-29 14:18:50', '2024-05-30 02:19:08', '2024-05-29 14:18:50'),
(30, 6, 'jemaat', 'Meida', 'Tita', 'Isi tgl lahir', 'Isi Email Anda', 'Isi Password Anda', 'Isi Gelar Anda', 'Isi Gelar Anda', 'Isi Tempat Lahir', 'Isi Jenis Kelamin', 3, 0, 0, 0, 0, 0, 'Isi Bidang Pendidikan Lainnya(opsional)', 0, 'Isi Bidang Pendidikan Lainnya', 'Pilih Gol Darah', 'Isi Alamat Anda', 'Pilih Status Sidi Anda', 0, '0', 0, 'avatarjemaat.jpg', 'Isi Ketarangan', 'Pilih Status Baptis', 'Pilih Status Menikah', 'tidak', 'tidak', '2024-05-29 14:20:45', '2024-05-30 03:10:42', '2024-05-29 14:20:45');

-- --------------------------------------------------------

--
-- Table structure for table `jenis_kegiatan`
--

CREATE TABLE `jenis_kegiatan` (
  `id_jenis_kegiatan` int(11) NOT NULL,
  `nama_jenis_kegiatan` varchar(225) NOT NULL,
  `keterangan` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jenis_kegiatan`
--

INSERT INTO `jenis_kegiatan` (`id_jenis_kegiatan`, `nama_jenis_kegiatan`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'Kegiatan Dalam Gereja', 'Semua kegiatan yang dilakukan didalam lingkungan gereja', '2024-04-09 14:04:39', '2024-04-09 14:04:39', '2024-04-09 14:04:39'),
(2, 'Kegiatan Luar Gereja', 'Kegiatan yang dilakukan diluar lingkungan gereja', '2024-04-09 14:05:25', '2024-04-09 14:05:25', '2024-04-09 14:05:25');

-- --------------------------------------------------------

--
-- Table structure for table `jenis_minggu`
--

CREATE TABLE `jenis_minggu` (
  `id_jenis_minggu` int(11) NOT NULL,
  `nama_jenis_minggu` varchar(225) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jenis_minggu`
--

INSERT INTO `jenis_minggu` (`id_jenis_minggu`, `nama_jenis_minggu`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'Advent I – IV', 'Minggu-minggu yang menandai persiapan untuk perayaan Natal.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(2, 'Natal', 'Minggu yang merayakan kelahiran Yesus Kristus.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(3, 'Setelah Tahun Baru', 'Minggu-minggu setelah pergantian tahun baru.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(4, 'I – IV Setelah Epifani / Hapapatar', 'Minggu-minggu setelah perayaan Epifani, yang menekankan penerangan dan pemahaman yang semakin mendalam.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(5, 'Septuagesima / Sexagesima', 'Minggu-minggu sebelum Minggu sengsara, dengan penekanan khusus pada persiapan spiritual.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(6, 'Estomihi', 'Minggu dengan kutipan Mazmur 31:3, menekankan perlindungan dan pertahanan yang diberikan oleh Tuhan.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(7, 'Invocavit', 'Minggu dengan kutipan Mazmur 91:15a, menggambarkan respons positif terhadap panggilan Tuhan.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(8, 'Reminiscere', 'Minggu dengan kutipan Mazmur 25:6, mengajak untuk mengingat rahmat dan kasih setia Tuhan.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(9, 'Okuli', 'Minggu dengan kutipan Mazmur 25:15a, menekankan konsentrasi dan ketaatan kepada Tuhan.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(10, 'Letare', 'Minggu dengan kutipan Yesaya 66:10a, mengundang untuk bersukacita.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(11, 'Judika', 'Minggu dengan kutipan Mazmur 43:1a, memohon untuk dilepaskan dari kesulitan.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(12, 'Palmarum (Maremare)', 'Minggu Palma, merayakan kedatangan Yesus ke Yerusalem sebelum sengsara-Nya.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(13, 'Paskah Pertama / Paskah', 'Minggu Paskah, merayakan kebangkitan Yesus Kristus.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(14, 'Quasimodo Geniti', 'Minggu dengan kutipan 1 Petrus 2:2, menggambarkan kerinduan akan kata-kata rohani.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(15, 'Miserekordias Domini', 'Minggu dengan kutipan Mazmur 33:5b, menekankan kasih Allah yang melimpah.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(16, 'Jubilate', 'Minggu dengan kutipan Mazmur 66:1, mengajak untuk memuji Tuhan.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(17, 'Kantate', 'Minggu dengan kutipan Mazmur 98:1a, mengundang untuk menyanyikan pujian baru bagi Allah.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(18, 'Rogate', 'Minggu dengan kutipan Yeremia 29:12, menekankan pentingnya doa.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(19, 'Exaudi', 'Minggu dengan kutipan Mazmur 27:7, memohon agar Tuhan mendengarkan doa-doa.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(20, 'Pentakosta', 'Minggu Pentakosta, merayakan turunnya Roh Kudus kepada murid-murid Yesus.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(21, 'Trinitatis', 'Minggu Tritunggal, merayakan Tritunggal Kudus: Bapa, Anak, dan Roh Kudus.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45'),
(22, 'I – XXIV Setelah Trinitatis', 'Minggu-minggu biasa setelah hari Minggu Tritunggal.', '2024-04-16 13:38:45', '2024-04-16 13:38:45', '2024-04-16 13:38:45');

-- --------------------------------------------------------

--
-- Table structure for table `jenis_status`
--

CREATE TABLE `jenis_status` (
  `id_jenis_status` int(11) NOT NULL,
  `jenis_status` varchar(225) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `jenis_status`
--

INSERT INTO `jenis_status` (`id_jenis_status`, `jenis_status`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'Pernikahan', 'Status Pernikahan Di Dalam Jemaat\r\n', '2024-04-01 03:19:28', '2024-04-01 03:19:28', '2024-04-01 03:19:28'),
(2, 'Pembaptisan', 'Status Pembaptisan Di Dalam Keluarga', '2024-04-01 03:19:49', '2024-04-01 03:19:49', '2024-04-01 03:19:49'),
(3, 'Angkat Sidi', 'Status Angkat Sidi Di Dalam Jemaat', '2024-04-01 03:20:18', '2024-04-01 03:20:18', '2024-04-01 03:20:18'),
(4, 'Ama', 'Status Ama Di Dalam Jemaat', '2024-04-01 03:21:20', '2024-04-01 03:21:20', '2024-04-01 03:21:20'),
(5, 'Ina', 'Status Ina Di Dalam Jemaat', '2024-04-01 03:21:51', '2024-04-01 03:21:51', '2024-04-01 03:21:51'),
(6, 'Anak', 'Sebagai Anak Di Dalam Keluarga', '2024-04-01 03:31:39', '2024-04-01 03:31:39', '2024-04-01 03:31:39'),
(7, 'Pilih Status Anda', 'Pilih Status Anda Terlebih Dahulu', '2024-04-01 08:15:46', '2024-04-01 08:15:46', '2024-04-01 08:15:46'),
(8, 'Pendeta', 'Pendeta Gereja', '2024-04-16 02:30:51', '2024-04-16 02:30:51', '2024-04-16 02:30:51'),
(9, 'Pemusik Gereja', 'Pemusik Gereja HKBP Palmarum', '2024-04-16 02:31:07', '2024-04-16 02:31:07', '2024-04-16 02:31:07'),
(10, 'Majelis Jemaat', 'Majelis Jemaat HKBP Palmarum', '2024-04-16 03:38:16', '2024-04-16 03:38:16', '2024-04-16 03:38:16'),
(11, 'Bendahara', 'Bendahara Jemaat HKBP Palmarum Tarutung', '2024-04-19 09:49:03', '2024-04-19 09:49:03', '2024-04-19 09:49:03'),
(12, 'Menunggu Persetujuan', 'Menunggu Persetujuan Majelis HKBP Palmarum', '2024-04-30 01:49:24', '2024-04-30 01:49:24', '2024-04-30 01:49:24'),
(13, 'Ditolak ', 'Ditolak oleh Majelis HKBP Palmarum Tarutung', '2024-04-30 01:49:47', '2024-04-30 01:49:47', '2024-04-30 01:49:47'),
(14, 'Disetujui', 'Disetujui oleh Majelis HKBP Palmarum Tarutung', '2024-04-30 01:50:09', '2024-04-30 01:50:09', '2024-04-30 01:50:09'),
(15, 'Bendahara Organisasi', 'Bendahara Organisasi HKBP Palmarum Tarutung', '2024-05-16 02:08:41', '2024-05-16 02:08:41', '2024-05-16 02:08:41'),
(16, 'Sekretaris Organisasi ', 'Sekretaris Organisasi HKBP Palmarum Tarutung', '2024-05-16 02:09:25', '2024-05-16 02:09:25', '2024-05-16 02:09:25'),
(17, 'Ketua Organisasi', 'Ketua Organisasi HKBP Palmarum', '2024-05-16 02:10:29', '2024-05-16 02:10:29', '2024-05-16 02:10:29'),
(18, 'Wakil Ketua Organisasi', 'Wakil Ketua Organisasi HKBP Palmarum Tarutung', '2024-05-16 02:11:35', '2024-05-16 02:11:35', '2024-05-16 02:11:35');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_pemasukab`
--

CREATE TABLE `kategori_pemasukab` (
  `id_kategori_pemasukan` int(11) NOT NULL,
  `kategori_pemasukan` varchar(225) NOT NULL,
  `deskripsi` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategori_pemasukab`
--

INSERT INTO `kategori_pemasukab` (`id_kategori_pemasukan`, `kategori_pemasukan`, `deskripsi`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'Bantuan Dana Organisasi', 'Bantuan Dana dari Organisasi', '2024-04-29 01:15:53', '2024-04-29 01:15:53', '2024-04-29 01:15:53'),
(2, 'Persembahan Kebaktian ', 'Persembahan Gereja HKBP Palmarum', '2024-04-29 01:16:18', '2024-04-29 01:16:18', '2024-04-29 01:16:18'),
(3, 'Sumbangan Jemaat', 'Persembahan Sumbangan Jemaat HKBP Palmarum Tarutung', '2024-04-29 01:26:37', '2024-04-29 01:26:37', '2024-04-29 01:26:37');

-- --------------------------------------------------------

--
-- Table structure for table `kategori_pengeluaran`
--

CREATE TABLE `kategori_pengeluaran` (
  `id_kategori_pengeluaran` int(11) NOT NULL,
  `kategori_pengeluaran` varchar(225) NOT NULL,
  `deskripsi` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategori_pengeluaran`
--

INSERT INTO `kategori_pengeluaran` (`id_kategori_pengeluaran`, `kategori_pengeluaran`, `deskripsi`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 'Perbaikan Gereja', 'Pengeluaran Maintenance Gereja HKBP Palmarum', '2024-04-27 15:12:13', '2024-04-27 15:12:13', '2024-04-27 15:12:13'),
(2, 'Acara Gereja', 'Pengeluaran Acara Gereja HKBP Palmarum', '2024-04-27 15:13:42', '2024-04-27 15:13:42', '2024-04-27 15:13:42'),
(3, 'Acara Diluar Gereja', 'Pengeluaran Acara Diluar Gereja ', '2024-04-27 15:15:18', '2024-04-27 15:15:18', '2024-04-27 15:15:18'),
(4, 'Bantuan Dana ke Organisasi', 'Bantuan Dana Ke Organisasi di Gereja HKBP Palmarum', '2024-04-27 15:18:03', '2024-04-27 15:18:03', '2024-04-27 15:18:03'),
(5, 'Dana Sosial', 'Bantuan Dana Sosial', '2024-04-27 15:19:11', '2024-04-27 15:19:11', '2024-04-27 15:19:11'),
(6, 'Lainnya', 'Pengeluaran Lainnya yang terjadi didalam gereja maupun diluar gereja', '2024-04-27 15:19:50', '2024-04-27 15:19:50', '2024-04-27 15:19:50');

-- --------------------------------------------------------

--
-- Table structure for table `kecamatan`
--

CREATE TABLE `kecamatan` (
  `id_kecamatan` int(11) NOT NULL,
  `nama_kecamatan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kecamatan`
--

INSERT INTO `kecamatan` (`id_kecamatan`, `nama_kecamatan`, `create_at`, `update_at`, `is_deleted`) VALUES
(0, 'Pilih Kecamatan Anda', '2024-04-01 08:18:39', '2024-04-01 08:18:39', '2024-04-01 08:18:39'),
(1, 'Kecamatan Adian Koting', '2024-04-01 06:47:32', '2024-04-01 06:47:32', '2024-04-01 06:47:32'),
(2, 'Kecamatan Garoga', '2024-04-01 06:48:11', '2024-04-01 06:48:11', '2024-04-01 06:48:11'),
(3, 'Kecamatan Muara', '2024-04-01 06:48:32', '2024-04-01 06:48:32', '2024-04-01 06:48:32'),
(4, 'kecamatan Pagaran\r\n', '2024-04-01 06:48:51', '2024-04-01 06:48:51', '2024-04-01 06:48:51'),
(5, 'Kecamatan Pahae Jae', '2024-04-01 06:49:03', '2024-04-01 06:49:03', '2024-04-01 06:49:03'),
(6, 'Kecamatan Pahae Julu', '2024-04-01 06:49:40', '2024-04-01 06:49:40', '2024-04-01 06:49:40'),
(7, 'Kecamatan Pangaribuan', '2024-04-01 06:49:55', '2024-04-01 06:49:55', '2024-04-01 06:49:55'),
(8, 'Kecamatan Parmonangan', '2024-04-01 06:50:07', '2024-04-01 06:50:07', '2024-04-01 06:50:07'),
(9, 'Kecamatan Purba Tua', '2024-04-01 06:50:19', '2024-04-01 06:50:19', '2024-04-01 06:50:19'),
(10, 'Kecamatan Siatas Barita', '2024-04-01 06:50:30', '2024-04-01 06:50:30', '2024-04-01 06:50:30'),
(11, 'Kecamatan Siborongborong', '2024-04-01 06:50:47', '2024-04-01 06:50:47', '2024-04-01 06:50:47'),
(12, 'Kecamatan Sipangumban', '2024-04-01 06:51:15', '2024-04-01 06:51:15', '2024-04-01 06:51:15'),
(13, 'Kecamatan Sipahutar', '2024-04-01 06:51:23', '2024-04-01 06:51:23', '2024-04-01 06:51:23'),
(14, 'Kecamatan Sipoholon', '2024-04-01 06:51:34', '2024-04-01 06:51:34', '2024-04-01 06:51:34'),
(15, 'Kecamatan Tarutung', '2024-04-01 06:51:48', '2024-04-01 06:51:48', '2024-04-01 06:51:48');

-- --------------------------------------------------------

--
-- Table structure for table `majelis`
--

CREATE TABLE `majelis` (
  `id_majelis` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL,
  `tgl_tahbis` date NOT NULL,
  `tgl_akhir_jabatan` date NOT NULL,
  `id_status_pelayan` int(11) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `majelis`
--

INSERT INTO `majelis` (`id_majelis`, `id_jemaat`, `tgl_tahbis`, `tgl_akhir_jabatan`, `id_status_pelayan`, `create_at`, `update_at`, `is_deleted`) VALUES
(19, 2, '2024-05-29', '2025-05-27', 9, '2024-05-27 06:43:22', '2024-05-27 06:43:22', '2024-05-27 06:43:22');

-- --------------------------------------------------------

--
-- Table structure for table `pekerjaan`
--

CREATE TABLE `pekerjaan` (
  `id_pekerjaan` int(11) NOT NULL,
  `pekerjaan` varchar(225) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pekerjaan`
--

INSERT INTO `pekerjaan` (`id_pekerjaan`, `pekerjaan`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(0, 'Tidak Bekerja', 'Tidak Bekerja Apapun', '2024-04-01 06:41:21', '2024-04-01 06:41:21', '2024-04-01 06:41:21'),
(1, 'Petani', 'Petani Ladang', '2024-04-01 06:44:28', '2024-04-01 06:44:28', '2024-04-01 06:44:28'),
(2, 'Pegawai Negara Sipil', 'PNS(Pegawai Negara Sipil)', '2024-04-01 06:45:03', '2024-04-01 06:45:03', '2024-04-01 06:45:03'),
(3, 'Pegawai Swasta', 'Pegawai BUMS', '2024-04-01 06:45:21', '2024-04-01 06:45:21', '2024-04-01 06:45:21'),
(4, 'Pegawai BUMN', 'Pegawai Badan Usaha Milik Negara', '2024-04-01 06:45:48', '2024-04-01 06:45:48', '2024-04-01 06:45:48'),
(5, 'Pilih Pekerjaan Anda', 'Pilih Pekerjaan Anda ', '2024-04-01 08:18:22', '2024-04-01 08:18:22', '2024-04-01 08:18:22');

-- --------------------------------------------------------

--
-- Table structure for table `pelayanan_ibadah`
--

CREATE TABLE `pelayanan_ibadah` (
  `id_pelayanan_ibadah` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL,
  `nama_pelayanan_ibadah` varchar(225) NOT NULL,
  `keterangan` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pelayanan_ibadah`
--

INSERT INTO `pelayanan_ibadah` (`id_pelayanan_ibadah`, `id_jemaat`, `nama_pelayanan_ibadah`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(3, 3, 'Miranda Angelia', 'Singer', '2024-04-16 13:42:27', '2024-04-16 13:42:27', '2024-04-16 13:42:27'),
(4, 3, 'Johannes Bastian Jasa Sipayung', 'Pemain Piano', '2024-04-16 13:42:43', '2024-05-14 01:33:57', '2024-04-16 13:42:43'),
(48, 3, 'Natanael Marpaung', 'Pemain Piano', '2024-05-28 02:35:29', '2024-05-28 02:35:29', '2024-05-28 02:35:29'),
(49, 3, 'Handika Harahap', 'Pemain Kecapi', '2024-05-28 02:37:54', '2024-05-28 02:37:54', '2024-05-28 02:37:54');

-- --------------------------------------------------------

--
-- Table structure for table `pelayan_gereja`
--

CREATE TABLE `pelayan_gereja` (
  `id_pelayan` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL,
  `nama_pelayan` varchar(225) NOT NULL,
  `isTahbisan` tinyint(1) NOT NULL DEFAULT 1,
  `keterangan` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pelayan_gereja`
--

INSERT INTO `pelayan_gereja` (`id_pelayan`, `id_jemaat`, `nama_pelayan`, `isTahbisan`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(2, 3, 'Martin mir', 0, 'Ketua Namaposo', '2024-04-16 02:24:03', '2024-05-27 04:45:38', '2024-04-16 02:24:03'),
(7, 3, 'Benyamin', 1, 'Ketua Seksi Bapa', '2024-04-19 08:13:49', '2024-05-16 15:08:14', '2024-04-19 08:13:49'),
(13, 3, 'Johannes', 1, 'Pengantar Jemaat', '2024-05-16 14:01:15', '2024-05-16 15:09:12', '2024-05-16 14:01:15'),
(15, 3, 'Meida Butarbutar', 0, 'Sekretaris Namaposo HKBP Palmarum', '2024-05-26 07:56:35', '2024-05-26 08:18:07', '2024-05-26 07:56:35'),
(16, 3, 'Eran123', 0, 'Pemain Piano', '2024-05-27 04:25:14', '2024-05-27 04:25:24', '2024-05-27 04:25:14');

-- --------------------------------------------------------

--
-- Table structure for table `pelayan_ibadah`
--

CREATE TABLE `pelayan_ibadah` (
  `id_pelayan_ibadah` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL,
  `id_jadwal_ibadah` int(11) NOT NULL,
  `id_pelayanan_ibadah` int(11) NOT NULL,
  `keterangan` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pelayan_ibadah`
--

INSERT INTO `pelayan_ibadah` (`id_pelayan_ibadah`, `id_jemaat`, `id_jadwal_ibadah`, `id_pelayanan_ibadah`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(72, 3, 79, 4, 'Rayakan 25 Tahun Berdirinya HKBP Palmarum', '2024-05-28 02:30:59', '2024-05-28 02:30:59', '2024-05-28 02:30:59'),
(73, 3, 80, 48, 'Perayaan berdirinya HKBP Palmarum Distrik II Silindun', '2024-05-28 02:35:42', '2024-05-28 02:35:42', '2024-05-28 02:35:42'),
(74, 3, 81, 49, 'Ibadah Malam Natal', '2024-05-28 02:38:16', '2024-05-28 02:38:16', '2024-05-28 02:38:16');

-- --------------------------------------------------------

--
-- Table structure for table `pemasukan`
--

CREATE TABLE `pemasukan` (
  `id_pemasukan` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL,
  `tanggal_pemasukan` timestamp NOT NULL DEFAULT current_timestamp(),
  `total_pemasukan` int(11) NOT NULL,
  `bentuk_pemasukan` varchar(225) NOT NULL,
  `id_kategori_pemasukan` int(11) NOT NULL,
  `bukti_pemasukan` varchar(500) NOT NULL,
  `id_bank` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pemasukan`
--

INSERT INTO `pemasukan` (`id_pemasukan`, `id_jemaat`, `tanggal_pemasukan`, `total_pemasukan`, `bentuk_pemasukan`, `id_kategori_pemasukan`, `bukti_pemasukan`, `id_bank`, `created_at`, `updated_at`, `is_deleted`) VALUES
(0, 3, '2024-03-11 17:00:00', 345000, 'Transfer', 1, 'pemasukan\\6faf2967-5bd4-4fe5-9c6d-fb823cddff3e.png', 2, '2024-05-11 08:43:53', '2024-05-11 08:43:53', '2024-05-11 08:43:53'),
(1, 3, '2024-03-11 17:00:00', 345000, 'Transfer', 1, 'pemasukan\\4bdb6e75-060b-4cae-974d-df397db2daac.png', 2, '2024-05-11 08:46:55', '2024-05-11 08:46:55', '2024-05-11 08:46:55'),
(2, 3, '2024-03-11 17:00:00', 345000, 'Transfer', 1, 'pemasukan\\8573e4d3-99ae-4f6c-b47e-09a597ec4120.png', 2, '2024-05-11 08:47:04', '2024-05-11 08:47:04', '2024-05-11 08:47:04'),
(3, 3, '0000-00-00 00:00:00', 345000, 'Transfer', 1, 'pemasukan\\018c8021-4a97-4c68-89d8-20a608bc4909.png', 2, '2024-05-11 08:56:37', '2024-05-11 08:56:37', '2024-05-11 08:56:37'),
(4, 3, '0000-00-00 00:00:00', 345000, 'Transfer', 3, '7b35a32e-58a1-421f-9767-1834b3ef00733853368447484078742.jpg', 2, '2024-05-11 08:59:40', '2024-05-11 08:59:40', '2024-05-11 08:59:40'),
(5, 3, '0000-00-00 00:00:00', 50000, 'Transfer', 3, 'Blue Abstract Geometric Nature Photo Collage Aesthetic Desktop Wallpaper.png', 2, '2024-05-11 09:17:01', '2024-05-11 09:17:01', '2024-05-11 09:17:01'),
(6, 3, '0000-00-00 00:00:00', 2000, 'Transfer ', 2, '1ea1fecc-b761-4df7-a3b5-fef17ca96b6d6875375819099935477.jpg', 3, '2024-05-12 06:14:51', '2024-05-12 06:14:51', '2024-05-12 06:14:51'),
(7, 3, '0000-00-00 00:00:00', 2000, 'Transfer ', 2, 'fc499c1d-4ebc-448c-b87c-b709c5c5769f4534624014300898523.jpg', 5, '2024-05-12 06:14:54', '2024-05-12 06:14:54', '2024-05-12 06:14:54'),
(8, 3, '0000-00-00 00:00:00', 50000, 'Transfer', 1, '90765213-cf6f-4ea7-925d-620c057cc93d5337397450703154514.jpg', 2, '2024-05-13 01:44:19', '2024-05-13 01:44:19', '2024-05-13 01:44:19'),
(9, 3, '0000-00-00 00:00:00', 8000, 'Transfer', 3, '2f11817b-e43b-4aae-95fe-e2c5a451c3b81373746606419614028.jpg', 4, '2024-05-26 06:04:40', '2024-05-26 06:04:40', '2024-05-26 06:04:40'),
(10, 3, '2024-05-25 17:00:00', 50000, 'Transfer', 3, 'b042ae64-1c13-4cc6-a96f-b80c7367f53f4045293985008047415.jpg', 8, '2024-05-26 06:13:29', '2024-05-26 06:13:29', '2024-05-26 06:13:29'),
(11, 3, '2024-05-25 17:00:00', 90000, 'Transfer', 3, 'c955c4cd-2395-4f6c-ae28-09fa1015bb564305771405660411583.jpg', 7, '2024-05-26 06:14:40', '2024-05-26 06:14:40', '2024-05-26 06:14:40'),
(12, 3, '2024-05-25 17:00:00', 6000, 'transfer', 2, '36b6cf79-041d-49a3-b3f3-e767e0bf20cd2674687525206572257.jpg', 3, '2024-05-26 06:25:27', '2024-05-26 06:25:27', '2024-05-26 06:25:27'),
(13, 3, '2024-05-15 17:00:00', 500000, 'Transfer', 3, '1000161143.jpg', 4, '2024-05-27 04:32:30', '2024-05-27 04:32:30', '2024-05-27 04:32:30'),
(14, 3, '2024-05-26 17:00:00', 50000, 'Persembahan', 2, '1000161418.jpg', 5, '2024-05-27 07:14:15', '2024-05-27 07:14:15', '2024-05-27 07:14:15');

-- --------------------------------------------------------

--
-- Table structure for table `pendidikan`
--

CREATE TABLE `pendidikan` (
  `id_pendidikan` int(11) NOT NULL,
  `pendidikan` varchar(225) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pendidikan`
--

INSERT INTO `pendidikan` (`id_pendidikan`, `pendidikan`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(0, 'Pilih Pendidikan Anda', 'Pilih Pendidikan Anda Terlebih Dahulu', '2024-04-01 08:17:02', '2024-04-01 08:17:02', '2024-04-01 08:17:02'),
(1, 'Sekolah Dasar', 'Pendidikan Sekolah Dasar', '2024-04-01 06:38:51', '2024-04-01 06:38:51', '2024-04-01 06:38:51'),
(2, 'Tidak Sekolah', 'Belum Sekolah/Tidak Sekolah', '2024-04-01 06:39:13', '2024-04-01 06:39:13', '2024-04-01 06:39:13'),
(3, 'SMP/SLTP', 'Sekolah Menengah Pertama', '2024-04-01 06:39:33', '2024-04-01 06:39:33', '2024-04-01 06:39:33'),
(4, 'SMA/SLTA', 'Sekolah Menengah Atas', '2024-04-01 06:39:47', '2024-04-01 06:39:47', '2024-04-01 06:39:47'),
(5, 'Diploma', 'Diploma (D1,D2,D3,D4)', '2024-04-01 06:40:15', '2024-04-01 06:40:15', '2024-04-01 06:40:15'),
(6, 'Strata 1', 'Pendidikan Strata 1', '2024-04-02 06:37:12', '2024-04-02 06:37:12', '2024-04-02 06:37:12'),
(7, 'Strata 2', 'Pendidikan Strata 2', '2024-04-01 06:40:29', '2024-04-01 06:40:29', '2024-04-01 06:40:29'),
(8, 'Strata 3', 'Pendidikan Strata 3', '2024-04-01 06:40:47', '2024-04-01 06:40:47', '2024-04-01 06:40:47');

-- --------------------------------------------------------

--
-- Table structure for table `pengeluaran`
--

CREATE TABLE `pengeluaran` (
  `id_pengeluaran` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL,
  `jumlah_pengeluaran` int(11) NOT NULL,
  `tanggal_pengeluaran` varchar(15) NOT NULL,
  `keterangan_pengeluaran` varchar(225) NOT NULL,
  `id_kategori_pengeluaran` int(11) NOT NULL,
  `id_bank` int(11) NOT NULL,
  `bukti_pengeluaran` varchar(500) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `pengeluaran`
--

INSERT INTO `pengeluaran` (`id_pengeluaran`, `id_jemaat`, `jumlah_pengeluaran`, `tanggal_pengeluaran`, `keterangan_pengeluaran`, `id_kategori_pengeluaran`, `id_bank`, `bukti_pengeluaran`, `created_at`, `updated_at`, `is_deleted`) VALUES
(13, 3, 1500000, '2024-4-27', 'Acara Kebaktian Minggu Malam HKBP Palmarum', 2, 6, 'pengeluaran\\27f8fe1c-79d7-45b0-9b92-6fb1be9ad947.JPG', '2024-04-28 05:08:09', '2024-04-28 05:08:09', '2024-04-28 05:08:09'),
(15, 3, 2000000, '2024-4-27', 'Acara Kebaktian Minggu Malam HKBP Palmarum', 2, 2, 'pengeluaran\\e0677290-7a10-4535-a1a3-ce175eba6bd8.JPG', '2024-04-28 05:28:44', '2024-04-28 05:28:44', '2024-04-28 05:28:44'),
(16, 3, 1300000, '2024-12-12', 'Acara Kebaktian Minggu Sore HKBP Palmarum', 2, 5, 'pengeluaran\\a52a7522-0541-4450-8d1b-00fa0c1ab01f.JPG', '2024-04-28 05:29:23', '2024-04-28 05:29:23', '2024-04-28 05:29:23'),
(17, 3, 300000, '2024-4-23', 'Acara Gereja', 2, 3, 'Blue Abstract Geometric Nature Photo Collage Aesthetic Desktop Wallpaper.png', '2024-05-12 06:09:05', '2024-05-12 06:09:05', '2024-05-12 06:09:05'),
(18, 3, 250000, '', 'beli makan siang acara partonggoan', 3, 3, 'b71013dc-abc6-4968-9b05-ef3b9c4769e81702515449079629790.jpg', '2024-05-12 06:26:29', '2024-05-12 06:26:29', '2024-05-12 06:26:29'),
(19, 3, 58400, '2024-05-26', 'Pembayaran Tukang Perbaikan Gereja', 1, 4, 'b7a307f1-9e7f-4365-bfb6-216f757707724510942123802244832.jpg', '2024-05-26 07:06:03', '2024-05-26 07:06:03', '2024-05-26 07:06:03'),
(20, 3, 24494, '2024-05-29', 'Pembayaran Tukang Perbaikan Atap Gereja', 1, 8, '611e898d-611f-4b3e-b034-fe71d2ed5f583726761485678272413.jpg', '2024-05-26 07:09:26', '2024-05-26 07:09:26', '2024-05-26 07:09:26'),
(21, 3, 58000, '2024-05-23', 'Pembayaran Pemain Musik Natal 1 HKBP Palmarum', 2, 3, '3fe87da7-b6ef-4f3b-b205-5f1daca44e324519568933003311686.jpg', '2024-05-26 07:10:28', '2024-05-26 07:10:28', '2024-05-26 07:10:28'),
(22, 3, 600000, '2024-05-21', 'Meperbaiki Atap Bocor Gereja', 1, 7, '1000161193.jpg', '2024-05-27 04:34:56', '2024-05-27 04:34:56', '2024-05-27 04:34:56'),
(23, 3, 200000, '2024-05-28', 'Kursi Rusak', 1, 3, '1000161418.jpg', '2024-05-27 07:15:33', '2024-05-27 07:15:33', '2024-05-27 07:15:33');

-- --------------------------------------------------------

--
-- Table structure for table `registrasi_baptis`
--

CREATE TABLE `registrasi_baptis` (
  `id_registrasi_baptis` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL,
  `nama_ayah` varchar(225) NOT NULL,
  `nama_ibu` varchar(225) NOT NULL,
  `nama_lengkap` varchar(225) NOT NULL,
  `tempat_lahir` varchar(225) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `jenis_kelamin` varchar(25) NOT NULL,
  `id_hub_keluarga` int(11) NOT NULL,
  `tanggal_baptis` varchar(225) DEFAULT NULL,
  `no_surat_baptis` varchar(225) DEFAULT NULL,
  `nama_pendeta_baptis` varchar(225) DEFAULT NULL,
  `file_surat_baptis` varchar(400) DEFAULT NULL,
  `id_status` int(11) NOT NULL DEFAULT 11,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `registrasi_baptis`
--

INSERT INTO `registrasi_baptis` (`id_registrasi_baptis`, `id_jemaat`, `nama_ayah`, `nama_ibu`, `nama_lengkap`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `id_hub_keluarga`, `tanggal_baptis`, `no_surat_baptis`, `nama_pendeta_baptis`, `file_surat_baptis`, `id_status`, `create_at`, `update_at`, `is_deleted`) VALUES
(1, 2, 'Johannes Sipayung', 'Miranda Angelia', 'Bastian Jasa Sipayung', 'Jakarta Selatan', '2029-05-18', 'Laki-laki', 3, '2029-5-19', '101270605', 'Pdt. Maruhum Sinaga', 'JMP Pertemuan 1.pdf', 13, '2024-04-30 02:16:38', '2024-05-01 03:35:38', '2024-04-30 02:16:38'),
(2, 2, 'Bastian', 'Angel', 'Pangeran', 'Porsea', '2004-05-21', 'Laki-Laki', 3, '2024-06-27', '97027502', 'Pdt. Leonal', 'suratBaptis\\file permohonan BPKP hilang (2).pdf', 13, '2024-05-21 06:34:41', '2024-05-23 04:41:48', '2024-05-21 06:34:41'),
(3, 2, 'ASUS', 'Macbook', 'Eran', 'Medan', '2024-05-21', 'Perempuan', 3, '2024-06-27', '97027502', 'Pdt. Leonal', 'PBO_w11s02_Hibernare_JavaFX.pdf', 13, '2024-05-21 06:40:58', '2024-05-23 07:19:55', '2024-05-21 06:40:58'),
(4, 3, 'Jasa', 'Mir', 'Justin', 'Medan', '2024-05-21', 'Laki-Laki', 3, '2024-05-31', '69265295', 'Pdt. Maruhum', 'baptis-1716431783374.pdf', 13, '2024-05-21 09:26:48', '2024-05-23 07:23:00', '2024-05-21 09:26:48'),
(5, 2, 'Johannes', 'Miranda', 'Jasa', 'Medan', '2024-05-23', 'Laki-Laki', 3, '2024-05-23', '5925580', 'Pdt. Maruhum', 'baptis-1716395706273.pdf', 13, '2024-05-23 07:27:23', '2024-05-23 07:40:53', '2024-05-23 07:27:23'),
(6, 3, 'Johannes', 'Miranda', 'Oan', 'Medan', '2024-05-24', 'Laki-laki', 3, '2024-05-27', '855588', 'Pdt.  Maruhum', '6448af68-aa66-45ee-b4dd-a4d919e5f6f8.pdf', 13, '2024-05-24 08:07:52', '2024-05-27 04:18:17', '2024-05-24 08:07:52'),
(7, 2, 'egeg', 'egeg', 'egeg', 'egeg', '2024-05-24', 'egeg', 3, '2024-05-27', '5458', 'Martin', '6448af68-aa66-45ee-b4dd-a4d919e5f6f8.pdf', 13, '2024-05-24 08:45:14', '2024-05-27 06:41:50', '2024-05-24 08:45:14'),
(8, 2, 'egeg', 'egeg', 'egeg', 'egeg', '2024-05-24', 'egeg', 3, NULL, NULL, NULL, NULL, 11, '2024-05-24 08:45:20', '2024-05-24 08:45:20', '2024-05-24 08:45:20'),
(9, 2, 'egeg', 'egeg', 'egeg', 'eg', '2024-05-24', 'egeg', 3, NULL, NULL, NULL, NULL, 11, '2024-05-24 08:46:11', '2024-05-24 08:46:11', '2024-05-24 08:46:11'),
(10, 2, 'ege', 'eeg', 'egeg', 'eg', '2024-05-24', 'egeg', 3, NULL, NULL, NULL, NULL, 11, '2024-05-24 08:46:41', '2024-05-24 08:46:41', '2024-05-24 08:46:41'),
(11, 3, 'ege', 'eeg', 'egeg', 'eg', '2024-05-24', 'egeg', 3, NULL, NULL, NULL, NULL, 11, '2024-05-24 08:46:58', '2024-05-24 08:46:58', '2024-05-24 08:46:58'),
(12, 3, 'ege', 'eeg', 'egeg', 'eg', '2024-05-24', 'egeg', 3, NULL, NULL, NULL, NULL, 11, '2024-05-24 08:47:20', '2024-05-24 08:47:20', '2024-05-24 08:47:20'),
(13, 2, 'Johannes Sipayung', 'Miranda Angelia', 'Bastian Jasa', 'Medan', '2024-05-24', 'Laki-laki', 3, NULL, NULL, NULL, NULL, 11, '2024-05-24 13:00:08', '2024-05-24 13:00:08', '2024-05-24 13:00:08'),
(14, 5, 'Rado', 'Rini', 'Bastian', 'Medan', '2023-05-27', 'Laki laki', 3, '2024-06-02', '0516285', 'Pdt Maruhum', '6448af68-aa66-45ee-b4dd-a4d919e5f6f8.pdf', 13, '2024-05-27 07:19:35', '2024-05-27 07:21:08', '2024-05-27 07:19:35'),
(16, 28, 'Johannes', 'Putri', 'Bastian', 'Medan', '2024-05-15', 'Laki-laki', 3, '2024-06-02', '09966468', 'Pdt Maruhum', 'baptis-1716878422948.pdf', 13, '2024-05-29 16:25:40', '2024-05-30 06:22:11', '2024-05-29 16:25:40'),
(17, 28, 'Johannes Sipayung', 'Putri Simamora', 'Meida Tita1', 'Medan', '2024-05-30', 'Isi Jenis Kelamin', 3, NULL, NULL, NULL, NULL, 11, '2024-05-30 02:52:21', '2024-05-30 02:52:21', '2024-05-30 02:52:21'),
(18, 27, 'Johannes Sipayung', 'Putri Simamora', 'Bastian Sipayung', 'Medan', '2024-05-15', 'Laki-laki', 3, '2024-06-30', '574737485', 'Pdt MARUHUM', 'baptis-1716878422948.pdf', 13, '2024-06-03 07:43:30', '2024-06-03 07:51:14', '2024-06-03 07:43:30');

-- --------------------------------------------------------

--
-- Table structure for table `registrasi_keluarga`
--

CREATE TABLE `registrasi_keluarga` (
  `id_registrasi_keluarga` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL DEFAULT 3,
  `no_kk` varchar(50) NOT NULL,
  `nama_kepala_keluarga` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `id_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `registrasi_keluarga`
--

INSERT INTO `registrasi_keluarga` (`id_registrasi_keluarga`, `id_jemaat`, `no_kk`, `nama_kepala_keluarga`, `create_at`, `updated_at`, `id_deleted`) VALUES
(3, 3, '12710192479579', 'Pangeran Silaen', '2024-05-29 02:59:41', '2024-05-29 06:39:52', '2024-05-29 02:59:41'),
(4, 3, '1271012706050002', 'Johannes Bastian Jasa Sipayung', '2024-05-29 03:32:17', '2024-05-29 06:37:23', '2024-05-29 03:32:17'),
(5, 3, '127295792759', 'Aldo Darel', '2024-05-29 03:41:59', '2024-05-29 06:40:09', '2024-05-29 03:41:59'),
(6, 3, '1271012706050003', 'Johannes Sipayung', '2024-05-29 14:10:14', '2024-05-30 02:12:34', '2024-05-29 14:10:14');

-- --------------------------------------------------------

--
-- Table structure for table `registrasi_pernikahan`
--

CREATE TABLE `registrasi_pernikahan` (
  `id_registrasi_nikah` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL,
  `nama_gereja_laki` varchar(225) NOT NULL,
  `nama_laki` varchar(225) NOT NULL,
  `nama_ayah_laki` varchar(225) NOT NULL,
  `nama_ibu_laki` varchar(225) NOT NULL,
  `nama_gereja_perempuan` varchar(225) NOT NULL,
  `nama_perempuan` varchar(225) NOT NULL,
  `nama_ayah_perempuan` varchar(225) NOT NULL,
  `nama_ibu_perempuan` varchar(225) NOT NULL,
  `keterangan` text DEFAULT NULL,
  `id_status` int(11) NOT NULL DEFAULT 11,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `registrasi_pernikahan`
--

INSERT INTO `registrasi_pernikahan` (`id_registrasi_nikah`, `id_jemaat`, `nama_gereja_laki`, `nama_laki`, `nama_ayah_laki`, `nama_ibu_laki`, `nama_gereja_perempuan`, `nama_perempuan`, `nama_ayah_perempuan`, `nama_ibu_perempuan`, `keterangan`, `id_status`, `create_at`, `update_at`) VALUES
(6, 2, 'Gereja A', 'John Doe', 'John\'s Father', 'John\'s Mother', 'Gereja B', 'Jane Smith', 'Jane\'s Father', 'Jane\'s Mother', 'Request surat pernikahan disetujui oleh majelis , selengkapnya akan di beritahukan lagi', 13, '2024-05-25 03:39:41', '2024-05-25 03:39:41'),
(7, 2, 'GKPS Teladan Medan', 'Johannes Sipayung', 'Jasa Sipayung', 'Mac', 'GBI Jakarta Utara', 'Miranda Angelia', 'Crack', 'Airr', 'Pernikahan Johannes dan Miranda Disetujui akan di proses, informasi selengkapnya akan di beritahukan oleh Majelis Jemaat HKBP Palmarum Tarutung', 13, '2024-05-25 04:01:20', '2024-05-25 04:01:20'),
(8, 5, 'hkbp kalideres', 'john', 'joko', 'vina', 'gkpi sipoholon', 'onichan', 'hansen', 'gio', NULL, 11, '2024-05-29 02:24:05', '2024-05-29 02:24:05');

-- --------------------------------------------------------

--
-- Table structure for table `registrasi_sidi`
--

CREATE TABLE `registrasi_sidi` (
  `id_registrasi_sidi` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL,
  `nama_ayah` varchar(225) NOT NULL,
  `nama_ibu` varchar(225) NOT NULL,
  `nama_lengkap` varchar(225) NOT NULL,
  `tempat_lahir` varchar(50) NOT NULL,
  `tanggal_lahir` date NOT NULL,
  `jenis_kelamin` varchar(15) NOT NULL,
  `id_hub_keluarga` int(11) NOT NULL,
  `tanggal_sidi` varchar(50) DEFAULT NULL,
  `nats_sidi` varchar(225) DEFAULT NULL,
  `nomor_surat_sidi` int(11) DEFAULT NULL,
  `nama_pendeta_sidi` varchar(225) DEFAULT NULL,
  `file_surat_baptis` varchar(225) DEFAULT NULL,
  `id_status` int(11) NOT NULL DEFAULT 11,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `registrasi_sidi`
--

INSERT INTO `registrasi_sidi` (`id_registrasi_sidi`, `id_jemaat`, `nama_ayah`, `nama_ibu`, `nama_lengkap`, `tempat_lahir`, `tanggal_lahir`, `jenis_kelamin`, `id_hub_keluarga`, `tanggal_sidi`, `nats_sidi`, `nomor_surat_sidi`, `nama_pendeta_sidi`, `file_surat_baptis`, `id_status`, `create_at`, `update_at`, `is_deleted`) VALUES
(23, 2, 'geg', 'eg', 'ohoh', 'ohoh', '2024-05-23', 'Laki-laki', 3, '2029-05-23', 'Matius 3:7', 9249692, 'Pdt. Maruhum', 'ejeohjeh', 13, '2024-05-24 12:44:04', '2024-05-24 12:44:04', '2024-05-24 12:44:04'),
(24, 2, 'Johannes Sipayung', 'Miranda Angela', 'Bastian Sipayung', 'Jakarta Selatan', '2029-05-24', 'Laki-laki', 3, '2024-05-31', 'Matius 12:8', 39750357, 'Pdt. Maruhum', 'baptis-1716431783374.pdf', 13, '2024-05-24 12:58:30', '2024-05-24 12:58:30', '2024-05-24 12:58:30'),
(25, 3, 'Johannes', 'Miranda', 'Budi Utomo', 'Medan', '2024-05-24', 'Laki-laki', 3, '2024-05-16', 'Lukas 3:6', 9385849, 'Pdt Maruhum', 'baptis.pdf', 13, '2024-05-24 13:31:21', '2024-05-24 13:31:21', '2024-05-24 13:31:21'),
(26, 2, 'Johannes Sipayung', 'Miranda Angelia', 'Bastian Jasa', 'Bandung', '2030-05-07', 'Laki-laki', 3, '2047-05-24', 'Mazmur 23:19', 2957292, 'Pdt. Leonal', 'baptis-1716390771115.pdf', 13, '2024-05-24 15:17:25', '2024-05-24 15:17:25', '2024-05-24 15:17:25'),
(27, 28, 'Johannes Sipayung', 'Putri Simamora', 'Bastian Sipayung', 'Medan', '2024-05-15', 'Laki-laki', 3, NULL, NULL, NULL, NULL, 'baptis-1716878422948.pdf', 11, '2024-05-30 02:56:24', '2024-05-30 02:56:24', '2024-05-30 02:56:24');

-- --------------------------------------------------------

--
-- Table structure for table `sejarahgereja`
--

CREATE TABLE `sejarahgereja` (
  `id_sejarah` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL,
  `sejarah` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `sejarahgereja`
--

INSERT INTO `sejarahgereja` (`id_sejarah`, `id_jemaat`, `sejarah`) VALUES
(1, 3, 'Gereja HKBP Palmarum sudah berdiri selama 25 tahun. Gereja ini lahir pada minggu Palmarum, sehingga setiap kali memasuki minggu tersebut, jemaat merayakan hari jadi Gereja HKBP Palmarum. Proses pendirian gereja ini tidak mudah dan melibatkan banyak perjuangan. Perkumpulan pertama diadakan pada Mei 1993, dengan pertemuan yang masih berlangsung di rumah jemaat secara bergantian. Pada Desember 1993, jemaat membeli tanah dan membangun gedung semi-permanen untuk tempat ibadah.Pada tahun 1999, gereja ini pindah ke Jl. T.D. Pardede, Aek Kristok, menggunakan tempat ibadah yang sebelumnya dipakai oleh gereja Pea Raja. Lalu, pada tahun 2001, gereja pindah ke Stadion Tarutung, lokasi yang menjadi tempat ibadah HKBP Palmarum Tarutung hingga saat ini. Pendiriannya tidak terlepas dari pergumulan berat yang dihadapi HKBP antara tahun 1993 dan 1999, yang disebabkan oleh perpecahan di berbagai tempat. Meskipun mengalami tantangan, gereja ini tetap setia kepada Tuhan dan berkembang.Kini, Gereja HKBP Palmarum Tarutung telah menjadi bagian dari HKBP ressort dan mengalami pertumbuhan yang signifikan. Dari semula hanya memiliki 34 keluarga jemaat, kini jumlahnya telah mencapai 145 keluarga. Perkembangan ini mencerminkan ketekunan dan semangat komunitas gereja dalam menjalankan ibadah dan pelayanan kepada masyarakat.');

-- --------------------------------------------------------

--
-- Table structure for table `status`
--

CREATE TABLE `status` (
  `id_status` int(11) NOT NULL,
  `status` varchar(225) NOT NULL,
  `id_jenis_status` int(11) NOT NULL,
  `keterangan` varchar(225) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id_status`, `status`, `id_jenis_status`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(0, 'Pilih Status', 7, 'Pilih Status Anda sekarang', '2024-04-01 08:16:18', '2024-04-01 08:16:18', '2024-04-01 08:16:18'),
(1, 'Ama', 4, 'Sebagai Ama di Jemaat', '2024-04-01 03:27:15', '2024-04-01 03:27:15', '2024-04-01 03:27:15'),
(2, 'Ina', 5, 'Sebagai Ina di Jemaat', '2024-04-01 03:27:44', '2024-04-01 03:27:44', '2024-04-01 03:27:44'),
(3, 'Anak', 6, 'Sebagai Anak Di Jemaat', '2024-04-01 03:31:59', '2024-04-01 03:31:59', '2024-04-01 03:31:59'),
(7, 'Pemusik Gereja', 9, 'Pemusik Gereja HKBP Palmarum', '2024-04-16 02:31:47', '2024-04-16 02:31:47', '2024-04-16 02:31:47'),
(8, 'Pendeta', 8, 'Pendeta HKBP Palmarum HKBP Palmarum', '2024-04-16 02:32:07', '2024-04-16 02:32:07', '2024-04-16 02:32:07'),
(9, 'Majelis Jemaat', 10, 'Majelis Jemaat HKBP Palmarum', '2024-04-16 03:38:54', '2024-04-16 03:38:54', '2024-04-16 03:38:54'),
(10, 'Bendahara', 11, 'Bendahara Jemaat', '2024-04-19 09:49:27', '2024-04-19 09:49:27', '2024-04-19 09:49:27'),
(11, 'Menunggu Persetujuan', 12, 'Menunggu Persetujuan Majelis HKBP Palmarum Tarutung', '2024-04-30 01:50:41', '2024-04-30 01:50:41', '2024-04-30 01:50:41'),
(12, 'Ditolak', 13, 'Ditolak oleh Majelis HKBP Palmarum Tarutung', '2024-04-30 01:51:03', '2024-04-30 01:51:03', '2024-04-30 01:51:03'),
(13, 'Disetujui', 14, 'Disetujui oleh Majelis HKBP Palmarum Tarutung', '2024-04-30 01:51:34', '2024-04-30 01:51:34', '2024-04-30 01:51:34'),
(14, 'Bendahara Organisasi', 15, 'Bendahara Organisasi HKBP Palmarum Tarutung', '2024-05-16 02:12:26', '2024-05-16 02:12:26', '2024-05-16 02:12:26'),
(15, 'Sekretaris Organisasi ', 16, 'Sekretaris Organisasi HKBP Palmarum Tarutung', '2024-05-16 02:13:15', '2024-05-16 02:13:15', '2024-05-16 02:13:15'),
(16, 'Ketua Organisasi', 17, 'Ketua Organisasi HKBP Palmarum Tarutung', '2024-05-16 02:13:52', '2024-05-16 02:13:52', '2024-05-16 02:13:52'),
(17, 'Wakil Ketua Organisasi', 18, 'Wakil Ketua Organisasi HKBP Palmarum', '2024-05-16 02:14:35', '2024-05-16 02:14:35', '2024-05-16 02:14:35');

-- --------------------------------------------------------

--
-- Table structure for table `waktu_kegiatan`
--

CREATE TABLE `waktu_kegiatan` (
  `id_waktu_kegiatan` int(11) NOT NULL,
  `id_jenis_kegiatan` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL,
  `nama_kegiatan` varchar(225) NOT NULL,
  `lokasi_kegiatan` varchar(225) NOT NULL,
  `waktu_kegiatan` timestamp NOT NULL DEFAULT current_timestamp(),
  `foto_kegiatan` varchar(400) NOT NULL,
  `keterangan` varchar(4000) NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `update_at` timestamp NULL DEFAULT current_timestamp(),
  `is_deleted` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `waktu_kegiatan`
--

INSERT INTO `waktu_kegiatan` (`id_waktu_kegiatan`, `id_jenis_kegiatan`, `id_jemaat`, `nama_kegiatan`, `lokasi_kegiatan`, `waktu_kegiatan`, `foto_kegiatan`, `keterangan`, `create_at`, `update_at`, `is_deleted`) VALUES
(99, 1, 3, 'Ibadah di HKBP Simare Jae', 'eg', '2024-05-28 01:55:16', '1000161986.jpg', 'BALIGE - Bupati Toba Poltak Sitorus menyampaikan beberapa hal capaian pembangunan Pemerintah Kabupaten Toba termasuk di Kecamatan Laguboti dimana perbaikan infrastruktur jalan cukup besar dianggarkan.', '2024-05-28 01:55:16', '2024-05-28 01:55:16', '2024-05-28 01:55:16'),
(100, 1, 3, 'Perayaan Natal di Gereja Katolik Regina Pacis', 'Kabupaten Belitung', '2024-05-28 01:58:13', '1000161979.jpg', 'Umat kristiani mengikuti pelaksanaan kegiatan ibadah malam Natal di Gereja Paroki Regina Pacis, Kecamatan Tanjungpandan, Kabupaten Belitung, Selasa (24/12/2019) malam.\n\nPantauan posbelitung.co, pelaksanaan kegiatan ibadah berlangsung khidmat dan khusyuk.', '2024-05-28 01:58:13', '2024-05-28 01:58:13', '2024-05-28 01:58:13'),
(101, 1, 3, 'Pesta Pembangunan Gereja HKBP Pandumaan Desa Batumanumpak Kecamatan Nassau', 'Gereja HKBP Pandumaan Desa Batumanumpak Kecamatan Nassau', '2024-05-28 02:03:33', '1000161985.jpg', 'Pesta Pembangunan Gereja HKBP Pandumaan Desa Batumanumpak Kecamatan Nassau dilaksanakan pada hari Minggu, Tanggal 21 April 2024. Turut hadir dalam kegiatan tersebut Bapak Bupati Toba Ir.Poltak Sitorus, Bapak Sekretaris Daerah Augus Sitorus beserta jajaran Kepala Dinas, Camat Nassau Bapak Lamhot Pane, S.Kom dan Kepala Desa Batumanumpak, Lamhot Sipahutar.', '2024-05-28 02:03:33', '2024-05-28 02:03:33', '2024-05-28 02:03:33');

-- --------------------------------------------------------

--
-- Table structure for table `warta`
--

CREATE TABLE `warta` (
  `id_warta` int(11) NOT NULL,
  `id_jemaat` int(11) NOT NULL,
  `warta` text NOT NULL,
  `create_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `warta`
--

INSERT INTO `warta` (`id_warta`, `id_jemaat`, `warta`, `create_at`) VALUES
(85, 3, 'WARTA JEMAAT 28 Mei 2024\nMINGGU PALMARUM\n \n\nHKBP Palmarum Tarutung\nTopik:\n \n\n”LIHAT RAJAMU DATANG KEPADAMU”\n(IDA MA, NA RO MA RAJAMI MANOPOT HO)\n \n\nTINGTING NA MASA\n1. Bantuan Cat\nPada hari Sabtu 28 Mei 2024 kita menerima bantuan Cat tembok (senilai Rp. 3.000.000,-) dari PT. Pertamina Prabumulih, kiranya bantuan ini dapat lebih mendukung pelayanan di Gereja kita dan PT Pertamina semakin diberkati Tuhan.\n\nTINGTING SIPAMASAON\n1. Kegiatan Peringatan Paskah\na. Di Ari Jumat, 29 Maret 2024. Pesta parningotan Ari Hamamate ni Tuhan Jesus, tapatupa Ibadah Pukul 13.00 WIB ( jam 1 siang), laos diuduti ulaon na badia dohot ulaon na hohom, laos diuduti kegiatan Paskah Rena.\nb. Di Ari Minggu, 31 Maret 2024. Pesta parningotan Ari Haheheon ni Tuhan Jesus, tapatupa do ulaon:\n1) Buha Buha Ijuk masuk pukul 05.00 WIB laos diuduti jalan santai dan perjamuan kasih, alani i taboan be ma angka sipanganon dan sejenisnya.\n2) Perayaan Paskah Sekolah Minggu, dipatupa dung sidung Ibadah buha-buha Ijuk.\n3) Ibadah Pesta Parningotan ari haheheon ni Tuhan Jesus masuk pukul 11.00 WIB, dung sidung ibadah tapatupa do jamuan kasih (makan siang bersama), laos diuduti kegiatan Paskah.\nCatatan : Pelaksanaan jamuan kasih asa taboan be ma piring masing-masing.\n\n2. Gotong Royong\nPada hari ini Minggu 24 Maret 2024 pukul 15.00 WIB kita akan melaksanakan gotong royong untuk membersihkan lingkungan Gereja dalam rangka menyambut Perayaan Paskah. Dihimbau kepada seluruh Jemaat untuk hadir dan berpartisipasi dalam kegiatan tersebut.', '2024-05-28 02:08:57'),
(86, 3, 'WARTA JEMAAT 8 OKTOBER 2023\nMINGGU XVIII SETELAH TRINITATIS\n \n\nHKBP Palmarum Tarutung\n \n\nTopik:\n \n\n”TUHAN MENGHENDAKI KEADILAN DAN KEBENARAN”\n(DIHALOMOHON JAHOWA DO UHUM DOHOT HATIGORAN)\n \n\nTINGTING NA MASA\n1. –\n \n\nTINGTING SIPAMASAON\n1. Pembentukan Panitia Natal\nPada hari ini Minggu tanggal 08 Oktober 2023 setelah pelaksanaan ibadah Minggu, kita akan\nmelaksanakan rapat pembentukan Panitia Natal tahun 2023, diharapkan kepada seluruh Jemaat untuk\nberpartisipasi mengikuti rapat tersebut.\n\n2. Rapat Pendeta\nPada tanggal 16 s.d 20 Oktober 2023 akan dilaksanakan Rapat Pendeta di Kantor Pusat HKBP Tarutung,\nAmang Pdt. A. Hutabarat, M.Div akan mengikuti kegiatan rapat tersebut dan berangkat pada hari Rabu\ntanggal 11 Oktober 2023.\n\n3. Kebaktian Lingkungan\nKebaktian Lingkungan akan dilaksanakan pada:\n\nWeyk 1 Wilayah 1 : –\nWeyk 1 Wilayah 2 : –\nWeyk 2 : hari Kamis tanggal 12 Oktober 2023 di rumah Kel. Ny. Hutabarat Br. Simatupang, alamat : Perumnas Sukajadi. (Bahasa Batak)\nKebaktian masuk pukul 19.00 WIB, diharapkan kepada seluruh jemaat di wilayah tersebut agar dapat menghadiri ibadah/kebaktian Keluarga tersebut. Tuhan Memberkati.', '2024-05-28 02:12:52');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bank`
--
ALTER TABLE `bank`
  ADD PRIMARY KEY (`id_bank`);

--
-- Indexes for table `bidang_pendidikan`
--
ALTER TABLE `bidang_pendidikan`
  ADD PRIMARY KEY (`id_bidang_pendidikan`);

--
-- Indexes for table `hubungan_keluarga`
--
ALTER TABLE `hubungan_keluarga`
  ADD PRIMARY KEY (`id_hub_keluarga`);

--
-- Indexes for table `jadwal_ibadah`
--
ALTER TABLE `jadwal_ibadah`
  ADD PRIMARY KEY (`id_jadwal_ibadah`),
  ADD KEY `id_jenis_minggu` (`id_jenis_minggu`),
  ADD KEY `id_jemaat` (`id_jemaat`);

--
-- Indexes for table `jemaat`
--
ALTER TABLE `jemaat`
  ADD PRIMARY KEY (`id_jemaat`),
  ADD KEY `id_hub_keluarga` (`id_hub_keluarga`),
  ADD KEY `id_status_ama_ina` (`id_status_ama_ina`),
  ADD KEY `id_status_anak` (`id_status_anak`),
  ADD KEY `id_status_pernikahan` (`id_status_pernikahan`),
  ADD KEY `id_pendidikan` (`id_pendidikan`),
  ADD KEY `id_bidang_pendidikan` (`id_bidang_pendidikan`),
  ADD KEY `id_pekerjaan` (`id_pekerjaan`),
  ADD KEY `id_kecamatan` (`id_kecamatan`),
  ADD KEY `id_registrasi_keluarga` (`id_registrasi_keluarga`);

--
-- Indexes for table `jenis_kegiatan`
--
ALTER TABLE `jenis_kegiatan`
  ADD PRIMARY KEY (`id_jenis_kegiatan`);

--
-- Indexes for table `jenis_minggu`
--
ALTER TABLE `jenis_minggu`
  ADD PRIMARY KEY (`id_jenis_minggu`);

--
-- Indexes for table `jenis_status`
--
ALTER TABLE `jenis_status`
  ADD PRIMARY KEY (`id_jenis_status`);

--
-- Indexes for table `kategori_pemasukab`
--
ALTER TABLE `kategori_pemasukab`
  ADD PRIMARY KEY (`id_kategori_pemasukan`);

--
-- Indexes for table `kategori_pengeluaran`
--
ALTER TABLE `kategori_pengeluaran`
  ADD PRIMARY KEY (`id_kategori_pengeluaran`);

--
-- Indexes for table `kecamatan`
--
ALTER TABLE `kecamatan`
  ADD PRIMARY KEY (`id_kecamatan`);

--
-- Indexes for table `majelis`
--
ALTER TABLE `majelis`
  ADD PRIMARY KEY (`id_majelis`),
  ADD KEY `id_jemaat` (`id_jemaat`),
  ADD KEY `id_status_pelayan` (`id_status_pelayan`);

--
-- Indexes for table `pekerjaan`
--
ALTER TABLE `pekerjaan`
  ADD PRIMARY KEY (`id_pekerjaan`);

--
-- Indexes for table `pelayanan_ibadah`
--
ALTER TABLE `pelayanan_ibadah`
  ADD PRIMARY KEY (`id_pelayanan_ibadah`),
  ADD KEY `id_jemaat` (`id_jemaat`);

--
-- Indexes for table `pelayan_gereja`
--
ALTER TABLE `pelayan_gereja`
  ADD PRIMARY KEY (`id_pelayan`),
  ADD KEY `id_jemaat` (`id_jemaat`);

--
-- Indexes for table `pelayan_ibadah`
--
ALTER TABLE `pelayan_ibadah`
  ADD PRIMARY KEY (`id_pelayan_ibadah`),
  ADD KEY `id_jemaat` (`id_jemaat`),
  ADD KEY `id_jadwal_ibadah` (`id_jadwal_ibadah`),
  ADD KEY `id_pelayanan_ibadah` (`id_pelayanan_ibadah`);

--
-- Indexes for table `pemasukan`
--
ALTER TABLE `pemasukan`
  ADD PRIMARY KEY (`id_pemasukan`),
  ADD KEY `id_kategori_pemasukan` (`id_kategori_pemasukan`),
  ADD KEY `id_bank` (`id_bank`),
  ADD KEY `id_jemaat` (`id_jemaat`);

--
-- Indexes for table `pendidikan`
--
ALTER TABLE `pendidikan`
  ADD PRIMARY KEY (`id_pendidikan`);

--
-- Indexes for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD PRIMARY KEY (`id_pengeluaran`),
  ADD KEY `id_bank` (`id_bank`),
  ADD KEY `pengeluaran_ibfk_1` (`id_kategori_pengeluaran`),
  ADD KEY `id_jemaat` (`id_jemaat`);

--
-- Indexes for table `registrasi_baptis`
--
ALTER TABLE `registrasi_baptis`
  ADD PRIMARY KEY (`id_registrasi_baptis`),
  ADD KEY `id_jemaat` (`id_jemaat`),
  ADD KEY `id_hub_keluarga` (`id_hub_keluarga`),
  ADD KEY `id_status` (`id_status`);

--
-- Indexes for table `registrasi_keluarga`
--
ALTER TABLE `registrasi_keluarga`
  ADD PRIMARY KEY (`id_registrasi_keluarga`),
  ADD KEY `id_jemaat` (`id_jemaat`);

--
-- Indexes for table `registrasi_pernikahan`
--
ALTER TABLE `registrasi_pernikahan`
  ADD PRIMARY KEY (`id_registrasi_nikah`),
  ADD KEY `id_status` (`id_status`),
  ADD KEY `id_jemaat` (`id_jemaat`);

--
-- Indexes for table `registrasi_sidi`
--
ALTER TABLE `registrasi_sidi`
  ADD PRIMARY KEY (`id_registrasi_sidi`),
  ADD KEY `id_jemaat` (`id_jemaat`),
  ADD KEY `id_hub_keluarga` (`id_hub_keluarga`),
  ADD KEY `id_status` (`id_status`);

--
-- Indexes for table `sejarahgereja`
--
ALTER TABLE `sejarahgereja`
  ADD PRIMARY KEY (`id_sejarah`),
  ADD KEY `id_jemaat` (`id_jemaat`);

--
-- Indexes for table `status`
--
ALTER TABLE `status`
  ADD PRIMARY KEY (`id_status`),
  ADD KEY `id_jenis_status` (`id_jenis_status`);

--
-- Indexes for table `waktu_kegiatan`
--
ALTER TABLE `waktu_kegiatan`
  ADD PRIMARY KEY (`id_waktu_kegiatan`),
  ADD KEY `id_jenis_kegiatan` (`id_jenis_kegiatan`),
  ADD KEY `id_jemaat` (`id_jemaat`);

--
-- Indexes for table `warta`
--
ALTER TABLE `warta`
  ADD PRIMARY KEY (`id_warta`),
  ADD KEY `id_jemaat` (`id_jemaat`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `bank`
--
ALTER TABLE `bank`
  MODIFY `id_bank` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `bidang_pendidikan`
--
ALTER TABLE `bidang_pendidikan`
  MODIFY `id_bidang_pendidikan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `hubungan_keluarga`
--
ALTER TABLE `hubungan_keluarga`
  MODIFY `id_hub_keluarga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `jadwal_ibadah`
--
ALTER TABLE `jadwal_ibadah`
  MODIFY `id_jadwal_ibadah` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=82;

--
-- AUTO_INCREMENT for table `jemaat`
--
ALTER TABLE `jemaat`
  MODIFY `id_jemaat` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `jenis_kegiatan`
--
ALTER TABLE `jenis_kegiatan`
  MODIFY `id_jenis_kegiatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jenis_minggu`
--
ALTER TABLE `jenis_minggu`
  MODIFY `id_jenis_minggu` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `jenis_status`
--
ALTER TABLE `jenis_status`
  MODIFY `id_jenis_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `kategori_pemasukab`
--
ALTER TABLE `kategori_pemasukab`
  MODIFY `id_kategori_pemasukan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `kategori_pengeluaran`
--
ALTER TABLE `kategori_pengeluaran`
  MODIFY `id_kategori_pengeluaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `kecamatan`
--
ALTER TABLE `kecamatan`
  MODIFY `id_kecamatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `majelis`
--
ALTER TABLE `majelis`
  MODIFY `id_majelis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `pekerjaan`
--
ALTER TABLE `pekerjaan`
  MODIFY `id_pekerjaan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `pelayanan_ibadah`
--
ALTER TABLE `pelayanan_ibadah`
  MODIFY `id_pelayanan_ibadah` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `pelayan_gereja`
--
ALTER TABLE `pelayan_gereja`
  MODIFY `id_pelayan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `pelayan_ibadah`
--
ALTER TABLE `pelayan_ibadah`
  MODIFY `id_pelayan_ibadah` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=75;

--
-- AUTO_INCREMENT for table `pemasukan`
--
ALTER TABLE `pemasukan`
  MODIFY `id_pemasukan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `pendidikan`
--
ALTER TABLE `pendidikan`
  MODIFY `id_pendidikan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  MODIFY `id_pengeluaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `registrasi_baptis`
--
ALTER TABLE `registrasi_baptis`
  MODIFY `id_registrasi_baptis` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `registrasi_keluarga`
--
ALTER TABLE `registrasi_keluarga`
  MODIFY `id_registrasi_keluarga` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `registrasi_pernikahan`
--
ALTER TABLE `registrasi_pernikahan`
  MODIFY `id_registrasi_nikah` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `registrasi_sidi`
--
ALTER TABLE `registrasi_sidi`
  MODIFY `id_registrasi_sidi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `sejarahgereja`
--
ALTER TABLE `sejarahgereja`
  MODIFY `id_sejarah` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `status`
--
ALTER TABLE `status`
  MODIFY `id_status` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `waktu_kegiatan`
--
ALTER TABLE `waktu_kegiatan`
  MODIFY `id_waktu_kegiatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `warta`
--
ALTER TABLE `warta`
  MODIFY `id_warta` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=87;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `jadwal_ibadah`
--
ALTER TABLE `jadwal_ibadah`
  ADD CONSTRAINT `jadwal_ibadah_ibfk_1` FOREIGN KEY (`id_jenis_minggu`) REFERENCES `jenis_minggu` (`id_jenis_minggu`),
  ADD CONSTRAINT `jadwal_ibadah_ibfk_2` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`);

--
-- Constraints for table `jemaat`
--
ALTER TABLE `jemaat`
  ADD CONSTRAINT `jemaat_ibfk_10` FOREIGN KEY (`id_bidang_pendidikan`) REFERENCES `bidang_pendidikan` (`id_bidang_pendidikan`),
  ADD CONSTRAINT `jemaat_ibfk_11` FOREIGN KEY (`id_status_ama_ina`) REFERENCES `status` (`id_status`),
  ADD CONSTRAINT `jemaat_ibfk_12` FOREIGN KEY (`id_status_anak`) REFERENCES `status` (`id_status`),
  ADD CONSTRAINT `jemaat_ibfk_13` FOREIGN KEY (`id_status_pernikahan`) REFERENCES `status` (`id_status`),
  ADD CONSTRAINT `jemaat_ibfk_14` FOREIGN KEY (`id_kecamatan`) REFERENCES `kecamatan` (`id_kecamatan`),
  ADD CONSTRAINT `jemaat_ibfk_15` FOREIGN KEY (`id_pekerjaan`) REFERENCES `pekerjaan` (`id_pekerjaan`),
  ADD CONSTRAINT `jemaat_ibfk_16` FOREIGN KEY (`id_hub_keluarga`) REFERENCES `hubungan_keluarga` (`id_hub_keluarga`),
  ADD CONSTRAINT `jemaat_ibfk_17` FOREIGN KEY (`id_registrasi_keluarga`) REFERENCES `registrasi_keluarga` (`id_registrasi_keluarga`),
  ADD CONSTRAINT `jemaat_ibfk_9` FOREIGN KEY (`id_pendidikan`) REFERENCES `pendidikan` (`id_pendidikan`);

--
-- Constraints for table `majelis`
--
ALTER TABLE `majelis`
  ADD CONSTRAINT `majelis_ibfk_1` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`),
  ADD CONSTRAINT `majelis_ibfk_3` FOREIGN KEY (`id_status_pelayan`) REFERENCES `status` (`id_status`);

--
-- Constraints for table `pelayanan_ibadah`
--
ALTER TABLE `pelayanan_ibadah`
  ADD CONSTRAINT `pelayanan_ibadah_ibfk_1` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`);

--
-- Constraints for table `pelayan_gereja`
--
ALTER TABLE `pelayan_gereja`
  ADD CONSTRAINT `pelayan_gereja_ibfk_1` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`);

--
-- Constraints for table `pelayan_ibadah`
--
ALTER TABLE `pelayan_ibadah`
  ADD CONSTRAINT `pelayan_ibadah_ibfk_1` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`),
  ADD CONSTRAINT `pelayan_ibadah_ibfk_2` FOREIGN KEY (`id_jadwal_ibadah`) REFERENCES `jadwal_ibadah` (`id_jadwal_ibadah`),
  ADD CONSTRAINT `pelayan_ibadah_ibfk_3` FOREIGN KEY (`id_pelayanan_ibadah`) REFERENCES `pelayanan_ibadah` (`id_pelayanan_ibadah`);

--
-- Constraints for table `pemasukan`
--
ALTER TABLE `pemasukan`
  ADD CONSTRAINT `pemasukan_ibfk_1` FOREIGN KEY (`id_kategori_pemasukan`) REFERENCES `kategori_pemasukab` (`id_kategori_pemasukan`),
  ADD CONSTRAINT `pemasukan_ibfk_3` FOREIGN KEY (`id_bank`) REFERENCES `bank` (`id_bank`),
  ADD CONSTRAINT `pemasukan_ibfk_4` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`);

--
-- Constraints for table `pengeluaran`
--
ALTER TABLE `pengeluaran`
  ADD CONSTRAINT `pengeluaran_ibfk_1` FOREIGN KEY (`id_kategori_pengeluaran`) REFERENCES `kategori_pengeluaran` (`id_kategori_pengeluaran`),
  ADD CONSTRAINT `pengeluaran_ibfk_2` FOREIGN KEY (`id_bank`) REFERENCES `bank` (`id_bank`),
  ADD CONSTRAINT `pengeluaran_ibfk_3` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`);

--
-- Constraints for table `registrasi_baptis`
--
ALTER TABLE `registrasi_baptis`
  ADD CONSTRAINT `registrasi_baptis_ibfk_1` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`),
  ADD CONSTRAINT `registrasi_baptis_ibfk_2` FOREIGN KEY (`id_hub_keluarga`) REFERENCES `hubungan_keluarga` (`id_hub_keluarga`),
  ADD CONSTRAINT `registrasi_baptis_ibfk_4` FOREIGN KEY (`id_status`) REFERENCES `status` (`id_status`);

--
-- Constraints for table `registrasi_keluarga`
--
ALTER TABLE `registrasi_keluarga`
  ADD CONSTRAINT `registrasi_keluarga_ibfk_1` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`);

--
-- Constraints for table `registrasi_pernikahan`
--
ALTER TABLE `registrasi_pernikahan`
  ADD CONSTRAINT `registrasi_pernikahan_ibfk_1` FOREIGN KEY (`id_status`) REFERENCES `status` (`id_status`),
  ADD CONSTRAINT `registrasi_pernikahan_ibfk_2` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`);

--
-- Constraints for table `registrasi_sidi`
--
ALTER TABLE `registrasi_sidi`
  ADD CONSTRAINT `registrasi_sidi_ibfk_1` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`),
  ADD CONSTRAINT `registrasi_sidi_ibfk_2` FOREIGN KEY (`id_status`) REFERENCES `status` (`id_status`),
  ADD CONSTRAINT `registrasi_sidi_ibfk_3` FOREIGN KEY (`id_hub_keluarga`) REFERENCES `hubungan_keluarga` (`id_hub_keluarga`);

--
-- Constraints for table `sejarahgereja`
--
ALTER TABLE `sejarahgereja`
  ADD CONSTRAINT `sejarahgereja_ibfk_1` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`);

--
-- Constraints for table `status`
--
ALTER TABLE `status`
  ADD CONSTRAINT `status_ibfk_1` FOREIGN KEY (`id_jenis_status`) REFERENCES `jenis_status` (`id_jenis_status`);

--
-- Constraints for table `waktu_kegiatan`
--
ALTER TABLE `waktu_kegiatan`
  ADD CONSTRAINT `waktu_kegiatan_ibfk_1` FOREIGN KEY (`id_jenis_kegiatan`) REFERENCES `jenis_kegiatan` (`id_jenis_kegiatan`),
  ADD CONSTRAINT `waktu_kegiatan_ibfk_2` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`);

--
-- Constraints for table `warta`
--
ALTER TABLE `warta`
  ADD CONSTRAINT `warta_ibfk_1` FOREIGN KEY (`id_jemaat`) REFERENCES `jemaat` (`id_jemaat`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
