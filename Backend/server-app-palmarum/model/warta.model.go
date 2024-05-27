package model

type Warta struct {
	IDWarta  int    `json:"id_warta"`
	IDJemaat int    `json:"id_jemaat"`
	Warta    string `json:"warta"`
	CreateAt string `json:"create_at"`
}
