package controller

import (
	"io"
	"mime/multipart"
	"net/http"
	"os"
	"path/filepath"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"

	"github.com/gin-gonic/gin"
)

type PemasukanController struct{}

func NewPemasukanController() *PemasukanController {
	return &PemasukanController{}
}

func (pc *PemasukanController) CreatePemasukan(c *gin.Context) {
	var pemasukan model.Pemasukan

	// Bind form data to Pemasukan struct
	if err := c.ShouldBind(&pemasukan); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Retrieve other form values
	idJemaatStr := c.PostForm("id_jemaat")
	idJemaat, err := strconv.Atoi(idJemaatStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id_kategori_pemasukan harus berupa angka"})
		return
	}
	tanggalPemasukan := c.PostForm("tanggal_pemasukan")
	totalPemasukanStr := c.PostForm("total_pemasukan")
	totalPemasukan, err := strconv.Atoi(totalPemasukanStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "total_pemasukan harus berupa angka"})
		return
	}

	bentukPemasukan := c.PostForm("bentuk_pemasukan")
	idKategoriPemasukanStr := c.PostForm("id_kategori_pemasukan")
	idKategoriPemasukan, err := strconv.Atoi(idKategoriPemasukanStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id_kategori_pemasukan harus berupa angka"})
		return
	}

	idBankStr := c.PostForm("id_bank")
	idBank, err := strconv.Atoi(idBankStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id_bank harus berupa angka"})
		return
	}

	// Menerima file bukti pemasukan dari form-data
	file, err := c.FormFile("bukti_pemasukan")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "tidak ada bukti_pemasukan yang diunggah"})
		return
	}

	// Simpan bukti pemasukan dengan nama unik
	buktiURL, err := saveUploadedFilePemasukan(c, file)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Set Pemasukan fields
	pemasukan.IDJemaat = idJemaat
	pemasukan.TanggalPemasukan = tanggalPemasukan
	pemasukan.TotalPemasukan = totalPemasukan
	pemasukan.BentukPemasukan = bentukPemasukan
	pemasukan.IDKategoriPemasukan = idKategoriPemasukan
	pemasukan.IDBank = idBank
	pemasukan.BuktiPemasukan = buktiURL

	// Call database function to create pemasukan using stored procedure
	if err := database.CreatePemasukan(pemasukan); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Pemasukan berhasil dibuat!"})
}

func saveUploadedFilePemasukan(c *gin.Context, file *multipart.FileHeader) (string, error) {
	// Mengenerate nama file baru dengan nama asli gambarnya
	fileName := file.Filename

	// Membuat folder AssetKegiatan jika belum ada
	folderPath := "./pemasukan"
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

func (jc *PemasukanController) GetPemasukanData(c *gin.Context) {
	Pemasukan, err := database.GetPemasukan()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, Pemasukan)
}

func (kc *PemasukanController) UpdatePemasukan(c *gin.Context) {
	var pemasukan model.Pemasukan

	// Bind form data to Pemasukan struct
	if err := c.ShouldBind(&pemasukan); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Retrieve other form values
	idPemasukanStr := c.PostForm("id_pemasukan")
	idPemasukan, err := strconv.Atoi(idPemasukanStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id_pemasukan harus berupa angka"})
		return
	}
	idJemaatStr := c.PostForm("id_jemaat")
	idJemaat, err := strconv.Atoi(idJemaatStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id_jemaat harus berupa angka"})
		return
	}

	jumlahPemasukanStr := c.PostForm("total_pemasukan")
	jumlahPemasukan, err := strconv.Atoi(jumlahPemasukanStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "total_pemasukan harus berupa angka"})
		return
	}

	idKategoriPemasukanStr := c.PostForm("id_kategori_pemasukan")
	idKategoriPemasukan, err := strconv.Atoi(idKategoriPemasukanStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id_kategori_pemasukan harus berupa angka"})
		return
	}

	idBankStr := c.PostForm("id_bank")
	idBank, err := strconv.Atoi(idBankStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "id_bank harus berupa angka"})
		return
	}

	// Retrieve tanggal pemasukan (gunakan c.PostForm untuk tipe data yang sesuai)
	tanggalPemasukan := c.PostForm("tanggal_pemasukan")

	// Retrieve bukti pemasukan dari form-data
	file, err := c.FormFile("bukti_pemasukan")
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "tidak ada bukti_pemasukan yang diunggah"})
		return
	}

	// Simpan bukti pemasukan dengan nama unik
	buktiURL, err := saveUploadedFilePemasukan(c, file)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Set nilai-nilai pemasukan
	pemasukan.IDPemasukan = idPemasukan
	pemasukan.IDJemaat = idJemaat
	pemasukan.TanggalPemasukan = tanggalPemasukan
	pemasukan.TotalPemasukan = jumlahPemasukan
	pemasukan.BentukPemasukan = c.PostForm("bentuk_pemasukan")
	pemasukan.IDKategoriPemasukan = idKategoriPemasukan
	pemasukan.BuktiPemasukan = buktiURL
	pemasukan.IDBank = idBank

	// Panggil fungsi untuk melakukan update pemasukan di database
	if err := database.UpdatePemasukan(pemasukan); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Berhasil mengupdate pemasukan
	c.JSON(http.StatusOK, gin.H{"message": "Pemasukan berhasil diupdate!"})
}

func (kc *PemasukanController) GetPemasukanByIDData(c *gin.Context) {
	// Mendapatkan id_pemasukan dari URL parameter
	idStr := c.Param("id_pemasukan")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "ID pemasukan harus berupa angka"})
		return
	}

	// Memanggil database function GetPengeluaranByID untuk mendapatkan data pemasukan
	pemasukan, err := database.GetPemasukanByID(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Mengembalikan response JSON berisi data pemasukan
	c.JSON(http.StatusOK, pemasukan)
}

func (kc *PemasukanController) GetImagePemasukanPemasukan(c *gin.Context) {
	kegiatanID := c.Param("id_pemasukan")

	// Dapatkan lokasi file gambar dari database berdasarkan ID kegiatan
	imageName := database.GetImagePemasukan(kegiatanID)
	if imageName == "" {
		c.JSON(http.StatusNotFound, gin.H{"error": "image not found"})
		return
	}

	// Bentuk path lengkap untuk file gambar
	imagePath := "./pemasukan/" + imageName

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
