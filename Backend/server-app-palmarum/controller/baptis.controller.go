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

type BaptisController struct{}

func NewBaptisController() *BaptisController {
	return &BaptisController{}
}

func (bc *BaptisController) CreateBaptis(c *gin.Context) {
	var baptis model.Baptis
	if err := c.BindJSON(&baptis); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Memanggil database function untuk membuat data baptis
	err := database.CreateBaptis(
		baptis.IDJemaat,
		baptis.NamaAyah,    //
		baptis.NamaIbu,     //
		baptis.NamaLengkap, //
		baptis.TempatLahir,
		baptis.TanggalLahir, //
		baptis.JenisKelamin, //
		baptis.IDHubKeluarga,
	)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Baptis created successfully!"})
}

func (bc *BaptisController) UpdateRegistrasiBaptis(c *gin.Context) {
	// Ambil data dari request
	idRegistrasiBaptis, err := strconv.Atoi(c.PostForm("id_registasi_baptis"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "ID registrasi baptis tidak valid"})
		return
	}
	noSuratBaptis := c.PostForm("no_surat_baptis")
	namaPendetaBaptis := c.PostForm("nama_pendeta_baptis")
	fileSuratBaptis, err := c.FormFile("file_surat_baptis")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "File surat baptis tidak ditemukan"})
		return
	}
	tanggalBaptis := c.PostForm("tanggal_baptis")
	idStatusStr := c.PostForm("id_status")
	idStatus, err := strconv.Atoi(idStatusStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "ID status tidak valid"})
		return
	}

	// Validasi ekstensi file surat baptis
	if !strings.HasSuffix(fileSuratBaptis.Filename, ".pdf") {
		c.JSON(http.StatusBadRequest, gin.H{"error": "File harus berupa PDF"})
		return
	}

	// Simpan file surat baptis di folder suratBaptis menggunakan fungsi saveUploadedFile
	fileName, err := saveUploadedFileBaptis(c, fileSuratBaptis, "./suratBaptis")
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Gagal menyimpan file surat baptis"})
		return
	}

	// Hanya gunakan nama file tanpa path untuk penyimpanan di database
	// Update data registrasi baptis di database
	err = database.UpdateRegistrasiBaptisData(idRegistrasiBaptis, noSuratBaptis, namaPendetaBaptis, fileName, tanggalBaptis, idStatus)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Gagal melakukan update registrasi baptis: %v", err)})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Registrasi baptis berhasil diupdate"})
}

// Fungsi untuk menyimpan file yang diunggah dengan nama unik
// Fungsi untuk menyimpan file yang diunggah dengan nama unik
func saveUploadedFileBaptis(c *gin.Context, file *multipart.FileHeader, folderPath string) (string, error) {
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

// GetRegistrasiBaptisByID mengambil data registrasi baptis berdasarkan ID
func (rc *BaptisController) GetRegistrasiBaptisByID(c *gin.Context) {
	// Mendapatkan id_registrasi_baptis dari URL
	idStr := c.Param("id")
	idRegistrasiBaptis, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "ID registrasi baptis tidak valid"})
		return
	}

	// Panggil fungsi db untuk mengambil data registrasi baptis
	registrasiBaptis, err := database.GetRegistrasiBaptisByID(idRegistrasiBaptis)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Gagal mengambil data registrasi baptis: %v", err)})
		return
	}

	// Mengembalikan data registrasi baptis dalam format JSON
	c.JSON(http.StatusOK, registrasiBaptis)
}

func (bc *BaptisController) GetAllRegistrasiBaptis(c *gin.Context) {
	baptisList, err := database.GetAllRegistrasiBaptis()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, baptisList)
}

func (bc *BaptisController) GetRegistrasiBaptisByIdJemaat(c *gin.Context) {
	// Get id_jemaat from URL
	idStr := c.Param("id_jemaat")
	jemaatID, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid jemaat ID"})
		return
	}

	// Call database function to get registrasi baptis by id_jemaat
	baptisList, err := database.GetRegistrasiBaptisByIdJemaat(jemaatID)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": fmt.Sprintf("Failed to get registrasi baptis: %v", err)})
		return
	}

	// Return registrasi baptis data in JSON format
	c.JSON(http.StatusOK, baptisList)
}

func (bc *BaptisController) DownloadSuratBaptis(c *gin.Context) {
	idRegistrasiBaptisStr := c.Query("id_registrasi_baptis")
	idRegistrasiBaptis, err := strconv.Atoi(idRegistrasiBaptisStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "ID registrasi baptis tidak valid"})
		return
	}

	filePath, err := database.GetFileSuratBaptisByID(idRegistrasiBaptis)
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
