package controller

import (
	"io"
	"math"
	"mime/multipart"
	"net/http"
	"os"
	"path/filepath"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"

	"github.com/gin-gonic/gin"
)

type PengeluaranController struct{}

func NewPengeluaranController() *PengeluaranController {
	return &PengeluaranController{}
}

func (kc *PengeluaranController) CreatePengeluaran(c *gin.Context) {
	var pengeluaran model.Pengeluaran

	// Bind form data to Pengeluaran struct
	if err := c.ShouldBind(&pengeluaran); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Retrieve jumlah_pengeluaran
	idJemaatStr := c.PostForm("id_jemaat")
	idJemaat, err := strconv.Atoi(idJemaatStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id_jemaat harus berupa angka"})
		return
	}
	jumlahPengeluaranStr := c.PostForm("jumlah_pengeluaran")
	jumlahPengeluaran, err := strconv.Atoi(jumlahPengeluaranStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "jumlah_pengeluaran harus berupa angka"})
		return
	}

	// Retrieve other form values
	tanggalPengeluaran := c.PostForm("tanggal_pengeluaran")
	keteranganPengeluaran := c.PostForm("keterangan_pengeluaran")
	idKategoriPengeluaranStr := c.PostForm("id_kategori_pengeluaran")
	idKategoriPengeluaran, err := strconv.Atoi(idKategoriPengeluaranStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id_kategori_pengeluaran harus berupa angka"})
		return
	}

	idBankStr := c.PostForm("id_bank")
	idBank, err := strconv.Atoi(idBankStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id_bank harus berupa angka"})
		return
	}

	// Menerima file bukti pengeluaran dari form-data
	file, err := c.FormFile("bukti_pengeluaran")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "tidak ada bukti_pengeluaran yang diunggah"})
		return
	}

	// Simpan bukti pengeluaran dengan nama unik
	buktiURL, err := saveUploadedFile(c, file)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Set pengeluaran fields
	pengeluaran.IDJemaat = idJemaat
	pengeluaran.JumlahPengeluaran = jumlahPengeluaran
	pengeluaran.TanggalPengeluaran = tanggalPengeluaran
	pengeluaran.KeteranganPengeluaran = keteranganPengeluaran
	pengeluaran.IDKategoriPengeluaran = idKategoriPengeluaran
	pengeluaran.IDBank = idBank
	pengeluaran.BuktiPengeluaran = buktiURL

	// Call database function to create pengeluaran
	if err := database.CreatePengeluaran(pengeluaran); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Pengeluaran berhasil dibuat!"})
}

// Fungsi untuk menyimpan file yang diunggah dengan nama unik
func saveUploadedFile(c *gin.Context, file *multipart.FileHeader) (string, error) {
	// Mengenerate nama file baru dengan nama asli gambarnya
	fileName := file.Filename

	// Membuat folder AssetKegiatan jika belum ada
	folderPath := "./pengeluaran"
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

func (jc *PengeluaranController) GetPengeluaranData(c *gin.Context) {
	Pengeluaran, err := database.GetPengeluaran()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, Pengeluaran)
}

func (kc *PengeluaranController) UpdatePengeluaran(c *gin.Context) {
	var pengeluaran model.Pengeluaran

	// Bind form data to Pengeluaran struct
	if err := c.ShouldBind(&pengeluaran); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Retrieve jumlah_pengeluaran
	idJemaatStr := c.PostForm("id_jemaat")
	idJemaat, err := strconv.Atoi(idJemaatStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id_jemaat harus berupa angka"})
		return
	}
	jumlahPengeluaranStr := c.PostForm("jumlah_pengeluaran")
	jumlahPengeluaran, err := strconv.Atoi(jumlahPengeluaranStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "jumlah_pengeluaran harus berupa angka"})
		return
	}

	// Pastikan nilai jumlahPengeluaran valid untuk tipe data INT
	if jumlahPengeluaran < math.MinInt32 || jumlahPengeluaran > math.MaxInt32 {
		c.JSON(http.StatusBadRequest, gin.H{"error": "nilai jumlah_pengeluaran terlalu besar"})
		return
	}

	// Retrieve other form values
	tanggalPengeluaran := c.PostForm("tanggal_pengeluaran")
	idPengeluaranStr := c.PostForm("id_pengeluaran")
	idPengeluaran, err := strconv.Atoi(idPengeluaranStr)
	keteranganPengeluaran := c.PostForm("keterangan_pengeluaran")
	idKategoriPengeluaranStr := c.PostForm("id_kategori_pengeluaran")
	idKategoriPengeluaran, err := strconv.Atoi(idKategoriPengeluaranStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id_kategori_pengeluaran harus berupa angka"})
		return
	}

	idBankStr := c.PostForm("id_bank")
	idBank, err := strconv.Atoi(idBankStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id_bank harus berupa angka"})
		return
	}

	// Menerima file bukti pengeluaran dari form-data
	file, err := c.FormFile("bukti_pengeluaran")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "tidak ada bukti_pengeluaran yang diunggah"})
		return
	}

	// Simpan bukti pengeluaran dengan nama unik
	buktiURL, err := saveUploadedFile(c, file)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Set pengeluaran fields
	pengeluaran.IDPengeluaran = idPengeluaran
	pengeluaran.IDJemaat = idJemaat
	pengeluaran.JumlahPengeluaran = jumlahPengeluaran
	pengeluaran.TanggalPengeluaran = tanggalPengeluaran
	pengeluaran.KeteranganPengeluaran = keteranganPengeluaran
	pengeluaran.IDKategoriPengeluaran = idKategoriPengeluaran
	pengeluaran.IDBank = idBank
	pengeluaran.BuktiPengeluaran = buktiURL

	// Call database function to create pengeluaran
	if err := database.UpdatePengeluaran(pengeluaran); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Pengeluaran berhasil diupdate!"})
}

func (kc *PengeluaranController) GetPengeluaranByID(c *gin.Context) {
	// Mendapatkan id_pengeluaran dari URL parameter
	idStr := c.Param("id_pengeluaran")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "ID pengeluaran harus berupa angka"})
		return
	}

	// Memanggil database function GetPengeluaranByID untuk mendapatkan data pengeluaran
	pengeluaran, err := database.GetPengeluaranByID(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Mengembalikan response JSON berisi data pengeluaran
	c.JSON(http.StatusOK, pengeluaran)
}

func (kc *PengeluaranController) GetImagePengeluaranPengeluaran(c *gin.Context) {
	kegiatanID := c.Param("id_pengeluaran")

	// Dapatkan lokasi file gambar dari database berdasarkan ID kegiatan
	imageName := database.GetImagePengeluaran(kegiatanID)
	if imageName == "" {
		c.JSON(http.StatusNotFound, gin.H{"error": "image not found"})
		return
	}

	// Bentuk path lengkap untuk file gambar
	imagePath := "./pengeluaran/" + imageName

	// Buka file gambar
	file, err := os.Open(imagePath)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	defer file.Close()

	// Set header respons untuk tipe konten gambar
	c.Header("Content-Type", "image/jpeg") // Sesuaikan dengan tipe gambar yang disimpan

	// Salin isi file gambar ke respons HTTP
	_, err = io.Copy(c.Writer, file)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
}
