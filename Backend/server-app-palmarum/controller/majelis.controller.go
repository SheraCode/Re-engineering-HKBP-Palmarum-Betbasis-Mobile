package controller

import (
	"fmt"
	"net/http"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"

	"github.com/gin-gonic/gin"
)

type MajelisController struct{}

func NewMajelisController() *MajelisController {
	return &MajelisController{}
}

func (kc *MajelisController) CreatePelayanGereja(c *gin.Context) {
	var majelis model.Majelis
	err := c.Bind(&majelis)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat data majelis gereja di database
	err = database.CreateMajelis(majelis)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Data majelis gereja created successfully!"})
}

func (jc *MajelisController) GetJemaatRole(c *gin.Context) {
	rolejemaat, err := database.GetRoleJemaat()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, rolejemaat)
}

func (mc *MajelisController) EditMajelis(c *gin.Context) {
	majelisID := c.Param("id")

	var majelis model.Majelis
	if err := c.BindJSON(&majelis); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Pastikan IDMajelis adalah nilai yang diambil dari URL dan bukan dari body JSON
	id, err := strconv.Atoi(majelisID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}
	majelis.IDMajelis = id

	err = database.UpdateMajelis(majelisID, majelis)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Data majelis berhasil diperbarui"})
}

func (mc *MajelisController) GetMajelisByIDHandler(c *gin.Context) {
	// Ambil ID majelis dari parameter URL
	idParam := c.Param("id_majelis")
	idMajelis, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid majelis ID"})
		return
	}

	// Panggil fungsi GetMajelisByID dari database untuk mendapatkan data majelis
	majelis, err := database.GetMajelisByID(idMajelis)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	if len(majelis) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "Majelis not found"})
		return
	}

	// Mengembalikan data majelis pertama dalam respons JSON (diasumsikan hanya satu hasil yang diharapkan)
	c.JSON(http.StatusOK, majelis[0])
}

func (mc *MajelisController) DeleteMajelisByIDHandler(c *gin.Context) {
	// Ambil ID majelis dari parameter URL
	idParam := c.Param("id_majelis")
	idMajelis, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid majelis ID"})
		return
	}

	// Panggil fungsi DeleteMajelis dari controller untuk menghapus majelis
	err = database.DeleteMajelis(idMajelis)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to delete majelis"})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": fmt.Sprintf("Majelis with ID %d deleted successfully", idMajelis)})
}
