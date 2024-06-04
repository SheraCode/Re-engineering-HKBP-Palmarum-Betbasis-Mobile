package model

type Jemaat struct {
	IDJemaat                int    `json:"id_jemaat"`
	RoleJemaat              string `json:"role_jemaat"`
	NamaDepan               string `json:"nama_depan"`
	NamaBelakang            string `json:"nama_belakang"`
	TGLLahir                string `json:"tgl_lahir"`
	Email                   string `json:"email"`
	Password                string `json:"password"`
	GelarDepan              string `json:"gelar_depan"`
	GelarBelakang           string `json:"gelar_belakang"`
	TempatLahir             string `json:"tempat_lahir"`
	JenisKelamin            string `json:"jenis_kelamin"`
	IDHubKeluarga           int    `json:"id_hub_keluarga"`
	IDStatusPernikahan      int    `json:"id_status_pernikahan"`
	IDStatusAmaIna          int    `json:"id_status_ama_ina"`
	IDStatusAnak            int    `json:"id_status_anak"`
	IDPendidikan            int    `json:"id_pendidikan"`
	IDBidangPendidikan      int    `json:"id_bidang_pendidikan"`
	BidangPendidikanLainnya string `json:"bidang_pendidikan_lainnya"`
	IDPekerjaan             int    `json:"id_pekerjaan"`
	NamaPekerjaanLainnya    string `json:"nama_pekerjaan_lainnya"`
	GolDarah                string `json:"gol_darah"`
	Alamat                  string `json:"alamat"`
	IsSidi                  string `json:"isSidi"`
	IDKecamatan             int    `json:"id_kecamatan"`
	NoTelepon               int    `json:"no_hp"`
	FotoJemaat              string `json:"foto_jemaat"`
	Keterangan              string `json:"keterangan"`
	IsBaptis                string `json:"isBaptis"`
	IsMenikah               string `json:"isMenikah"`
	IsMeninggal             string `json:"isMeninggal"`
	IsRPP                   string `json:"isRPP"`
	IDRegistrasiKeluarga    int    `json:"no_registrasi_keluarga"`
	CreateAt                string `json:"create_at"`
	UpdateAt                string `json:"update_at"`
	IsDeleted               string `json:"is_deleted"`
}
