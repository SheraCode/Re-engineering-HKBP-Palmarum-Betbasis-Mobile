package database

import (
	"database/sql"
	"fmt"
	"os"
	"path/filepath"
	"server-palmarum/model"
)

func CreateRegistrasiSidi(
	idJemaat string,
	namaAyah, namaIbu, namaLengkap, tempatLahir, tanggalLahir, jenisKelamin, fileBaptis string,
	idHubKeluarga, idStatus int,
) error {
	// Membuka koneksi ke database
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return fmt.Errorf("failed to connect to database: %v", err)
	}
	defer db.Close()

	// Memanggil stored procedure createRegistrasiSidi
	_, err = db.Exec("CALL createRegistrasiSidi(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)",
		idJemaat,
		namaAyah,
		namaIbu,
		namaLengkap,
		tempatLahir,
		tanggalLahir,
		jenisKelamin,
		idHubKeluarga,
		idStatus,
		fileBaptis,
	)
	if err != nil {
		return fmt.Errorf("failed to call stored procedure: %v", err)
	}

	return nil
}

func GetRegistrasiSidi() ([]model.RegistrasiSidi, error) {
	// Open database connection
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return nil, fmt.Errorf("failed to connect to database: %v", err)
	}
	defer db.Close()

	// Execute stored procedure
	rows, err := db.Query("CALL getRegistrasiSidi()")
	if err != nil {
		return nil, fmt.Errorf("failed to call stored procedure: %v", err)
	}
	defer rows.Close()

	var registrasiSidis []model.RegistrasiSidi
	// ...
	for rows.Next() {
		var rs model.RegistrasiSidi
		var namaHubKeluarga string
		var status string
		var nullableNatsSidi sql.NullString
		var nullableNomorSuratSidi sql.NullString
		var nullableNamaPendetaSidi sql.NullString
		var nullableFileSuratBaptis sql.NullString
		var nullableTanggalSidi sql.NullTime

		if err := rows.Scan(&rs.IDRegistrasiSidi, &rs.IDJemaat, &rs.NamaAyah, &rs.NamaIbu, &rs.NamaLengkap, &rs.TempatLahir, &rs.TanggalLahir, &rs.JenisKelamin, &rs.IDHubKeluarga, &namaHubKeluarga, &nullableTanggalSidi, &nullableNatsSidi, &nullableNomorSuratSidi, &nullableNamaPendetaSidi, &nullableFileSuratBaptis, &rs.IDStatus, &status); err != nil {
			return nil, fmt.Errorf("failed to scan row: %v", err)
		}

		// Assigning values to the struct fields
		rs.NamaHubKeluarga = namaHubKeluarga
		rs.Status = status

		// Check if the nullable string values are valid
		if nullableNatsSidi.Valid {
			rs.NatsSidi = nullableNatsSidi.String
		} else {
			rs.NatsSidi = ""
		}

		// Check if the nullable int value is valid
		if nullableNomorSuratSidi.Valid {
			rs.NomorSuratSidi = nullableNomorSuratSidi.String
		} else {
			rs.NomorSuratSidi = ""
		}

		// Check if the nullable string values are valid
		if nullableNamaPendetaSidi.Valid {
			rs.NamaPendetaSidi = nullableNamaPendetaSidi.String
		} else {
			rs.NamaPendetaSidi = ""
		}

		// Check if the nullable string values are valid
		if nullableFileSuratBaptis.Valid {
			rs.FileSuratBaptis = nullableFileSuratBaptis.String
		} else {
			rs.FileSuratBaptis = ""
		}

		registrasiSidis = append(registrasiSidis, rs)
	}
	// ...

	if err = rows.Err(); err != nil {
		return nil, fmt.Errorf("row iteration error: %v", err)
	}

	return registrasiSidis, nil
}

func GetAllRegistrasiSidiByIdJemaat(jemaatID int) ([]model.RegistrasiSidi, error) {
	var registrasiSidis []model.RegistrasiSidi

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return registrasiSidis, fmt.Errorf("failed to connect to database: %v", err)
	}
	defer db.Close()

	rows, err := db.Query("CALL GetAllRegistrasiSidiByIdJemaat(?)", jemaatID)
	if err != nil {
		return registrasiSidis, fmt.Errorf("failed to call stored procedure: %v", err)
	}
	defer rows.Close()

	for rows.Next() {
		var rs model.RegistrasiSidi
		var namaHubKeluarga string
		var status string
		var nullableNatsSidi sql.NullString
		var nullableNomorSuratSidi sql.NullString
		var nullableNamaPendetaSidi sql.NullString
		var nullableFileSuratBaptis sql.NullString
		var nullableTanggalSidi sql.NullString

		if err := rows.Scan(&rs.IDRegistrasiSidi, &rs.IDJemaat, &rs.NamaAyah, &rs.NamaIbu, &rs.NamaLengkap, &rs.TempatLahir, &rs.TanggalLahir, &rs.JenisKelamin, &rs.IDHubKeluarga, &namaHubKeluarga, &nullableTanggalSidi, &nullableNatsSidi, &nullableNomorSuratSidi, &nullableNamaPendetaSidi, &nullableFileSuratBaptis, &rs.IDStatus, &status); err != nil {
			return nil, fmt.Errorf("failed to scan row: %v", err)
		}

		// Assigning values to the struct fields
		rs.NamaHubKeluarga = namaHubKeluarga
		rs.Status = status

		// Check if the nullable string values are valid
		if nullableNatsSidi.Valid {
			rs.NatsSidi = nullableNatsSidi.String
		} else {
			rs.NatsSidi = ""
		}

		// Check if the nullable int value is valid
		if nullableNomorSuratSidi.Valid {
			rs.NomorSuratSidi = nullableNomorSuratSidi.String
		} else {
			rs.NomorSuratSidi = ""
		}

		// Check if the nullable string values are valid
		if nullableNamaPendetaSidi.Valid {
			rs.NamaPendetaSidi = nullableNamaPendetaSidi.String
		} else {
			rs.NamaPendetaSidi = ""
		}

		// Check if the nullable string values are valid
		if nullableFileSuratBaptis.Valid {
			rs.FileSuratBaptis = nullableFileSuratBaptis.String
		} else {
			rs.FileSuratBaptis = ""
		}

		if nullableTanggalSidi.Valid {
			rs.TanggalSidi = nullableTanggalSidi.String
		} else {
			rs.TanggalSidi = ""
		}

		registrasiSidis = append(registrasiSidis, rs)
	}

	if err = rows.Err(); err != nil {
		return registrasiSidis, fmt.Errorf("row iteration error: %v", err)
	}

	return registrasiSidis, nil
}

func UpdateRegistrasiSidiData(idRegistrasiSidi int, tanggalSidi string, natsSidi string, nomorSuratSidi string, namaPendetaSidi string, idStatus int) error {
	// Membuka koneksi ke database
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return fmt.Errorf("failed to connect to database: %v", err)
	}
	defer db.Close()

	// Memanggil stored procedure UpdateRegistrasiSidi
	_, err = db.Exec("CALL UpdateRegistrasiSidi(?, ?, ?, ?, ?, ?)",
		idRegistrasiSidi,
		tanggalSidi,
		natsSidi,
		nomorSuratSidi,
		namaPendetaSidi,
		idStatus,
	)
	if err != nil {
		return fmt.Errorf("failed to call stored procedure: %v", err)
	}

	return nil
}

func GetFileSuratSidiByID(idRegistrasiBaptis int) (string, error) {
	var fileName string
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return "", err
	}
	defer db.Close()

	err = db.QueryRow("CALL GetFileSuratSidiById(?)", idRegistrasiBaptis).Scan(&fileName)
	if err != nil {
		return "", fmt.Errorf("failed to execute stored procedure: %v", err)
	}

	// Membuat jalur lengkap dari folder suratBaptis dan nama file
	filePath := filepath.Join("suratSidi", fileName)

	// Memeriksa apakah file ada
	if _, err := os.Stat(filePath); os.IsNotExist(err) {
		return "", fmt.Errorf("file %s tidak ditemukan", filePath)
	}

	return filePath, nil
}

func GetSidiById(idRegistrasiSidi int) (*model.RegistrasiSidi, error) {
	// Open database connection
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp?parseTime=true")
	if err != nil {
		return nil, fmt.Errorf("failed to connect to database: %v", err)
	}
	defer db.Close()

	// Execute the stored procedure
	rows, err := db.Query("CALL GetRegistrasiSidiById(?)", idRegistrasiSidi)
	if err != nil {
		return nil, fmt.Errorf("failed to call stored procedure: %v", err)
	}
	defer rows.Close()

	// Iterate over the result set
	if rows.Next() {
		var registrasiSidi model.RegistrasiSidi
		var nullableTanggalSidi sql.RawBytes
		var nullableNatsSidi sql.NullString
		var nullableNomorSuratSidi sql.NullString
		var nullableNamaPendetaSidi sql.NullString
		var nullableFileSidi sql.NullString

		if err := rows.Scan(
			&registrasiSidi.IDRegistrasiSidi,
			&registrasiSidi.IDJemaat,
			&registrasiSidi.NamaAyah,
			&registrasiSidi.NamaIbu,
			&registrasiSidi.NamaLengkap,
			&registrasiSidi.TempatLahir,
			&registrasiSidi.TanggalLahir,
			&registrasiSidi.JenisKelamin,
			&registrasiSidi.IDHubKeluarga,
			&nullableTanggalSidi,
			&nullableNatsSidi,
			&nullableNomorSuratSidi,
			&nullableNamaPendetaSidi,
			&registrasiSidi.IDStatus,
			&registrasiSidi.Status,
			&registrasiSidi.NamaHubKeluarga,
			&nullableFileSidi,
		); err != nil {
			return nil, fmt.Errorf("failed to scan row: %v", err)
		}

		// Convert RawBytes to string
		if len(nullableTanggalSidi) > 0 {
			registrasiSidi.TanggalSidi = string(nullableTanggalSidi)
		} else {
			registrasiSidi.TanggalSidi = ""
		}

		if nullableNatsSidi.Valid {
			registrasiSidi.NatsSidi = nullableNatsSidi.String
		} else {
			registrasiSidi.NatsSidi = ""
		}

		if nullableNomorSuratSidi.Valid {
			registrasiSidi.NomorSuratSidi = nullableNomorSuratSidi.String
		} else {
			registrasiSidi.NomorSuratSidi = ""
		}

		if nullableNamaPendetaSidi.Valid {
			registrasiSidi.NamaPendetaSidi = nullableNamaPendetaSidi.String
		} else {
			registrasiSidi.NamaPendetaSidi = ""
		}

		if nullableFileSidi.Valid {
			registrasiSidi.FileSuratBaptis = nullableFileSidi.String
		} else {
			registrasiSidi.FileSuratBaptis = ""
		}

		return &registrasiSidi, nil
	}

	return nil, fmt.Errorf("no sidi found with ID: %d", idRegistrasiSidi)
}
