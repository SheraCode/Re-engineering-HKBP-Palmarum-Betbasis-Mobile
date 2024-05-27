package database

import (
	"database/sql"
	"fmt"
	"server-palmarum/model"
)

func CreatePernikahan(IDJemaat, IDStatus int, NamaGerejaLaki, Namalaki, NamaAyahLaki, NamaIbuLaki, NamaGerejaPerempuan, NamaPerempuan, NamaAyahPerempuan, NamaIbuPerempuan, Keterangan string) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL CreateRegistrasiPernikahan(?, ?, ?, ?, ?, ?, ?, ?, ?)", IDJemaat, NamaGerejaLaki, Namalaki, NamaAyahLaki, NamaIbuLaki, NamaGerejaPerempuan, NamaPerempuan, NamaAyahPerempuan, NamaIbuPerempuan)
	if err != nil {
		return err
	}
	return nil
}

func GetPernikahanById(id int) (*model.RegistrasiPernikahan, error) {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return nil, fmt.Errorf("failed to connect to database: %v", err)
	}
	defer db.Close()

	var pernikahan model.RegistrasiPernikahan
	var nullableKeterangan sql.NullString

	row := db.QueryRow("CALL GetPernikahanById(?)", id)
	err = row.Scan(
		&pernikahan.IDRegistrasiNikah,
		&pernikahan.IDJemaat,
		&pernikahan.IDStatus,
		&pernikahan.NamaGerejaLaki,
		&pernikahan.NamaLaki,
		&pernikahan.NamaAyahLaki,
		&pernikahan.NamaIbuLaki,
		&pernikahan.NamaGerejaPerempuan,
		&pernikahan.NamaPerempuan,
		&pernikahan.NamaAyahPerempuan,
		&pernikahan.NamaIbuPerempuan,
		&nullableKeterangan,
		&pernikahan.Status,
	)
	if err != nil {
		if err == sql.ErrNoRows {
			return nil, fmt.Errorf("no pernikahan found with ID: %d", id)
		}
		return nil, fmt.Errorf("failed to scan row: %v", err)
	}

	if nullableKeterangan.Valid {
		pernikahan.Keterangan = nullableKeterangan.String
	} else {
		pernikahan.Keterangan = ""
	}

	return &pernikahan, nil
}

func GetAllPernikahan() ([]model.RegistrasiPernikahan, error) {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return nil, fmt.Errorf("failed to connect to database: %v", err)
	}
	defer db.Close()

	rows, err := db.Query("CALL GetAllRegistrasiPernikahan()")
	if err != nil {
		return nil, fmt.Errorf("failed to execute query: %v", err)
	}
	defer rows.Close()

	var pernikahanList []model.RegistrasiPernikahan

	for rows.Next() {
		var pernikahan model.RegistrasiPernikahan
		var nullableKeterangan sql.NullString
		err := rows.Scan(
			&pernikahan.IDRegistrasiNikah,
			&pernikahan.IDJemaat,
			&pernikahan.IDStatus,
			&pernikahan.NamaGerejaLaki,
			&pernikahan.NamaLaki,
			&pernikahan.NamaAyahLaki,
			&pernikahan.NamaIbuLaki,
			&pernikahan.NamaGerejaPerempuan,
			&pernikahan.NamaPerempuan,
			&pernikahan.NamaAyahPerempuan,
			&pernikahan.NamaIbuPerempuan,
			&nullableKeterangan,
			&pernikahan.Status,
		)
		if err != nil {
			return nil, fmt.Errorf("failed to scan row: %v", err)
		}

		if nullableKeterangan.Valid {
			pernikahan.Keterangan = nullableKeterangan.String
		} else {
			pernikahan.Keterangan = ""
		}

		pernikahanList = append(pernikahanList, pernikahan)
	}

	if err = rows.Err(); err != nil {
		return nil, fmt.Errorf("error iterating rows: %v", err)
	}

	return pernikahanList, nil
}

func GetPernikahanByJemaat(idJemaat int) ([]model.RegistrasiPernikahan, error) {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return nil, fmt.Errorf("failed to connect to database: %v", err)
	}
	defer db.Close()

	rows, err := db.Query("CALL GetRegistrasiPernikahanByJemaat(?)", idJemaat)
	if err != nil {
		return nil, fmt.Errorf("failed to execute query: %v", err)
	}
	defer rows.Close()

	var pernikahanList []model.RegistrasiPernikahan

	for rows.Next() {
		var pernikahan model.RegistrasiPernikahan
		var nullableKeterangan sql.NullString
		err := rows.Scan(
			&pernikahan.IDRegistrasiNikah,
			&pernikahan.IDJemaat,
			&pernikahan.IDStatus,
			&pernikahan.NamaGerejaLaki,
			&pernikahan.NamaLaki,
			&pernikahan.NamaAyahLaki,
			&pernikahan.NamaIbuLaki,
			&pernikahan.NamaGerejaPerempuan,
			&pernikahan.NamaPerempuan,
			&pernikahan.NamaAyahPerempuan,
			&pernikahan.NamaIbuPerempuan,
			&nullableKeterangan,
			&pernikahan.Status,
		)
		if err != nil {
			return nil, fmt.Errorf("failed to scan row: %v", err)
		}

		if nullableKeterangan.Valid {
			pernikahan.Keterangan = nullableKeterangan.String
		} else {
			pernikahan.Keterangan = ""
		}

		pernikahanList = append(pernikahanList, pernikahan)
	}

	if err = rows.Err(); err != nil {
		return nil, fmt.Errorf("error iterating rows: %v", err)
	}

	return pernikahanList, nil
}

func UpdateStatusPernikahanByIdRegistrasiNikah(idRegistrasiNikah int, newStatusID int, newKeterangan string) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return fmt.Errorf("failed to connect to database: %v", err)
	}
	defer db.Close()

	_, err = db.Exec("CALL UpdateStatusAndKeteranganPernikahanByIdRegistrasiNikah(?, ?, ?)", idRegistrasiNikah, newStatusID, newKeterangan)
	if err != nil {
		return fmt.Errorf("failed to update status: %v", err)
	}

	return nil
}
