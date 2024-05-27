package database

import (
	"database/sql"
	"server-palmarum/model"
	"strconv"

	_ "github.com/go-sql-driver/mysql"
)

func CreateMajelis(m model.Majelis) error {
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL sp_create_majelis(?, ?, ?, ?)",
		m.IDJemaat,
		m.TglTahbis,
		m.TglAkhirJabatan,
		m.IDStatusPelayan,
	)
	if err != nil {
		return err
	}

	return nil
}

func UpdateMajelis(majelisID string, majelis model.Majelis) error {
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		return err
	}
	defer db.Close()

	stmt, err := db.Prepare("CALL sp_update_majelis(?, ?, ?, ?)")
	if err != nil {
		return err
	}
	defer stmt.Close()

	// Konversi majelisID ke integer
	majelisIDInt, err := strconv.Atoi(majelisID)
	if err != nil {
		return err
	}

	_, err = stmt.Exec(majelisIDInt, majelis.TglTahbis, majelis.TglAkhirJabatan, majelis.IDStatusPelayan)
	if err != nil {
		return err
	}

	return nil
}

func GetMajelisByID(idMajelis int) ([]model.Majelis, error) {
	var warta []model.Majelis

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return warta, err
	}
	defer db.Close()

	// Prepare the stored procedure call
	stmt, err := db.Prepare("CALL majelis_BYID(?)")
	if err != nil {
		return warta, err
	}
	defer stmt.Close()

	// Execute the stored procedure
	rows, err := stmt.Query(idMajelis)
	if err != nil {
		return warta, err
	}
	defer rows.Close()

	// Iterate over the result set
	for rows.Next() {
		var w model.Majelis
		err := rows.Scan(&w.IDMajelis, &w.IDJemaat, &w.TglTahbis, &w.TglAkhirJabatan, &w.IDStatusPelayan, &w.CreatedAt, &w.UpdatedAt, &w.IsDeleted)
		if err != nil {
			return warta, err
		}

		warta = append(warta, w)
	}

	return warta, nil
}

func DeleteMajelis(idMajelis int) error {
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL sp_delete_majelis(?)", idMajelis)
	if err != nil {
		return err
	}

	return nil
}
