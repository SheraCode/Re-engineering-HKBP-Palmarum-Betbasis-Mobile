package database

import "database/sql"

func CreatePelayanKebaktian(idJemaat, idJadwalIbadah, idPelayananIbadah int, keterangan string) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL CreatePelayanIbadahData(?, ?, ?, ?)", idJemaat, idPelayananIbadah, idJadwalIbadah, keterangan)
	if err != nil {
		return err
	}

	return nil
}
