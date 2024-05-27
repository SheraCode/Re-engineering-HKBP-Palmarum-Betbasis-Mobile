package database

import (
	"database/sql"
	"server-palmarum/model"
)

// CreatePelayan inserts a new PelayanPalmarum into the database
func CreatePelayan(pelayan model.PelayanPalmarum) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL add_pelayan_gereja(?, ?, ?, ?)", pelayan.IDJemaat, pelayan.NamaPelayan, pelayan.IsTahbisan, pelayan.Keterangan)
	if err != nil {
		return err
	}

	return nil
}

// UpdatePelayan updates an existing PelayanPalmarum in the database
func UpdatePelayan(pelayan model.PelayanPalmarum) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL update_pelayan_gereja(?, ?, ?, ?, ?)", pelayan.IdPelayan, pelayan.IDJemaat, pelayan.NamaPelayan, pelayan.IsTahbisan, pelayan.Keterangan)
	if err != nil {
		return err
	}

	return nil
}

func GetPelayanByID(id int) (model.PelayanPalmarum, error) {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return model.PelayanPalmarum{}, err
	}
	defer db.Close()

	var pelayan model.PelayanPalmarum
	row := db.QueryRow("CALL get_pelayan_gereja_by_id(?)", id)
	err = row.Scan(
		&pelayan.IdPelayan,
		&pelayan.NamaPelayan,
		&pelayan.IsTahbisan,
		&pelayan.Keterangan,
	)
	if err != nil {
		if err == sql.ErrNoRows {
			return model.PelayanPalmarum{}, nil
		}
		return model.PelayanPalmarum{}, err
	}

	return pelayan, nil
}

func DeletePelayanByID(id int) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL delete_pelayan_gereja(?)", id)
	if err != nil {
		return err
	}

	return nil
}
