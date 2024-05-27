package model

type PelayanIbadahALL struct {
	IDPelayananIbadah int    `json:"id_pelayanan_ibadah"`
	IDJemaat          int    `json:"id_jemaat"`
	NamaPelayanan     string `json:"nama_pelayanan_ibadah"`
	Keterangan        string `json:"keterangan"`
	CreateAt          string `json:"create_at"`
	UpdateAt          string `json:"update_at"`
	IsDeleted         string `json:"is_deleted"`
}
