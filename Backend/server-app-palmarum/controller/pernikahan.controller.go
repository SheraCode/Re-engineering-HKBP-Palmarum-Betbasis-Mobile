package controller

import (
	"net/http"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"

	"github.com/gin-gonic/gin"
)

type PernikahanController struct{}

func NewPernikahanController() *PernikahanController {
	return &PernikahanController{}
}

func (pc *PernikahanController) CreatePernikahan(c *gin.Context) {
	var pernikahan model.RegistrasiPernikahan
	if err := c.Bind(&pernikahan); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat data pernikahan di database
	err := database.CreatePernikahan(pernikahan.IDJemaat, pernikahan.IDStatus, pernikahan.NamaGerejaLaki, pernikahan.NamaLaki, pernikahan.NamaAyahLaki, pernikahan.NamaIbuLaki, pernikahan.NamaGerejaPerempuan, pernikahan.NamaPerempuan, pernikahan.NamaAyahPerempuan, pernikahan.NamaIbuPerempuan, pernikahan.Keterangan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Pernikahan created successfully!"})
}

func (pc *PernikahanController) GetPernikahanById(c *gin.Context) {
	idParam := c.Param("id")
	id, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	pernikahan, err := database.GetPernikahanById(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pernikahan)
}

func (pc *PernikahanController) GetAllPernikahan(c *gin.Context) {
	pernikahanList, err := database.GetAllPernikahan()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pernikahanList)
}

func (pc *PernikahanController) GetPernikahanByJemaat(c *gin.Context) {
	idJemaatStr := c.Param("id_jemaat")
	idJemaat, err := strconv.Atoi(idJemaatStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid id_jemaat"})
		return
	}

	pernikahanList, err := database.GetPernikahanByJemaat(idJemaat)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pernikahanList)
}

func (pc *PernikahanController) UpdateStatusPernikahanByIdRegistrasiNikah(c *gin.Context) {
	idRegistrasiNikahStr := c.Param("id_registrasi_nikah")
	idRegistrasiNikah, err := strconv.Atoi(idRegistrasiNikahStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid id_registrasi_nikah"})
		return
	}

	var json struct {
		IDStatus         int    `json:"id_status"`
		UpdateKeterangan string `json:"keterangan"`
	}
	if err := c.BindJSON(&json); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	err = database.UpdateStatusPernikahanByIdRegistrasiNikah(idRegistrasiNikah, json.IDStatus, json.UpdateKeterangan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Status updated successfully!"})
}
