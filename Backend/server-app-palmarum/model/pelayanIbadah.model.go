package model

type PelayanIbadah struct {
	IDPelayanIbadah    int    `json:"id_pelayan_ibadah"`
	IDJemaat           int    `json:"id_jemaaat"`
	IDPelayan          int    `json:"id_jadwal_ibadah"`
	IDPelayanan_IBADAH int    `json:"id_pelayanan_ibadah"`
	NamaPelayanan      string `json:"nama_pelayanan_ibadah"`
	Keterangan         string `json:"keterangan"`
	SesiIbadah         string `json:"sesi_ibadah"`
	TanggalIbadah      string `json:"tgl_ibadah"`
}
