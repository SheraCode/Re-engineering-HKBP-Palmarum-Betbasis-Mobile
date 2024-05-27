package database

import (
	"database/sql"
	"server-palmarum/model"
	"strconv"
)

func GetPelayananIbadahALL() ([]model.PelayanIbadahALL, error) {
	var pelayanan_ibadah []model.PelayanIbadahALL

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return pelayanan_ibadah, err
	}
	defer db.Close()

	rows, err := db.Query("CALL ReadPelayananIbadah()")
	if err != nil {
		return pelayanan_ibadah, err
	}
	defer rows.Close()

	for rows.Next() {
		var peibad model.PelayanIbadahALL
		err := rows.Scan(&peibad.IDPelayananIbadah, &peibad.NamaPelayanan, &peibad.Keterangan, &peibad.CreateAt, &peibad.UpdateAt, &peibad.IsDeleted)
		if err != nil {
			return pelayanan_ibadah, err
		}

		pelayanan_ibadah = append(pelayanan_ibadah, peibad)
	}

	return pelayanan_ibadah, nil
}

func CreatePelayananIbadah(idJemaat int, namaPelayanan string, keterangan string) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL CreatePelayananIbadahData(?, ?, ?)", idJemaat, namaPelayanan, keterangan)
	if err != nil {
		return err
	}

	return nil
}

func UpdatePelayananIbadah(pelayananID string, u model.PelayanIbadahALL) error {
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		return err
	}
	defer db.Close()

	stmt, err := db.Prepare("CALL EditPelayananIbadah(?, ?, ?, ?)")
	if err != nil {
		return err
	}
	defer stmt.Close()

	// Konversi pelayananID menjadi integer jika diperlukan
	pelayananIDInt, err := strconv.Atoi(pelayananID)
	if err != nil {
		return err
	}

	_, err = stmt.Exec(pelayananIDInt, u.IDJemaat, u.NamaPelayanan, u.Keterangan)
	if err != nil {
		return err
	}

	return nil
}

func GetPelayananIbadahByID(id int) (model.PelayanIbadahALL, error) {
	var pelayanan model.PelayanIbadahALL

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return pelayanan, err
	}
	defer db.Close()

	// Prepare statement untuk memanggil stored procedure GetPelayananIbadahByID
	stmt, err := db.Prepare("CALL GetPelayananIbadahByID(?)")
	if err != nil {
		return pelayanan, err
	}
	defer stmt.Close()

	// Eksekusi stored procedure dengan parameter ID
	err = stmt.QueryRow(id).Scan(
		&pelayanan.IDPelayananIbadah,
		&pelayanan.NamaPelayanan,
		&pelayanan.Keterangan,
		&pelayanan.CreateAt,
		&pelayanan.IsDeleted,
		&pelayanan.UpdateAt,
	)
	if err != nil {
		return pelayanan, err
	}

	return pelayanan, nil
}
