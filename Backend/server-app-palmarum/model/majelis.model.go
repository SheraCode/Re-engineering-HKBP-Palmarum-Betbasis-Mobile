package model

type Majelis struct {
	IDMajelis       int    `json:"id_majelis"`
	IDJemaat        int    `json:"id_jemaat"`
	IDPelayan       int    `json:"id_pelayan"`
	IDGereja        int    `json:"id_gereja" default:"1"`
	TglTahbis       string `json:"tgl_tahbis"`
	TglAkhirJabatan string `json:"tgl_akhir_jabatan"`
	IDStatusPelayan int    `json:"id_status_pelayan"`
	CreatedAt       string `json:"create_at"`
	UpdatedAt       string `json:"update_at"`
	IsDeleted       string `json:"is_deleted"`
}
