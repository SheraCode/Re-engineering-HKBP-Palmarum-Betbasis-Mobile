package database

import (
	"database/sql"
	"server-palmarum/model"
	"time"
)

func GetPelayanIbadah() ([]model.PelayanIbadah, error) {
	var pelayanibadah []model.PelayanIbadah

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return pelayanibadah, err
	}
	defer db.Close()

	rows, err := db.Query("CALL GetPelayanIbadahData()")
	if err != nil {
		return pelayanibadah, err
	}
	defer rows.Close()

	for rows.Next() {
		var pl model.PelayanIbadah
		err := rows.Scan(&pl.IDPelayanIbadah, &pl.IDPelayanan_IBADAH, &pl.IDPelayan, &pl.NamaPelayanan, &pl.Keterangan, &pl.SesiIbadah, &pl.TanggalIbadah)
		if err != nil {
			return pelayanibadah, err
		}

		pelayanibadah = append(pelayanibadah, pl)
	}

	return pelayanibadah, nil
}

func CreatePelayanIbadah(p_id_jemaat, p_id_jadwal_ibadah, p_id_pelayanan_ibadah int, p_keterangan string) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL CreatePelayanIbadahData(?, ?, ?, ?)", p_id_jemaat, p_id_jadwal_ibadah, p_id_pelayanan_ibadah, p_keterangan)
	if err != nil {
		return err
	}

	return nil
}

func CheckPelayananIbadahExists(idPelayananIbadah int) (bool, error) {
	var exists bool
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return false, err
	}
	defer db.Close()

	query := `SELECT COUNT(1) FROM pelayanan_ibadah WHERE id_pelayanan_ibadah = ?`
	err = db.QueryRow(query, idPelayananIbadah).Scan(&exists)
	if err != nil {
		return false, err
	}

	return exists, nil
}

func DeletePelayanIbadahByCreateAt(deleteDate time.Time) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL delete_pelayan_ibadah_by_create_at(?)", deleteDate.Format("2006-01-02 15:04:05"))
	if err != nil {
		return err
	}

	return nil
}

func DeletePelayanIbadah(idPelayan int) error {
	db, err := sql.Open("mysql", DBUsername+":"+DBPassword+"@tcp("+DBHost+":"+DBPort+")/"+DBName)
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL DeletePelayanIbadahById(?)", idPelayan)
	if err != nil {
		return err
	}

	return nil
}
