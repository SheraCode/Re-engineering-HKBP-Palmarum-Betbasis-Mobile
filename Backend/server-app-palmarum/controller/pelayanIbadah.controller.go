package controller

import (
	"fmt"
	"net/http"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"

	"github.com/gin-gonic/gin"
)

type PelayanIbadahController struct{}

func NewPelayanIbadahController() *PelayanIbadahController {
	return &PelayanIbadahController{}
}

func (jc *PelayanIbadahController) GetAllPelayan(c *gin.Context) {
	pelayanIbadah, err := database.GetPelayanIbadah()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pelayanIbadah)
}

func (kc *PelayanIbadahController) AddPelayanIbadah(c *gin.Context) {
	var pelayan model.PelayanIbadah
	err := c.BindJSON(&pelayan)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Check if the referenced id_pelayanan_ibadah exists
	exists, err := database.CheckPelayananIbadahExists(pelayan.IDPelayanan_IBADAH)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database error: " + err.Error()})
		return
	}
	if !exists {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid id_pelayanan_ibadah, it does not exist."})
		return
	}

	// Create the pelayan ibadah record in the database
	err = database.CreatePelayanIbadah(pelayan.IDJemaat, pelayan.IDPelayan, pelayan.IDPelayanan_IBADAH, pelayan.Keterangan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Database error: " + err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Data pelayan ibadah created successfully!"})
}

func (mc *PelayanIbadahController) DeletePelayanIbadahData(c *gin.Context) {
	// Ambil ID majelis dari parameter URL
	idParam := c.Param("id_pelayan_ibadah")
	idPelayan, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid majelis ID"})
		return
	}

	// Panggil fungsi DeleteMajelis dari controller untuk menghapus majelis
	err = database.DeletePelayanIbadah(idPelayan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete majelis"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": fmt.Sprintf("Majelis with ID %d deleted successfully", idPelayan)})
}
