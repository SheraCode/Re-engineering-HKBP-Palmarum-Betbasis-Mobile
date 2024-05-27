package controller

import (
	"net/http"
	"server-palmarum/database"
	"server-palmarum/model"

	"github.com/gin-gonic/gin"
)

type CreatePelayanController struct{}

func NewCreatePelayanController() *CreatePelayanController {
	return &CreatePelayanController{}
}

func (wc *CreatePelayanController) CreateWarta(c *gin.Context) {
	var pelayanCreate model.CreatePelayan
	err := c.Bind(&pelayanCreate)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat data pelayanCreate di database
	err = database.CreatePelayanKebaktian(pelayanCreate.IDJemaat, pelayanCreate.IDPelayananIbadah, pelayanCreate.IDPelayananIbadah, pelayanCreate.Keterangan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Warta created successfully!"})
}
