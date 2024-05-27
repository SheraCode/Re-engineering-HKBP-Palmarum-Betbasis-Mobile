package model

type Baptis struct {
	IDBaptis          int    `json:"id_registrasi_baptis"`
	IDJemaat          int    `json:"id_jemaat"`
	NamaAyah          string `json:"nama_ayah"`
	NamaIbu           string `json:"nama_ibu"`
	NamaLengkap       string `json:"nama_lengkap"`
	TempatLahir       string `json:"tempat_lahir"`
	TanggalLahir      string `json:"tanggal_lahir"`
	JenisKelamin      string `json:"jenis_kelamin"`
	IDHubKeluarga     int    `json:"id_hub_keluarga"`
	TanggalBaptis     string `json:"tanggal_baptis"` // field ini akan diabaikan jika kosong
	NoSuratBaptis     string `json:"no_surat_baptis"`
	NamaPendetaBaptis string `json:"nama_pendeta_baptis"`
	FileSuratBaptis   string `json:"file_surat_baptis"`
	IDStatus          int    `json:"id_status"`
	Status            string `json:"status"`
	NamaHubKeluarga   string `json:"nama_hub_keluarga"`
}
