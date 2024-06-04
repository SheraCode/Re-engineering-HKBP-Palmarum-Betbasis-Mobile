package database

import (
	"database/sql"
	"server-palmarum/model"
	"strconv"
)

func CreateNoRegKel(noKK int, idJemaat int, NamaKepalaKeluarga string) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL create_registrasi_keluarga(?, ?, ?)", noKK, idJemaat, NamaKepalaKeluarga)
	if err != nil {
		return err
	}

	return nil
}

func GetNoRegKeluarga() ([]model.NoRegKeluarga, error) {
	var noRegKel []model.NoRegKeluarga

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return noRegKel, err
	}
	defer db.Close()

	rows, err := db.Query("CALL get_all_keluarga()")
	if err != nil {
		return noRegKel, err
	}
	defer rows.Close()

	for rows.Next() {
		var w model.NoRegKeluarga
		err := rows.Scan(&w.IDRegistrasi, &w.NoKK, &w.IDJemaat, &w.NamaKepalaKeluarga)
		if err != nil {
			return noRegKel, err
		}

		noRegKel = append(noRegKel, w)
	}

	return noRegKel, nil
}

func UpdateNoRegKel(idNoRegKel string, noRegKel model.NoRegKeluarga) error {
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		return err
	}
	defer db.Close()

	stmt, err := db.Prepare("CALL update_registrasi_keluarga(?, ?, ?, ?)")
	if err != nil {
		return err
	}
	defer stmt.Close()

	// Konversi noRegKelID ke integer
	noRegKelIDInt, err := strconv.Atoi(idNoRegKel)
	if err != nil {
		return err
	}

	_, err = stmt.Exec(noRegKelIDInt, noRegKel.NoKK, noRegKel.IDJemaat, noRegKel.NamaKepalaKeluarga)
	if err != nil {
		return err
	}

	return nil
}

func NoRegKelByID(idNoRegKel int) ([]model.NoRegKeluarga, error) {
	var noREGKel []model.NoRegKeluarga

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return noREGKel, err
	}
	defer db.Close()

	// Prepare the stored procedure call
	stmt, err := db.Prepare("CALL registrasi_keluarga_by_id(?)")
	if err != nil {
		return noREGKel, err
	}
	defer stmt.Close()

	// Execute the stored procedure
	rows, err := stmt.Query(idNoRegKel)
	if err != nil {
		return noREGKel, err
	}
	defer rows.Close()

	// Iterate over the result set
	for rows.Next() {
		var w model.NoRegKeluarga
		err := rows.Scan(&w.IDRegistrasi, &w.IDJemaat, &w.NoKK, &w.NamaKepalaKeluarga)
		if err != nil {
			return noREGKel, err
		}

		noREGKel = append(noREGKel, w)
	}

	return noREGKel, nil
}
