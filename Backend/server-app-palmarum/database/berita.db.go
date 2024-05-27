package database

import (
	"database/sql"
	"fmt"
	"log"
	"server-palmarum/model"

	_ "github.com/go-sql-driver/mysql"
)

func GetKegiatan() ([]model.WaktuKegiatan, error) {
	var kegiatan []model.WaktuKegiatan

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return kegiatan, err
	}
	defer db.Close()

	rows, err := db.Query("CALL GetWaktuKegiatan()")
	if err != nil {
		return kegiatan, err
	}
	defer rows.Close()

	for rows.Next() {
		var k model.WaktuKegiatan
		var waktuKegiatanString string
		err := rows.Scan(&k.IDWaktuKegiatan, &k.IDJenisKegiatan, &k.IDJemaat, &k.NamaKegiatan, &k.LokasiKegiatan, &waktuKegiatanString, &k.KegiatanFoto, &k.Keterangan)
		if err != nil {
			return kegiatan, err
		}

		kegiatan = append(kegiatan, k)
	}

	return kegiatan, nil
}

func GetKegiatanHome() ([]model.WaktuKegiatan, error) {
	var kegiatan []model.WaktuKegiatan

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return kegiatan, err
	}
	defer db.Close()

	rows, err := db.Query("CALL GetWaktuKegiatanHome()")
	if err != nil {
		return kegiatan, err
	}
	defer rows.Close()

	for rows.Next() {
		var k model.WaktuKegiatan
		var waktuKegiatanString string
		err := rows.Scan(&k.IDWaktuKegiatan, &k.IDJenisKegiatan, &k.IDJemaat, &k.NamaKegiatan, &k.LokasiKegiatan, &waktuKegiatanString, &k.KegiatanFoto, &k.Keterangan)
		if err != nil {
			return kegiatan, err
		}

		kegiatan = append(kegiatan, k)
	}

	return kegiatan, nil
}

func GetKegiatanByID(id int) (model.WaktuKegiatan, error) {
	var k model.WaktuKegiatan

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return k, err
	}
	defer db.Close()

	rows, err := db.Query("CALL GetWaktuKegiatanByID(?)", id)
	if err != nil {
		return k, err
	}
	defer rows.Close()

	if rows.Next() {
		var waktuKegiatanString string
		err := rows.Scan(&k.IDWaktuKegiatan, &k.IDJenisKegiatan, &k.IDJemaat, &k.NamaKegiatan, &k.LokasiKegiatan, &waktuKegiatanString, &k.KegiatanFoto, &k.Keterangan)
		if err != nil {
			return k, err
		}
	}

	return k, nil
}

func CreateKegiatan(jenisKegiatanID int, jemaatID string, namaKegiatan, lokasiKegiatan, fotoKegiatan, keterangan string) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL tambah_data_kegiatan(?, ?, ?, ?, ?, ?)", jenisKegiatanID, jemaatID, namaKegiatan, lokasiKegiatan, fotoKegiatan, keterangan)
	if err != nil {
		return err
	}
	return nil
}

func GetImageKegiatanNameFromDatabase(IDWaktuKegiatan string) string {
	// Lakukan koneksi ke database
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		log.Println("Error connecting to the database:", err)
		return ""
	}
	defer db.Close()

	// Lakukan query ke database untuk mendapatkan nama file gambar berdasarkan jemaatID
	var imageName string
	err = db.QueryRow("SELECT foto_kegiatan FROM waktu_kegiatan WHERE id_waktu_kegiatan = ?", IDWaktuKegiatan).Scan(&imageName)
	if err != nil {
		log.Println("Error querying the database:", err)
		return ""
	}

	// Jika tidak ada gambar yang ditemukan dalam database, kembalikan string kosong
	if imageName == "" {
		log.Println("Image not found in the database")
		return ""
	}

	return imageName
}

func GetImageKegiatanHomeNameFromDatabase() []string {
	// Lakukan koneksi ke database
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		log.Println("Error connecting to the database:", err)
		return nil
	}
	defer db.Close()

	// Lakukan query ke database untuk mendapatkan nama file gambar dari semua data kegiatan
	rows, err := db.Query("SELECT foto_kegiatan FROM waktu_kegiatan ORDER BY id_waktu_kegiatan DESC LIMIT 5")
	if err != nil {
		log.Println("Error querying the database:", err)
		return nil
	}
	defer rows.Close()

	var imageNames []string

	// Iterasi melalui baris hasil query dan ambil nama file gambar
	for rows.Next() {
		var imageName string
		err := rows.Scan(&imageName)
		if err != nil {
			log.Println("Error scanning rows:", err)
			continue
		}
		imageNames = append(imageNames, imageName)
	}

	// Periksa apakah terdapat error selama iterasi baris
	if err := rows.Err(); err != nil {
		log.Println("Error iterating rows:", err)
		return nil
	}

	return imageNames
}

func UpdateKegiatan(k model.WaktuKegiatan) error {
	// Membuat koneksi ke database
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	// Membuat prepared statement untuk memanggil stored procedure ubah_data_kegiatan
	stmt, err := db.Prepare("CALL ubah_data_kegiatan(?, ?, ?, ?, ?, ?)")
	if err != nil {
		return err
	}
	defer stmt.Close()

	// Menjalankan stored procedure dengan parameter yang diberikan
	_, err = stmt.Exec(
		k.IDWaktuKegiatan,
		k.IDJenisKegiatan,
		k.IDJemaat,
		k.NamaKegiatan,
		k.KegiatanFoto,
		k.Keterangan,
	)
	if err != nil {
		return fmt.Errorf("gagal memanggil stored procedure ubah_data_kegiatan: %v", err)
	}

	return nil
}
