package database

import (
	"database/sql"
	"fmt"
	"log"
	"server-palmarum/model"
)

func CreatePengeluaran(p model.Pengeluaran) error {
	// Membuat koneksi ke database
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	// Membuat prepared statement untuk memanggil stored procedure
	stmt, err := db.Prepare("CALL tambah_pengeluaran(?, ?, ?, ?, ?, ?, ?)")
	if err != nil {
		return err
	}
	defer stmt.Close()

	// Menjalankan stored procedure dengan parameter yang diberikan
	_, err = stmt.Exec(
		p.IDJemaat,
		p.JumlahPengeluaran,
		p.TanggalPengeluaran,
		p.KeteranganPengeluaran,
		p.IDKategoriPengeluaran,
		p.IDBank,
		p.BuktiPengeluaran,
	)
	if err != nil {
		return fmt.Errorf("gagal memanggil stored procedure: %v", err)
	}

	return nil
}

func GetPengeluaran() ([]model.Pengeluaran, error) {
	var getPengeluaran []model.Pengeluaran

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return getPengeluaran, err
	}
	defer db.Close()

	rows, err := db.Query("CALL ambil_pengeluaran()")
	if err != nil {
		return getPengeluaran, err
	}
	defer rows.Close()

	for rows.Next() {
		var P model.Pengeluaran
		err := rows.Scan(&P.IDPengeluaran, &P.JumlahPengeluaran, &P.TanggalPengeluaran, &P.KeteranganPengeluaran, &P.NamaBank, &P.NamaKategori, &P.BuktiPengeluaran, &P.IDKategoriPengeluaran, &P.IDBank)
		if err != nil {
			return getPengeluaran, err
		}

		getPengeluaran = append(getPengeluaran, P)
	}

	return getPengeluaran, nil
}

func UpdatePengeluaran(p model.Pengeluaran) error {
	// Membuat koneksi ke database
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	// Membuat prepared statement untuk memanggil stored procedure ubah_pengeluaran
	stmt, err := db.Prepare("CALL ubah_pengeluaran(?, ?, ?, ?, ?, ?, ?, ?)")
	if err != nil {
		return err
	}
	defer stmt.Close()

	// Menjalankan stored procedure dengan parameter yang diberikan
	_, err = stmt.Exec(
		p.IDPengeluaran,
		p.IDJemaat,
		p.BuktiPengeluaran,
		p.JumlahPengeluaran,
		p.TanggalPengeluaran,
		p.KeteranganPengeluaran,
		p.IDKategoriPengeluaran,
		p.IDBank,
	)
	if err != nil {
		return fmt.Errorf("gagal memanggil stored procedure ubah_pengeluaran: %v", err)
	}

	return nil
}

func GetPengeluaranByID(id int) (model.Pengeluaran, error) {
	var pengeluaran model.Pengeluaran

	// Membuat koneksi ke database
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return pengeluaran, err
	}
	defer db.Close()

	// Membuat prepared statement untuk memanggil stored procedure getById_pengeluaran
	stmt, err := db.Prepare("CALL getById_pengeluaran(?)")
	if err != nil {
		return pengeluaran, err
	}
	defer stmt.Close()

	// Menjalankan stored procedure dengan parameter yang diberikan
	row := stmt.QueryRow(id)

	// Mengambil hasil dari query
	err = row.Scan(
		&pengeluaran.IDPengeluaran,
		&pengeluaran.JumlahPengeluaran,
		&pengeluaran.TanggalPengeluaran,
		&pengeluaran.KeteranganPengeluaran,
		&pengeluaran.NamaBank,
		&pengeluaran.NamaKategori,
		&pengeluaran.BuktiPengeluaran,
		&pengeluaran.IDBank,
		&pengeluaran.IDKategoriPengeluaran,
	)
	if err != nil {
		return pengeluaran, err
	}

	return pengeluaran, nil
}

func GetImagePengeluaran(IDPengeluaran string) string {
	// Lakukan koneksi ke database
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		log.Println("Error connecting to the database:", err)
		return ""
	}
	defer db.Close()

	// Lakukan query ke database untuk mendapatkan nama file gambar berdasarkan jemaatID
	var imageName string
	err = db.QueryRow("SELECT bukti_pengeluaran FROM pengeluaran WHERE id_pengeluaran = ?", IDPengeluaran).Scan(&imageName)
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
