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
	"time"

	"github.com/dgrijalva/jwt-go"
	"github.com/gin-gonic/gin"
)

type JemaatController struct{}

func NewJemaatController() *JemaatController {
	return &JemaatController{}
}

func (jc *JemaatController) GetAllUlangTahunJemaat(c *gin.Context) {
	berulangTahun, err := database.GetJemaatBerulangTahun()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, berulangTahun)
}

func (jc *JemaatController) GetJemaatImage(c *gin.Context) {
	jemaatID := c.Param("id_jemaat")

	// Dapatkan lokasi file gambar dari database berdasarkan ID jemaat
	imageName := database.GetImageNameFromDatabase(jemaatID)
	if imageName == "" {
		c.JSON(http.StatusNotFound, gin.H{"error": "image not found"})
		return
	}

	// Bentuk path lengkap untuk file gambar
	imagePath := "./AssetJemaat/" + imageName

	// Buka file gambar
	file, err := os.Open(imagePath)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
	defer file.Close()

	// Set header respons untuk tipe konten gambar
	c.Header("Content-Type", "image/jpeg") // Ubah sesuai dengan tipe gambar yang Anda simpan

	// Salin isi file gambar ke respons HTTP
	_, err = io.Copy(c.Writer, file)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}
}

func (jc *JemaatController) UpdateJemaat(c *gin.Context) {
	jemaatID := c.Param("id_jemaat")
	var jemaat model.Jemaat
	if err := c.ShouldBindJSON(&jemaat); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Perbarui data jemaat di database
	if err := database.UpdateJemaat(jemaatID, jemaat); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Jemaat updated successfully!"})
}

func (jc *JemaatController) UpdateJemaatProfil(c *gin.Context) {
	jemaatIDStr := c.Param("id_jemaat")
	jemaatID, err := strconv.Atoi(jemaatIDStr)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid jemaat ID"})
		return
	}

	var jemaat model.Jemaat
	if err := c.ShouldBindJSON(&jemaat); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Perbarui data jemaat di database menggunakan stored procedure
	if err := database.UpdateJemaatProfileProcedure(jemaatID, jemaat.NamaDepan, jemaat.NamaBelakang, jemaat.TempatLahir, strconv.Itoa(jemaat.NoTelepon), jemaat.Alamat, jemaat.Email); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Jemaat updated successfully!"})
}

func (jc *JemaatController) UpdateJemaatImage(c *gin.Context) {
	jemaatID := c.Param("id_jemaat")

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
	imageURL, err := saveImageWithOriginalName(c, file)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	// Perbarui URL gambar jemaat di database
	if err := database.UpdateJemaatImageURL(jemaatID, imageURL); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Jemaat image updated successfully!"})
}

func saveImageWithOriginalName(c *gin.Context, file *multipart.FileHeader) (string, error) {
	// Mengenerate nama file baru dengan nama asli gambarnya
	fileName := file.Filename

	// Membuat folder AssetKegiatan jika belum ada
	folderPath := "./AssetJemaat"
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

// Tambahkan fungsi login pada struct JemaatController
// JemaatController Login function

func (jc *JemaatController) Login(c *gin.Context) {
	var requestBody struct {
		Email    string `json:"email"`
		Password string `json:"password"`
	}
	if err := c.ShouldBindJSON(&requestBody); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Panggil fungsi login dari database
	jemaat, err := database.Login(requestBody.Email, requestBody.Password)
	if err != nil {
		c.JSON(http.StatusUnauthorized, gin.H{"error": "Login failed: " + err.Error()})
		return
	}

	// Buat token JWT dengan menyimpan semua informasi pengguna dalam klaim
	token := jwt.NewWithClaims(jwt.SigningMethodHS256, jwt.MapClaims{
		"id_jemaat":                 jemaat.IDJemaat,
		"role_jemaat":               jemaat.RoleJemaat,
		"nama_depan":                jemaat.NamaDepan,
		"nama_belakang":             jemaat.NamaBelakang,
		"email":                     jemaat.Email,
		"password":                  jemaat.Password,
		"gelar_depan":               jemaat.GelarDepan,
		"gelar_belakang":            jemaat.GelarBelakang,
		"tempat_lahir":              jemaat.TempatLahir,
		"jenis_kelamin":             jemaat.JenisKelamin,
		"id_hub_keluarga":           jemaat.IDHubKeluarga,
		"id_status_pernikahan":      jemaat.IDStatusPernikahan,
		"id_status_ama_ina":         jemaat.IDStatusAmaIna,
		"id_status_anak":            jemaat.IDStatusAnak,
		"id_pendidikan":             jemaat.IDPendidikan,
		"id_bidang_pendidikan":      jemaat.IDBidangPendidikan,
		"bidang_pendidikan_lainnya": jemaat.BidangPendidikanLainnya,
		"id_pekerjaan":              jemaat.IDPekerjaan,
		"nama_pekerjaan_lainnya":    jemaat.NamaPekerjaanLainnya,
		"gol_darah":                 jemaat.GolDarah,
		"alamat":                    jemaat.Alamat,
		"isSidi":                    jemaat.IsSidi,
		"id_kecamatan":              jemaat.IDKecamatan,
		"no_telepon":                jemaat.NoTelepon,
		"no_hp":                     jemaat.NoTelepon,
		"foto_jemaat":               jemaat.FotoJemaat,
		"keterangan":                jemaat.Keterangan,
		"isBaptis":                  jemaat.IsBaptis,
		"isMenikah":                 jemaat.IsMenikah,
		"isMeninggal":               jemaat.IsMeninggal,
		"isRPP":                     jemaat.IsRPP,
		"create_at":                 jemaat.CreateAt,
		"update_at":                 jemaat.UpdateAt,
		"is_deleted":                jemaat.IsDeleted,
		"id_registrasi_keluarga":    jemaat.IDRegistrasiKeluarga,
		"exp":                       time.Now().Add(time.Hour * 24).Unix(),
	})

	// Tandatangani token dan kirimkan sebagai respons
	tokenString, err := token.SignedString([]byte("your-secret-key"))
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": "Failed to generate token"})
		return
	}

	// Kirim token sebagai respons
	c.JSON(http.StatusOK, gin.H{"token": tokenString})
}

// Middleware untuk memeriksa token JWT
func AuthMiddleware() gin.HandlerFunc {
	return func(c *gin.Context) {
		tokenString := c.GetHeader("Authorization")
		if tokenString == "" {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Unauthorized"})
			c.Abort()
			return
		}

		token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {
			return []byte("your-secret-key"), nil
		})
		if err != nil || !token.Valid {
			c.JSON(http.StatusUnauthorized, gin.H{"error": "Unauthorized"})
			c.Abort()
			return
		}

		c.Next()
	}
}

func (jc *JemaatController) GetJemaat(c *gin.Context) {
	var requestBody struct {
		IDJemaat int `json:"id_jemaat"`
	}
	if err := c.ShouldBindJSON(&requestBody); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	jemaat, err := database.GetJemaat(requestBody.IDJemaat)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, jemaat)
}

func (wc *JemaatController) CreateAccount(c *gin.Context) {
	var createAccount model.Jemaat
	err := c.Bind(&createAccount)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	// Buat data createAccount di database
	err = database.CreateAccountJemaat(createAccount.NamaDepan, createAccount.NamaBelakang, createAccount.IDRegistrasiKeluarga, createAccount.IDHubKeluarga)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Account created successfully!"})
}

func (wc *JemaatController) GetJemaatALl(c *gin.Context) {
	jemaatList, err := database.GetJemaatAllAccount()
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, jemaatList)
}

func (wc *JemaatController) GetJemaatByIDAccount(c *gin.Context) {
	idParam := c.Param("id")
	idJemaat, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	jemaat, err := database.GetJemaatByIDAccount(idJemaat)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	if jemaat == nil {
		c.JSON(http.StatusNotFound, gin.H{"error": "Jemaat not found"})
		return
	}

	c.JSON(http.StatusOK, jemaat)
}

func (wc *JemaatController) UpdateJemaatAccount(c *gin.Context) {
	idParam := c.Param("id")
	idJemaat, err := strconv.Atoi(idParam)
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid ID"})
		return
	}

	var updateData model.Jemaat
	if err := c.BindJSON(&updateData); err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
		return
	}

	if err := database.UpdateJemaatAccount(idJemaat, updateData.NamaDepan, updateData.NamaBelakang, updateData.IDRegistrasiKeluarga, updateData.IDHubKeluarga); err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, gin.H{"message": "Jemaat updated successfully!"})
}

func (jc *JemaatController) GetJemaatByRegistrasiKeluarga(c *gin.Context) {
	idRegistrasiKeluarga, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid id_registrasi_keluarga"})
		return
	}

	jemaats, err := database.GetJemaatByRegistrasiKeluarga(idRegistrasiKeluarga)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, jemaats)
}

func (jc *JemaatController) GetDataIsteri(c *gin.Context) {
	idRegistrasiKeluarga, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid id_registrasi_keluarga"})
		return
	}

	jemaats, err := database.GetDataIsteri(idRegistrasiKeluarga)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, jemaats)
}

func (jc *JemaatController) GetJemaatByRegistrasiKeluargaAndHubungan(c *gin.Context) {
	idRegistrasiKeluarga, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid id_registrasi_keluarga"})
		return
	}

	jemaats, err := database.GetJemaatByRegistrasiKeluargaAndHubungan(idRegistrasiKeluarga)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, jemaats)
}

func (jc *JemaatController) GetDataJemaatByIdREQ(c *gin.Context) {
	idJemaat, err := strconv.Atoi(c.Param("id"))
	if err != nil {
		c.JSON(http.StatusBadRequest, gin.H{"error": "Invalid id_jemaat"})
		return
	}

	jemaat, err := database.GetDataJemaatById(idJemaat)
	if err != nil {
		c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		return
	}

	c.JSON(http.StatusOK, jemaat)
}
