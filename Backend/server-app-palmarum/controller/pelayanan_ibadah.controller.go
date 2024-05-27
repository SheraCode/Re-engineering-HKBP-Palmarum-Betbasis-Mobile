package controller

import (
	"net/http"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"

	"github.com/gin-gonic/gin"
)

type PelayananGerejaALLController struct{}

func NewPelayanGerejaALLController() *PelayananGerejaALLController {
	return &PelayananGerejaALLController{}
}

func (pc *PelayananGerejaALLController) GetDataPelayanGereja(c *gin.Context) {
	pelayanGereja, err := database.GetPelayananIbadahALL()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pelayanGereja)
}

func (pc *PelayananGerejaALLController) EditDataPelayanGereja(c *gin.Context) {
	// Ambil ID pelayan dari parameter URL
	pelayanID := c.Param("id")

	var u model.PelayanIbadahALL
	if err := c.BindJSON(&u); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat instansi model.PelayanIbadah baru dan salin nilainya dari variabel u
	pelayanan := model.PelayanIbadahALL{
		IDJemaat:      u.IDJemaat,
		NamaPelayanan: u.NamaPelayanan,
		Keterangan:    u.Keterangan,
	}

	err := database.UpdatePelayananIbadah(pelayanID, pelayanan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Data pelayan gereja berhasil diperbarui"})
}

func (kc *PelayananGerejaALLController) CreatePelayanIbadah(c *gin.Context) {
	var pelayan model.PelayanIbadahALL
	err := c.Bind(&pelayan)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat data pelayan ibadah di database
	err = database.CreatePelayananIbadah(pelayan.IDJemaat, pelayan.NamaPelayanan, pelayan.Keterangan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Data pelayan ibadah created successfully!"})
}

func (pc *PelayananGerejaALLController) GetPelayananIbadahByIDHandler(c *gin.Context) {
	// Mendapatkan ID pelayanan ibadah dari URL parameter
	idStr := c.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	// Panggil fungsi GetPelayananIbadahByID dari database
	pelayanan, err := database.GetPelayananIbadahByID(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pelayanan)
}

func (pc *PelayananGerejaALLController) GetPelayananGerejaByIDHandler(c *gin.Context) {
	// Mendapatkan ID pelayanan ibadah dari URL parameter
	idStr := c.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	// Panggil fungsi GetPelayananIbadahByID dari database
	pelayanan, err := database.GetPelayananIbadahByID(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pelayanan)
}
