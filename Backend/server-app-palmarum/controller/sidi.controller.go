package controller

import (
	"fmt"
	"io/ioutil"
	"mime/multipart"
	"net/http"
	"os"
	"path/filepath"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
)

type SidiController struct{}

func NewSidiController() *SidiController {
	return &SidiController{}
}

func (sc *SidiController) GetRegistrasiSidi(c *gin.Context) {
	registrasiSidis, err := database.GetRegistrasiSidi()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	c.JSON(http.StatusOK, registrasiSidis)
}

func (sc *SidiController) GetAllRegistrasiSidiByIdJemaat(c *gin.Context) {
	jemaatID := c.Param("id") // Assuming the jemaat ID is passed as a parameter in the URL
	id, err := strconv.Atoi(jemaatID)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid jemaat ID"})
		return
	}

	registrasiSidis, err := database.GetAllRegistrasiSidiByIdJemaat(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Failed to get registrasi sidi: %v", err)})
		return
	}

	c.JSON(http.StatusOK, registrasiSidis)
}

func (bc *SidiController) DownloadSuratBaptisSidi(c *gin.Context) {
	idRegistrasiBaptisStr := c.Query("id_registrasi_sidi")
	idRegistrasiBaptis, err := strconv.Atoi(idRegistrasiBaptisStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "ID registrasi baptis tidak valid"})
		return
	}

	filePath, err := database.GetFileSuratSidiByID(idRegistrasiBaptis)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Gagal mendapatkan file surat baptis: %v", err)})
		return
	}

	// Membaca file PDF ke dalam byte slice
	fileData, err := ioutil.ReadFile(filePath)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Gagal membaca file surat baptis: %v", err)})
		return
	}

	// Mengirim file sebagai respons HTTP
	c.Data(http.StatusOK, "application/pdf", fileData)
}

func (sc *SidiController) CreateRegistrasiSidi(c *gin.Context) {
	// Ambil data dari request
	idJemaatStr := c.PostForm("id_jemaat")

	namaAyah := c.PostForm("nama_ayah")          //
	namaIbu := c.PostForm("nama_ibu")            //
	namaLengkap := c.PostForm("nama_lengkap")    //
	tempatLahir := c.PostForm("tempat_lahir")    //
	tanggalLahir := c.PostForm("tanggal_lahir")  //
	jenisKelamin := c.PostForm("jenis_kelamin")  //
	fileBaptis, err := c.FormFile("file_baptis") //
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "File baptis tidak ditemukan"})
		return
	}
	idHubKeluargaStr := c.PostForm("id_hub_keluarga") //
	idHubKeluarga, err := strconv.Atoi(idHubKeluargaStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "ID hubungan keluarga tidak valid"})
		return
	}
	idStatusStr := c.PostForm("id_status")
	idStatus, err := strconv.Atoi(idStatusStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "ID status tidak valid"})
		return
	}

	// Validasi ekstensi file baptis
	if !strings.HasSuffix(fileBaptis.Filename, ".pdf") {
		c.JSON(http.StatusBadRequest, gin.H{"error": "File harus berupa PDF"})
		return
	}

	// Simpan file baptis di folder baptis menggunakan fungsi saveUploadedFileSidi
	fileName, err := saveUploadedFileSidi(c, fileBaptis, "./suratSidi")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Gagal menyimpan file baptis"})
		return
	}

	// Update data registrasi sidi di database
	err = database.CreateRegistrasiSidi(idJemaatStr, namaAyah, namaIbu, namaLengkap, tempatLahir, tanggalLahir, jenisKelamin, fileName, idHubKeluarga, idStatus)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Gagal melakukan update registrasi sidi: %v", err)})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Registrasi sidi berhasil dibuat"})
}

func saveUploadedFileSidi(c *gin.Context, file *multipart.FileHeader, folderPath string) (string, error) {
	// Menggenerate nama file baru dengan nama asli gambarnya
	fileName := file.Filename

	// Membuat folder jika belum ada
	if _, err := os.Stat(folderPath); os.IsNotExist(err) {
		if err := os.Mkdir(folderPath, 0755); err != nil {
			return "", err
		}
	}

	// Menyimpan file gambar ke dalam folder dengan nama asli gambarnya
	filePath := filepath.Join(folderPath, fileName)
	if err := c.SaveUploadedFile(file, filePath); err != nil {
		return "", err
	}

	// Mengembalikan nama file gambar saja (tanpa path folder)
	return fileName, nil
}

func (sc *SidiController) UpdateRegistrasiSidi(c *gin.Context) {
	var request model.RegistrasiSidi
	if err := c.ShouldBindJSON(&request); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": fmt.Sprintf("Invalid request format: %v", err)})
		return
	}

	// Update data registrasi sidi di database
	err := database.UpdateRegistrasiSidiData(request.IDRegistrasiSidi, request.TanggalSidi, request.NatsSidi, request.NomorSuratSidi, request.NamaPendetaSidi, request.IDStatus)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Gagal melakukan update registrasi sidi: %v", err)})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Registrasi sidi berhasil diupdate"})
}

func (sc *SidiController) GetRegistrasiSidiById(c *gin.Context) {
	idStr := c.Param("id")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid registrasi sidi ID"})
		return
	}

	registrasiSidi, err := database.GetSidiById(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Failed to get registrasi sidi: %v", err)})
		return
	}

	c.JSON(http.StatusOK, registrasiSidi)
}
