package model

type Pengeluaran struct {
	IDPengeluaran         int    `json:"id_pengeluaran"`
	IDJemaat              int    `json:"id_jemaat"`
	TanggalPengeluaran    string `json:"tanggal_pengeluaran"`
	JumlahPengeluaran     int    `json:"jumlah_pengeluaran"`
	KeteranganPengeluaran string `json:"keterangan_pengeluaran"`
	IDKategoriPengeluaran int    `json:"id_kategori_pengeluaran"`
	IDBank                int    `json:"id_bank"`
	BuktiPengeluaran      string `json:"bukti_pengeluaran"`
	NamaBank              string `json:"nama_bank"`
	NamaKategori          string `json:"nama_kategori"`
}
