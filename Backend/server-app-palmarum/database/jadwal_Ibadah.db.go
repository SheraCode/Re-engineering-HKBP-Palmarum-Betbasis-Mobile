package database

import (
	"database/sql"
	"server-palmarum/model"
	"strconv"
)

func GetJadwalIbadah() ([]model.JadwalIbadah, error) {
	var jadwalIbadah []model.JadwalIbadah

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return jadwalIbadah, err
	}
	defer db.Close()

	rows, err := db.Query("CALL GetJadwalIbadah()")
	if err != nil {
		return jadwalIbadah, err
	}
	defer rows.Close()

	for rows.Next() {
		var jadwal model.JadwalIbadah // Menggunakan model.JadwalIbadah di sini
		err := rows.Scan(&jadwal.IDJadwalIbadah, &jadwal.NamaJenisMinggu, &jadwal.TanggalIbadah, &jadwal.SesiIbadah, &jadwal.Keterangan, &jadwal.IDJenisMinggu)
		if err != nil {
			return jadwalIbadah, err
		}

		jadwalIbadah = append(jadwalIbadah, jadwal)
	}

	return jadwalIbadah, nil
}

func UpdateJadwalIbadah(jadwalID string, jadwal model.JadwalIbadah) error {
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		return err
	}
	defer db.Close()

	stmt, err := db.Prepare("CALL EditJadwalIbadah(?, ?, ?, ?, ?, ?)")
	if err != nil {
		return err
	}
	defer stmt.Close()

	// Konversi jadwalID menjadi integer jika diperlukan
	jadwalIDInt, err := strconv.Atoi(jadwalID)
	if err != nil {
		return err
	}

	_, err = stmt.Exec(jadwalIDInt, jadwal.IDJemaat, jadwal.IDJenisMinggu, jadwal.TanggalIbadah, jadwal.SesiIbadah, jadwal.Keterangan)
	if err != nil {
		return err
	}

	return nil
}

func CreateJadwalIbadah(jadwal model.JadwalIbadah) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	// Panggil stored procedure CreateJadwalIbadahData dengan parameter
	_, err = db.Exec("CALL CreateJadwalIbadah(?, ?, ?, ?, ?)",
		jadwal.IDJemaat, jadwal.IDJenisMinggu, jadwal.TanggalIbadah, jadwal.SesiIbadah, jadwal.Keterangan)
	if err != nil {
		return err
	}

	return nil
}

func GetJadwalIbadahByID(id int) (model.JadwalIbadah, error) {
	var jadwal model.JadwalIbadah

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return jadwal, err
	}
	defer db.Close()

	// Prepare statement untuk memanggil stored procedure GetJadwalIbadahByID
	stmt, err := db.Prepare("CALL GetJadwalIbadahByID(?)")
	if err != nil {
		return jadwal, err
	}
	defer stmt.Close()

	// Eksekusi stored procedure dengan parameter ID
	err = stmt.QueryRow(id).Scan(
		&jadwal.IDJadwalIbadah,
		&jadwal.NamaJenisMinggu,
		&jadwal.TanggalIbadah,
		&jadwal.SesiIbadah,
		&jadwal.Keterangan,
		&jadwal.IDJenisMinggu,
	)
	if err != nil {
		return jadwal, err
	}

	return jadwal, nil
}
