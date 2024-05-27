package controller

import (
	"net/http"
	"server-palmarum/database"

	"github.com/gin-gonic/gin"
)

type pelayanMajelisController struct{}

func NewPelayanMajelisController() *pelayanMajelisController {
	return &pelayanMajelisController{}
}

func (pc *pelayanMajelisController) GetDataPelayanGereja(c *gin.Context) {
	pelayanMajelis, err := database.GetUntukMajelisPelayanGereja()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, pelayanMajelis)
}
