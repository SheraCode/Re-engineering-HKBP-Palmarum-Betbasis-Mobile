package model

type SejarahGereja struct {
	IDSejarah int    `json:"id_sejarah"`
	IDJemaat  int    `json:"id_jemaat"`
	Sejarah   string `json:"sejarah"`
}
