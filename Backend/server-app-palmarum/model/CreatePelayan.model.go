package model

type CreatePelayan struct {
	IDPelayanIbadah   int    `json:"id_pelayan_ibadah"`
	IDJemaat          int    `json:"id_jemaat"`
	IDJadwalIbadah    int    `json:"id_jadwal_ibadah"`
	IDPelayananIbadah int    `json:"id_pelayanan_ibadah"`
	Keterangan        string `json:"keterangan"`
}
