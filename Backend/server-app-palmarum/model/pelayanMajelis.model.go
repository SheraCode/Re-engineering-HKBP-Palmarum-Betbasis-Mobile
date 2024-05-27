package model

// PelayanGereja represents the pelayan_gereja table in the database
type PelayanMajelis struct {
	IDPelayan   int    `json:"id_pelayan"`
	NamaPelayan string `json:"nama_pelayan"`
	IsTahbisan  int    `json:"isTahbisan"`
	Keterangan  string `json:"keterangan"`
}
