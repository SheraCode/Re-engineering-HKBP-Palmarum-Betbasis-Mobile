package model

type Pemasukan struct {
	IDPemasukan           int    `json:"id_pemasukan"`
	IDJemaat              int    `json:"id_jemaat"`
	TanggalPemasukan      string `json:"tanggal_pemasukan"`
	TotalPemasukan        int    `json:"total_pemasukan"`
	BentukPemasukan       string `json:"bentuk_pemasukan"`
	IDKategoriPemasukan   int    `json:"id_kategori_pemasukan"`
	BuktiPemasukan        string `json:"bukti_pemasukan"`
	IDBank                int    `json:"id_bank"`
	NamaBank              string `json:"nama_bank"`
	NamaKategoriPemasukan string `json:"kategori_pemasukan"`
}
