package controller

import (
	"net/http"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"

	"github.com/gin-gonic/gin"
)

type JadwalIbadahController struct{}

func NewJadwalIbadahController() *JadwalIbadahController {
	return &JadwalIbadahController{}
}

func (jc *JadwalIbadahController) GetAllJadwalIbadah(c *gin.Context) {
	pelayanIbadah, err := database.GetJadwalIbadah()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pelayanIbadah)
}

func (pc *JadwalIbadahController) EditDataJadwalIbadah(c *gin.Context) {
	// Ambil ID jadwal ibadah dari parameter URL
	jadwalID := c.Param("id")

	var u model.JadwalIbadah
	if err := c.BindJSON(&u); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat instansi model.JadwalIbadah baru dan salin nilainya dari variabel u
	jadwal := model.JadwalIbadah{
		IDJemaat:        u.IDJemaat,
		IDJenisMinggu:   u.IDJenisMinggu,
		NamaJenisMinggu: u.NamaJenisMinggu,
		TanggalIbadah:   u.TanggalIbadah,
		SesiIbadah:      u.SesiIbadah,
		Keterangan:      u.Keterangan,
	}

	err := database.UpdateJadwalIbadah(jadwalID, jadwal)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Data jadwal ibadah berhasil diperbarui"})
}

func (kc *JadwalIbadahController) AddJadwalIbadah(c *gin.Context) {
	var jadwal model.JadwalIbadah
	err := c.BindJSON(&jadwal)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat data jadwal ibadah di database
	err = database.CreateJadwalIbadah(jadwal)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Data jadwal ibadah created successfully!"})
}

func (jc *JadwalIbadahController) GetJadwalIbadahByIDHandler(c *gin.Context) {
	// Mendapatkan ID jadwal ibadah dari URL parameter
	idStr := c.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	// Panggil fungsi GetJadwalIbadahByID dari database
	jadwal, err := database.GetJadwalIbadahByID(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, jadwal)
}
