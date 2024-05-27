package database

import (
	"database/sql"
	"fmt"
	"os"
	"path/filepath"
	"server-palmarum/model"
)

func CreateBaptis(
	idJemaat int,
	namaAyah string,
	namaIbu string,
	namaLengkap string,
	tempatLahir string,
	tanggalLahir string,
	jenisKelamin string,
	idHubKeluarga int,
) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL registrasi_baptis(?, ?, ?, ?, ?, ?, ?, ?)",
		idJemaat,
		namaAyah,
		namaIbu,
		namaLengkap,
		tempatLahir,
		tanggalLahir,
		jenisKelamin,
		idHubKeluarga,
	)
	if err != nil {
		return err
	}
	return nil
}

func UpdateRegistrasiBaptisData(idRegistrasiBaptis int, noSuratBaptis, namaPendetaBaptis, fileSuratBaptis, tanggalBaptis string, idStatus int) error {
	db, err := sql.Open("mysql", "user:password@tcp(127.0.0.1:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	// Panggil prosedur tersimpan untuk memperbarui registrasi baptis
	_, err = db.Exec("CALL update_registrasi_baptis(?, ?, ?, ?, ?, ?)",
		idRegistrasiBaptis, noSuratBaptis, namaPendetaBaptis, fileSuratBaptis, tanggalBaptis, idStatus)
	if err != nil {
		return err
	}

	return nil
}
func GetRegistrasiBaptisByID(idRegistrasiBaptis int) (*model.Baptis, error) {
	var result model.Baptis
	var tanggalBaptis sql.NullString // Variabel untuk menampung nilai yang bisa NULL
	var noSuratBaptis sql.NullString // Variabel untuk menampung nilai yang bisa NULL
	var namaPendeta sql.NullString   // Variabel untuk menampung nilai yang bisa NULL
	var fileBaptis sql.NullString    // Variabel untuk menampung nilai yang bisa NULL
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return nil, fmt.Errorf("gagal terhubung ke database: %v", err)
	}
	defer db.Close()

	err = db.QueryRow("CALL GetByIdBaptis(?)", idRegistrasiBaptis).Scan(
		&result.IDBaptis,
		&result.IDJemaat,
		&result.NamaAyah,
		&result.NamaIbu,
		&result.NamaLengkap,
		&result.TempatLahir,
		&result.TanggalLahir,
		&result.JenisKelamin,
		&result.IDHubKeluarga,
		&result.NamaHubKeluarga,
		&tanggalBaptis, // Menggunakan variabel sql.NullString
		&noSuratBaptis,
		&namaPendeta,
		&fileBaptis,
		&result.IDStatus,
		&result.Status,
	)
	if err != nil {
		return nil, fmt.Errorf("gagal menjalankan prosedur tersimpan: %v", err)
	}

	// Konversi sql.NullString ke string biasa
	if tanggalBaptis.Valid {
		result.TanggalBaptis = tanggalBaptis.String
	} else {
		result.TanggalBaptis = ""
	}

	if noSuratBaptis.Valid {
		result.NoSuratBaptis = noSuratBaptis.String
	} else {
		result.NoSuratBaptis = ""
	}

	if namaPendeta.Valid {
		result.NamaPendetaBaptis = namaPendeta.String
	} else {
		result.NamaPendetaBaptis = ""
	}

	if fileBaptis.Valid {
		result.FileSuratBaptis = fileBaptis.String
	} else {
		result.FileSuratBaptis = ""
	}

	return &result, nil
}

func GetAllRegistrasiBaptis() ([]model.Baptis, error) {
	var baptisList []model.Baptis

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return baptisList, err
	}
	defer db.Close()
	rows, err := db.Query("CALL GetAllRegistrasiBaptis()")
	if err != nil {
		return baptisList, err
	}
	defer rows.Close()

	for rows.Next() {
		var b model.Baptis
		err := rows.Scan(&b.IDBaptis, &b.IDJemaat, &b.NamaAyah, &b.NamaIbu, &b.NamaLengkap, &b.TempatLahir, &b.TanggalLahir, &b.JenisKelamin, &b.IDHubKeluarga, &b.NamaHubKeluarga, &b.IDStatus, &b.Status)
		if err != nil {
			return baptisList, err
		}
		// Optional: Assign default values for the additional fields
		b.TanggalBaptis = ""
		b.NoSuratBaptis = ""
		b.NamaPendetaBaptis = ""
		b.FileSuratBaptis = ""

		baptisList = append(baptisList, b)
	}

	if err = rows.Err(); err != nil {
		return baptisList, err
	}

	return baptisList, nil
}

func GetRegistrasiBaptisByIdJemaat(jemaatID int) ([]model.Baptis, error) {
	var baptisList []model.Baptis
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return baptisList, err
	}
	defer db.Close()

	rows, err := db.Query("CALL GetRegistrasiBaptisByIdJemaat(?)", jemaatID)
	if err != nil {
		return baptisList, err
	}
	defer rows.Close()

	for rows.Next() {
		var b model.Baptis
		err := rows.Scan(&b.IDBaptis, &b.IDJemaat, &b.NamaAyah, &b.NamaIbu, &b.NamaLengkap, &b.TempatLahir, &b.TanggalLahir, &b.JenisKelamin, &b.IDHubKeluarga, &b.NamaHubKeluarga, &b.IDStatus, &b.Status)
		if err != nil {
			return baptisList, err
		}
		// Optional: Assign default values for the additional fields
		b.TanggalBaptis = ""
		b.NoSuratBaptis = ""
		b.NamaPendetaBaptis = ""
		b.FileSuratBaptis = ""

		baptisList = append(baptisList, b)
	}

	if err = rows.Err(); err != nil {
		return baptisList, err
	}

	return baptisList, nil
}

func GetFileSuratBaptisByID(idRegistrasiBaptis int) (string, error) {
	var fileName string
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return "", err
	}
	defer db.Close()

	err = db.QueryRow("CALL GetFileSuratBaptisById(?)", idRegistrasiBaptis).Scan(&fileName)
	if err != nil {
		return "", fmt.Errorf("failed to execute stored procedure: %v", err)
	}

	// Membuat jalur lengkap dari folder suratBaptis dan nama file
	filePath := filepath.Join("suratBaptis", fileName)

	// Memeriksa apakah file ada
	if _, err := os.Stat(filePath); os.IsNotExist(err) {
		return "", fmt.Errorf("file %s tidak ditemukan", filePath)
	}

	return filePath, nil
}
