package database

import (
	"database/sql"
	"server-palmarum/model"
	"strconv"

	_ "github.com/go-sql-driver/mysql"
)

func GetWarta() ([]model.Warta, error) {
	var warta []model.Warta

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return warta, err
	}
	defer db.Close()

	rows, err := db.Query("CALL GetDataWarta()")
	if err != nil {
		return warta, err
	}
	defer rows.Close()

	for rows.Next() {
		var w model.Warta
		err := rows.Scan(&w.IDWarta, &w.Warta, &w.CreateAt)
		if err != nil {
			return warta, err
		}

		warta = append(warta, w)
	}

	return warta, nil
}

func GetWartaHome() ([]model.Warta, error) {
	var warta []model.Warta

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return warta, err
	}
	defer db.Close()

	rows, err := db.Query("CALL GetDataWartaHome()")
	if err != nil {
		return warta, err
	}
	defer rows.Close()

	for rows.Next() {
		var w model.Warta
		err := rows.Scan(&w.IDWarta, &w.Warta, &w.CreateAt)
		if err != nil {
			return warta, err
		}

		warta = append(warta, w)
	}

	return warta, nil
}

func CreateWarta(wartaText string, idJemaat int) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL CreateWarta(?, ?)", wartaText, idJemaat)
	if err != nil {
		return err
	}

	return nil
}

func GetWartaByID(idWarta int) ([]model.Warta, error) {
	var warta []model.Warta

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return warta, err
	}
	defer db.Close()

	// Prepare the stored procedure call
	stmt, err := db.Prepare("CALL GetWartaByID(?)")
	if err != nil {
		return warta, err
	}
	defer stmt.Close()

	// Execute the stored procedure
	rows, err := stmt.Query(idWarta)
	if err != nil {
		return warta, err
	}
	defer rows.Close()

	// Iterate over the result set
	for rows.Next() {
		var w model.Warta
		err := rows.Scan(&w.IDWarta, &w.Warta, &w.CreateAt)
		if err != nil {
			return warta, err
		}

		warta = append(warta, w)
	}

	return warta, nil
}

func UpdateWarta(wartaID string, warta model.Warta) error {
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		return err
	}
	defer db.Close()

	stmt, err := db.Prepare("CALL EditWarta(?, ?, ?)")
	if err != nil {
		return err
	}
	defer stmt.Close()

	// Konversi wartaID ke integer
	wartaIDInt, err := strconv.Atoi(wartaID)
	if err != nil {
		return err
	}

	_, err = stmt.Exec(wartaIDInt, warta.Warta, warta.IDJemaat)
	if err != nil {
		return err
	}

	return nil
}
