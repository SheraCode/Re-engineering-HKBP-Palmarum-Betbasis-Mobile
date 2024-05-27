package controller

import (
	"io"
	"io/ioutil"
	"log"
	"mime/multipart"
	"net/http"
	"os"
	"path/filepath"
	"server-palmarum/database"
	"server-palmarum/model"
	"strconv"

	"github.com/gin-gonic/gin"
)

type KegiatanController struct{}

func NewKegiatanController() *KegiatanController {
	return &KegiatanController{}
}

func (jc *KegiatanController) GetAllKegiatan(c *gin.Context) {
	kegiatan, err := database.GetKegiatan()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, kegiatan)
}

func (jc *KegiatanController) GetKegiatanByID(c *gin.Context) {
	idStr := c.Param("id_waktu_kegiatan")
	id, err := strconv.Atoi(idStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid id"})
		return
	}

	kegiatan, err := database.GetKegiatanByID(id)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, kegiatan)
}

func (jc *KegiatanController) GetAllKegiatanUtama(c *gin.Context) {
	kegiatan, err := database.GetKegiatanHome()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, kegiatan)
}

const AssetBeritaDir = "./AssetBerita/"

func (kc *KegiatanController) CreateKegiatan(c *gin.Context) {
	var kegiatan model.WaktuKegiatan
	err := c.Bind(&kegiatan)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Menerima file gambar dari form multipart
	file, err := c.FormFile("image")
	if err != nil && err != http.ErrMissingFile {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Jika tidak ada file yang diunggah, kembalikan respons
	if file == nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "no image uploaded"})
		return
	}

	// Simpan gambar dengan nama asli
	imageURL, err := saveImageWithOriginalNameBerita(c, file)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Perbarui URL gambar kegiatan di data model
	kegiatan.KegiatanFoto = imageURL

	// Buat data kegiatan di database
	err = database.CreateKegiatan(kegiatan.IDJenisKegiatan, kegiatan.IDJemaat, kegiatan.NamaKegiatan, kegiatan.LokasiKegiatan, kegiatan.KegiatanFoto, kegiatan.Keterangan)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Kegiatan created successfully!"})
}

// Fungsi untuk menyimpan gambar dengan nama asli dan mengembalikan URL-nya
func saveImageWithOriginalNameBerita(c *gin.Context, file *multipart.FileHeader) (string, error) {
	// Mengenerate nama file baru dengan nama asli gambarnya
	fileName := file.Filename

	// Membuat folder AssetKegiatan jika belum ada
	folderPath := "./AssetKegiatan"
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

func (kc *KegiatanController) GetKegiatanImage(c *gin.Context) {
	kegiatanID := c.Param("id_waktu_kegiatan")

	// Dapatkan lokasi file gambar dari database berdasarkan ID kegiatan
	imageName := database.GetImageKegiatanNameFromDatabase(kegiatanID)
	if imageName == "" {
		c.JSON(http.StatusNotFound, gin.H{"error": "image not found"})
		return
	}

	// Bentuk path lengkap untuk file gambar
	imagePath := "./AssetKegiatan/" + imageName

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

func (kc *KegiatanController) GetKegiatanImageAll(c *gin.Context) {
	// Dapatkan lokasi file gambar dari database berdasarkan ID kegiatan
	imageNames := database.GetImageKegiatanHomeNameFromDatabase()
	if len(imageNames) == 0 {
		c.JSON(http.StatusNotFound, gin.H{"error": "images not found"})
		return
	}

	// Buat slice untuk menyimpan data gambar
	var images [][]byte

	// Iterasi melalui nama file gambar
	for _, imageName := range imageNames {
		// Bentuk path lengkap untuk file gambar
		imagePath := "./AssetKegiatan/" + imageName

		// Buka file gambar
		file, err := os.Open(imagePath)
		if err != nil {
			log.Printf("Error opening image file %s: %s\n", imageName, err)
			continue
		}
		defer file.Close()

		// Baca isi file gambar
		imageData, err := ioutil.ReadAll(file)
		if err != nil {
			log.Printf("Error reading image file %s: %s\n", imageName, err)
			continue
		}

		// Tambahkan data gambar ke slice images
		images = append(images, imageData)
	}

	// Set header respons untuk tipe konten gambar
	c.Header("Content-Type", "image/jpeg") // Sesuaikan dengan tipe gambar yang disimpan

	// Salin isi file gambar ke respons HTTP
	for _, imageData := range images {
		_, err := c.Writer.Write(imageData)
		if err != nil {
			log.Println("Error writing image data to response:", err)
			c.JSON(http.StatusInternalServerError, gin.H{"error": "internal server error"})
			return
		}
	}
}

func (kc *KegiatanController) UpdateKegiatan(c *gin.Context) {
	var kegiatan model.WaktuKegiatan

	// Bind form data to WaktuKegiatan struct
	if err := c.ShouldBind(&kegiatan); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Retrieve ID kegiatan from URL parameter
	idKegiatanStr := c.Param("id_waktu_kegiatan")
	idKegiatan, err := strconv.Atoi(idKegiatanStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "ID kegiatan harus berupa angka"})
		return
	}

	// Retrieve kegiatan berdasarkan ID
	kegiatan.IDWaktuKegiatan = idKegiatan

	// Retrieve foto kegiatan dari form-data (jika diunggah)
	file, err := c.FormFile("foto_kegiatan")
	if err == nil {
		// Jika ada foto kegiatan yang diunggah, simpan foto dengan nama unik
		kegiatan.KegiatanFoto, err = saveImageWithOriginalNameBerita(c, file)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			return
		}
	}

	// Panggil fungsi untuk melakukan update kegiatan di database
	if err := database.UpdateKegiatan(kegiatan); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Berhasil mengupdate kegiatan
	c.JSON(http.StatusOK, gin.H{"message": "Kegiatan berhasil diupdate!"})
}
