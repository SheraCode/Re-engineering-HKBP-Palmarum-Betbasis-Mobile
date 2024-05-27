package model

type PelayanPalmarum struct {
	IdPelayan   int    `json:"id_pelayan"`
	IDJemaat    int    `json:"id_jemaat"`
	NamaPelayan string `json:"nama_pelayan"`
	IsTahbisan  int    `json:"isTahbisan"`
	Keterangan  string `json:"keterangan"`
}
