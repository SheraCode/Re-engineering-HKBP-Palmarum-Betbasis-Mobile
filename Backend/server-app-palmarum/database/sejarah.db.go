package database

import (
	"database/sql"
	"server-palmarum/model"

	_ "github.com/go-sql-driver/mysql"
)

func GetSejarahGereja() ([]model.SejarahGereja, error) {
	var sejarah []model.SejarahGereja

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return sejarah, err
	}
	defer db.Close()

	rows, err := db.Query("CALL read_sejarah_gereja()")
	if err != nil {
		return sejarah, err
	}
	defer rows.Close()

	for rows.Next() {
		var SG model.SejarahGereja
		err := rows.Scan(&SG.IDSejarah, &SG.IDJemaat, &SG.Sejarah)
		if err != nil {
			return sejarah, err
		}

		sejarah = append(sejarah, SG)
	}

	return sejarah, nil
}

func UpdateSejarahGereja(sejarahID int, IDJemaat int, sejarah string) error {
	// Establish database connection
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	// Prepare and execute the stored procedure
	stmt, err := db.Prepare("CALL update_sejarah_gereja(?, ?, ?)")
	if err != nil {
		return err
	}
	defer stmt.Close()

	// Execute the stored procedure with the provided parameters
	_, err = stmt.Exec(sejarahID, IDJemaat, sejarah)
	if err != nil {
		return err
	}

	return nil
}
