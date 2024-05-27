package database

import (
	"database/sql"
	"fmt"
	"log"
	"server-palmarum/model"
)

func CreatePemasukan(p model.Pemasukan) error {
	// Membuat koneksi ke database
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	// Membuat prepared statement untuk memanggil stored procedure
	stmt, err := db.Prepare("CALL insert_pemasukan(?, ?, ?, ?, ?, ?, ?)")
	if err != nil {
		return err
	}
	defer stmt.Close()

	// Menjalankan stored procedure dengan parameter yang diberikan
	_, err = stmt.Exec(
		p.IDJemaat,
		p.TanggalPemasukan,
		p.TotalPemasukan,
		p.BentukPemasukan,
		p.IDKategoriPemasukan,
		p.BuktiPemasukan,
		p.IDBank,
	)
	if err != nil {
		return fmt.Errorf("gagal memanggil stored procedure: %v", err)
	}

	return nil
}

func GetPemasukan() ([]model.Pemasukan, error) {
	var getPemasukan []model.Pemasukan

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return getPemasukan, err
	}
	defer db.Close()

	rows, err := db.Query("CALL GetAllPemasukan()")
	if err != nil {
		return getPemasukan, err
	}
	defer rows.Close()

	for rows.Next() {
		var P model.Pemasukan
		err := rows.Scan(&P.IDPemasukan, &P.TanggalPemasukan, &P.BuktiPemasukan, &P.TotalPemasukan, &P.BentukPemasukan, &P.NamaBank, &P.NamaKategoriPemasukan, &P.IDBank, &P.IDKategoriPemasukan)
		if err != nil {
			return getPemasukan, err
		}

		getPemasukan = append(getPemasukan, P)
	}

	return getPemasukan, nil
}

func UpdatePemasukan(p model.Pemasukan) error {
	// Membuat koneksi ke database
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	// Membuat prepared statement untuk memanggil stored procedure ubah_pengeluaran
	stmt, err := db.Prepare("CALL update_pemasukan(?, ?, ?, ?, ?, ?, ?, ?)")
	if err != nil {
		return err
	}
	defer stmt.Close()

	// Menjalankan stored procedure dengan parameter yang diberikan
	_, err = stmt.Exec(
		p.IDPemasukan,
		p.IDJemaat,
		p.TanggalPemasukan,
		p.TotalPemasukan,
		p.BentukPemasukan,
		p.IDKategoriPemasukan,
		p.BuktiPemasukan,
		p.IDBank,
	)
	if err != nil {
		return fmt.Errorf("gagal memanggil stored procedure update_pengeluaran: %v", err)
	}

	return nil
}

func GetPemasukanByID(id int) (model.Pemasukan, error) {
	var pemasukan model.Pemasukan

	// Membuat koneksi ke database
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return pemasukan, err
	}
	defer db.Close()

	// Membuat prepared statement untuk memanggil stored procedure getById_pengeluaran
	stmt, err := db.Prepare("CALL getByIdPemasukan(?)")
	if err != nil {
		return pemasukan, err
	}
	defer stmt.Close()

	// Menjalankan stored procedure dengan parameter yang diberikan
	row := stmt.QueryRow(id)

	// Mengambil hasil dari query
	err = row.Scan(
		&pemasukan.IDPemasukan,
		&pemasukan.TanggalPemasukan,
		&pemasukan.TotalPemasukan,
		&pemasukan.BentukPemasukan,
		&pemasukan.NamaKategoriPemasukan,
		&pemasukan.BuktiPemasukan,
		&pemasukan.NamaBank,
		&pemasukan.IDBank,
		&pemasukan.IDKategoriPemasukan,
	)
	if err != nil {
		return pemasukan, err
	}

	return pemasukan, nil
}

func GetImagePemasukan(IDPemasukan string) string {
	// Lakukan koneksi ke database
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		log.Println("Error connecting to the database:", err)
		return ""
	}
	defer db.Close()

	// Lakukan query ke database untuk mendapatkan nama file gambar berdasarkan jemaatID
	var imageName string
	err = db.QueryRow("SELECT bukti_pemasukan FROM pemasukan WHERE id_pemasukan = ?", IDPemasukan).Scan(&imageName)
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
