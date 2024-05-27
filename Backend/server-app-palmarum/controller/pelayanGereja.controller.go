package controller

import (
	"net/http"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"

	"github.com/gin-gonic/gin"
)

type PelayanGerejaController struct{}

func NewPelayanGerejaController() *PelayanGerejaController {
	return &PelayanGerejaController{}
}

func (pc *PelayanGerejaController) GetDataPelayanGereja(c *gin.Context) {
	pelayanGereja, err := database.GetPelayanGereja()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pelayanGereja)
}

func (kc *PelayanGerejaController) CreatePelayanGereja(c *gin.Context) {
	var pelayan model.PelayanGereja
	err := c.Bind(&pelayan)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat data pelayan gereja di database
	err = database.CreatePelayanGereja(pelayan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Data pelayan gereja created successfully!"})
}

func (pc *PelayanGerejaController) EditDataPelayanGereja(c *gin.Context) {
	// Ambil ID pelayan dari parameter URL
	IDPelayanStr := c.Param("id")

	// Konversi IDPelayanStr menjadi tipe data int
	IDPelayan, err := strconv.Atoi(IDPelayanStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "ID pelayan harus berupa bilangan bulat"})
		return
	}

	var pelayan model.PelayanGereja
	if err := c.BindJSON(&pelayan); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	err = database.EditPelayanGerejaData(IDPelayan, pelayan.NamaPelayan, pelayan.Keterangan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Data pelayan gereja berhasil diperbarui"})
}
