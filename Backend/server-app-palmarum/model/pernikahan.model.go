package model

type RegistrasiPernikahan struct {
	IDRegistrasiNikah   int    `json:"id_registrasi_nikah"`
	IDJemaat            int    `json:"id_jemaat"`
	NamaGerejaLaki      string `json:"nama_gereja_laki"`
	NamaLaki            string `json:"nama_laki"`
	NamaAyahLaki        string `json:"nama_ayah_laki"`
	NamaIbuLaki         string `json:"nama_ibu_laki"`
	NamaGerejaPerempuan string `json:"nama_gereja_perempuan"`
	NamaPerempuan       string `json:"nama_perempuan"`
	NamaAyahPerempuan   string `json:"nama_ayah_perempuan"`
	NamaIbuPerempuan    string `json:"nama_ibu_perempuan"`
	Keterangan          string `json:"keterangan"`
	IDStatus            int    `json:"id_status"`
	Status              string `json:"status"`
}
