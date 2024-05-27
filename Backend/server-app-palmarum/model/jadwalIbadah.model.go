package model

type JadwalIbadah struct {
	IDJadwalIbadah  int    `json:"id_jadwal_ibadah"`
	IDJemaat        int    `json:"id_jemaat"`
	IDJenisMinggu   int    `json:"id_jenis_minggu"`
	NamaJenisMinggu string `json:"nama_jenis_minggu"`
	TanggalIbadah   string `json:"tgl_ibadah"`
	SesiIbadah      string `json:"sesi_ibadah"`
	Keterangan      string `json:"keterangan"`
}
