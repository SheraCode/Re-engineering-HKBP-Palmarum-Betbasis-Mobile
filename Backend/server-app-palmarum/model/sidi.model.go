package model

type RegistrasiSidi struct {
	IDRegistrasiSidi int    `json:"id_registrasi_sidi" `
	IDJemaat         int    `json:"id_jemaat"`
	NamaAyah         string `json:"nama_ayah"`
	NamaIbu          string `json:"nama_ibu"`
	NamaLengkap      string `json:"nama_lengkap"`
	TempatLahir      string `json:"tempat_lahir"`
	TanggalLahir     string `json:"tanggal_lahir"`
	JenisKelamin     string `json:"jenis_kelamin"`
	IDHubKeluarga    int    `json:"id_hub_keluarga"`
	NamaHubKeluarga  string `json:"nama_hub_keluarga"`
	TanggalSidi      string `json:"tanggal_sidi"`
	NatsSidi         string `json:"nats_sidi"`
	NomorSuratSidi   string `json:"nomor_surat_sidi"`
	NamaPendetaSidi  string `json:"nama_pendeta_sidi"`
	FileSuratBaptis  string `json:"file_surat_baptis"`
	IDStatus         int    `json:"id_status"`
	Status           string `json:"status"`
}
