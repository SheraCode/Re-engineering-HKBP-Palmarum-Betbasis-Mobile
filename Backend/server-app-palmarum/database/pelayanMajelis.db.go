package database

import (
	"database/sql"
	"server-palmarum/model"
)

func GetUntukMajelisPelayanGereja() ([]model.PelayanMajelis, error) {
	var gerejaPelayan []model.PelayanMajelis

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return gerejaPelayan, err
	}
	defer db.Close()

	rows, err := db.Query("CALL get_pelayan_gereja()")
	if err != nil {
		return gerejaPelayan, err
	}
	defer rows.Close()

	for rows.Next() {
		var pg model.PelayanMajelis
		err := rows.Scan(&pg.IDPelayan, &pg.NamaPelayan, &pg.IsTahbisan, &pg.Keterangan)
		if err != nil {
			return gerejaPelayan, err
		}

		gerejaPelayan = append(gerejaPelayan, pg)
	}

	return gerejaPelayan, nil
}
