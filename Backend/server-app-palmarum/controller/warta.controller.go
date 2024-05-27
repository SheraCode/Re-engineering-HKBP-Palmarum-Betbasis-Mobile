package controller

import (
	"net/http"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"

	"github.com/gin-gonic/gin"
)

type WartaController struct{}

func NewWartaController() *WartaController {
	return &WartaController{}
}

func (jc *WartaController) GetDataWarta(c *gin.Context) {
	kegiatan, err := database.GetWarta()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, kegiatan)
}

func (jc *WartaController) GetDataWartaByID(c *gin.Context) {
	idWartaStr := c.Param("id_warta") // Assuming the ID is passed as a route parameter
	idWarta, err := strconv.Atoi(idWartaStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	warta, err := database.GetWartaByID(idWarta)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, warta)
}

func (jc *WartaController) GetDataWartaHome(c *gin.Context) {
	kegiatan, err := database.GetWartaHome()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, kegiatan)
}

func (wc *WartaController) CreateWarta(c *gin.Context) {
	var warta model.Warta
	err := c.Bind(&warta)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat data warta di database
	err = database.CreateWarta(warta.Warta, warta.IDJemaat)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Warta created successfully!"})
}

func (wc *WartaController) EditWarta(c *gin.Context) {
	// Ambil ID warta dari parameter URL
	wartaID := c.Param("id")

	var w model.Warta
	if err := c.BindJSON(&w); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat instansi model.Warta baru untuk data yang akan diubah
	warta := model.Warta{
		IDWarta:  w.IDWarta, // ID warta yang akan diubah
		Warta:    w.Warta,   // Teks warta baru
		IDJemaat: w.IDJemaat,
	}

	err := database.UpdateWarta(wartaID, warta)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Data warta berhasil diperbarui"})
}
