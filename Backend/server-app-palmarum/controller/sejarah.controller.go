package controller

import (
	"net/http"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"

	"github.com/gin-gonic/gin"
)

type SejarahController struct{}

func NewSejarahGerejaController() *SejarahController {
	return &SejarahController{}
}

func (jc *SejarahController) GetDataSejarah(c *gin.Context) {
	sejarah, err := database.GetSejarahGereja()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, sejarah)
}

func (sc *SejarahController) UpdateSejarahGereja(c *gin.Context) {
	// Ambil ID sejarah dari parameter URL
	idSejarahStr := c.Param("id")

	// Konversi ID sejarah menjadi tipe data int
	idSejarah, err := strconv.Atoi(idSejarahStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "ID sejarah harus berupa bilangan bulat"})
		return
	}

	// Bind JSON request ke struct model.SejarahGereja
	var request model.SejarahGereja
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid data"})
		return
	}

	// Panggil fungsi database untuk update data sejarah gereja berdasarkan ID
	err = database.UpdateSejarahGereja(idSejarah, request.IDJemaat, request.Sejarah)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "History updated successfully"})
}
