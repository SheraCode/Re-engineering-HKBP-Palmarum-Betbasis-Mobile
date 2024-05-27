package controller

import (
	"net/http"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"

	"github.com/gin-gonic/gin"
)

type pelayanChruchController struct{}

func NewpelayanChruchController() *pelayanChruchController {
	return &pelayanChruchController{}
}

func (wc *pelayanChruchController) CreatePelayanChruch(c *gin.Context) {
	var pelayan model.PelayanPalmarum
	err := c.Bind(&pelayan)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Create PelayanGereja data in the database
	err = database.CreatePelayan(pelayan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "PelayanGereja created successfully!"})
}

func (pcc *pelayanChruchController) UpdatePelayanChruch(c *gin.Context) {
	var pelayan model.PelayanPalmarum

	// Get the ID from the URL
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	// Bind the JSON data to the PelayanGereja struct
	err = c.Bind(&pelayan)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	pelayan.IdPelayan = id

	// Update PelayanGereja data in the database
	err = database.UpdatePelayan(pelayan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "PelayanGereja updated successfully!"})
}

func (pcc *pelayanChruchController) GetPelayanChruchByID(c *gin.Context) {
	// Get the ID from the URL
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	// Get PelayanGereja data from the database
	pelayan, err := database.GetPelayanByID(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	if pelayan.IdPelayan == 0 {
		c.JSON(http.StatusNotFound, gin.H{"message": "PelayanGereja not found"})
		return
	}

	c.JSON(http.StatusOK, pelayan)
}

func (pcc *pelayanChruchController) DeletePelayanChruchByID(c *gin.Context) {
	// Get the ID from the URL
	id, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	// Delete PelayanGereja data from the database
	err = database.DeletePelayanByID(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "PelayanGereja deleted successfully!"})
}
