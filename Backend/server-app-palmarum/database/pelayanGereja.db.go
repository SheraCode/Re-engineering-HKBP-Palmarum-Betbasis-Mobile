package database

import (
	"database/sql"
	"fmt"
	"server-palmarum/model"

	_ "github.com/go-sql-driver/mysql"
)

func GetPelayanGereja() ([]model.PelayanGereja, error) {
	var pelayanGereja []model.PelayanGereja

	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return pelayanGereja, err
	}
	defer db.Close()

	rows, err := db.Query("CALL GetPelayanGereja()")
	if err != nil {
		return pelayanGereja, err
	}
	defer rows.Close()

	for rows.Next() {
		var pg model.PelayanGereja
		err := rows.Scan(&pg.IDMajelis, &pg.IDJemaat, &pg.TglTahbis, &pg.TglAkhirJabatan, &pg.IDStatusPelayan, &pg.CreateAt, &pg.UpdateAt, &pg.IsDeleted, &pg.StatusPelayan, &pg.NamaPelayan)
		if err != nil {
			return pelayanGereja, err
		}

		pelayanGereja = append(pelayanGereja, pg)
	}

	return pelayanGereja, nil
}

func CreatePelayanGereja(p model.PelayanGereja) error {
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	_, err = db.Exec("CALL CreatePelayanGerejaData(?, ?, ?)", p.IDJemaat, p.NamaPelayan, p.Keterangan)
	if err != nil {
		return err
	}

	return nil
}

func EditPelayanGerejaData(pIDPelayan int, pNamaPelayan string, pKeterangan string) error {
	// Buat koneksi ke database
	db, err := sql.Open("mysql", "root:@tcp(localhost:3306)/db_gereja_hkbp")
	if err != nil {
		return err
	}
	defer db.Close()

	// Panggil stored procedure EditPelayanGerejaData
	_, err = db.Exec("CALL EditPelayanGerejaData(?, ?, ?)", pIDPelayan, pNamaPelayan, pKeterangan)
	if err != nil {
		return err
	}

	fmt.Println("Data pelayan gereja berhasil diubah")
	return nil
}
