package model

type PelayanGereja struct {
	IDMajelis       int    `json:"id_majelis"`
	IDJemaat        int    `json:"id_jemaat"`
	IDPelayan       int    `json:"id_pelayan"`
	IDGereja        int    `json:"id_gereja"`
	TglTahbis       string `json:"tgl_tahbis"`
	Keterangan      string `json:"keterangan"`
	TglAkhirJabatan string `json:"tgl_akhir_jabatan"`
	IDStatusPelayan int    `json:"id_status_pelayan"`
	CreateAt        string `json:"create_at"`
	UpdateAt        string `json:"update_at"`
	IsDeleted       string `json:"is_deleted"`
	NamaPelayan     string `json:"nama_depan"`
	StatusPelayan   string `json:"status_pelayan"`
}
