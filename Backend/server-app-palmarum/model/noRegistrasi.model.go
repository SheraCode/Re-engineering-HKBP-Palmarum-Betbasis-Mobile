package model

type NoRegKeluarga struct {
	IDRegistrasi       int    `json:"id_registrasi_keluarga"`
	IDJemaat           int    `json:"id_jemaat"`
	NoKK               int    `json:"no_kk"`
	NamaKepalaKeluarga string `json:"nama_kepala_keluarga"`
}
