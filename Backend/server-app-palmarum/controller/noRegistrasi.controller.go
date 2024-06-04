package controller

import (
	"net/http"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"

	"github.com/gin-gonic/gin"
)

type noRegistrasiController struct{}

func NewnoRegistrasiController() *noRegistrasiController {
	return &noRegistrasiController{}
}

func (wc *noRegistrasiController) CreatenoReg(c *gin.Context) {
	var noRegKel model.NoRegKeluarga
	err := c.Bind(&noRegKel)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat data noRegKel di database
	err = database.CreateNoRegKel(noRegKel.NoKK, noRegKel.IDJemaat, noRegKel.NamaKepalaKeluarga)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Warta created successfully!"})
}

func (jc *noRegistrasiController) GetDataRegKeluarga(c *gin.Context) {
	noRegKeluarga, err := database.GetNoRegKeluarga()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, noRegKeluarga)
}

func (wc *noRegistrasiController) EditNoRegKel(c *gin.Context) {
	// Ambil ID warta dari parameter URL
	noRegID := c.Param("id")

	var w model.NoRegKeluarga
	if err := c.BindJSON(&w); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat instansi model.Warta baru untuk data yang akan diubah
	noRegkel := model.NoRegKeluarga{
		IDRegistrasi:       w.IDRegistrasi, // ID noRegkel yang akan diubah
		IDJemaat:           w.IDJemaat,
		NoKK:               w.NoKK,
		NamaKepalaKeluarga: w.NamaKepalaKeluarga,
	}

	err := database.UpdateNoRegKel(noRegID, noRegkel)

	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "No Registrasi berhasil diperbarui"})
}

func (jc *noRegistrasiController) GetNoRegById(c *gin.Context) {
	idNoRegStr := c.Param("id") // Assuming the ID is passed as a route parameter
	idNoReg, err := strconv.Atoi(idNoRegStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	noREGKEL, err := database.NoRegKelByID(idNoReg)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, noREGKEL)
}
