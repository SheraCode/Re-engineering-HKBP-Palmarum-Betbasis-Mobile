package router

import (
	"server-palmarum/controller"

	"github.com/gin-gonic/gin"
)

func SetupRouter() *gin.Engine {
	r := gin.Default()

	jemaatController := controller.NewJemaatController()
	beritaController := controller.NewKegiatanController()
	WartaController := controller.NewWartaController()
	PelayanGerejaController := controller.NewPelayanGerejaController()
	PelayanIbadahController := controller.NewPelayanIbadahController()
	PelayananIbadahALLController := controller.NewPelayanGerejaALLController()
	JadwalIbadah := controller.NewJadwalIbadahController()
	SejarahGereja := controller.NewSejarahGerejaController()
	Pengeluaran := controller.NewPengeluaranController()
	Pemasukan := controller.NewPemasukanController()
	Baptis := controller.NewBaptisController()
	Majelis := controller.NewMajelisController()
	Sidi := controller.NewSidiController()
	PelayanMajelis := controller.NewPelayanMajelisController()
	PelayanChurch := controller.NewpelayanChruchController()
	PernikahanController := controller.NewPernikahanController()
	PelayanCreateController := controller.NewCreatePelayanController()
	RegistrasiKeluarga := controller.NewnoRegistrasiController()

	// Endpoint untuk membuat jemaat baru
	// r.POST("/jemaat", jemaatController.CreateJemaat)

	// Endpoint untuk memperbarui data jemaat dengan gambar
	r.PUT("/jemaat/:id_jemaat", jemaatController.UpdateJemaat)

	// Endpoint untuk GetAllKegiatan
	r.GET("/berita", beritaController.GetAllKegiatan)

	// Endpoint untuk GetAllKegiatanByID
	r.GET("/berita/:id_waktu_kegiatan", beritaController.GetKegiatanByID)

	// Endpoint untuk edit Berita
	r.PUT("/berita/:id_waktu_kegiatan", beritaController.UpdateKegiatan)

	// Endpoint untuk GetAllKegiatanHome
	r.GET("/berita/home", beritaController.GetAllKegiatanUtama)

	// Endpoint untuk Create Kegiatan
	r.POST("/berita/create", beritaController.CreateKegiatan)

	// Endpoint untuk memperbarui data jemaat di profil
	r.PUT("/jemaat/profil/:id_jemaat", jemaatController.UpdateJemaatProfil)

	// Endpoint untuk mendapatkan data jemaat berdasarkan id yang dikirimkan melalui raw body JSON
	r.POST("/jemaat", jemaatController.GetJemaat)

	// Endpoint untuk mengupdate gambar jemaat
	r.POST("/jemaat/:id_jemaat/image", jemaatController.UpdateJemaatImage)

	// Endpoint untuk mengambil gambar jemaat
	r.GET("/jemaat/:id_jemaat/image", jemaatController.GetJemaatImage)

	// Endpoint untuk mengambil gambar kegiatan
	r.GET("/kegiatan/:id_waktu_kegiatan/image", beritaController.GetKegiatanImage)

	// Endpoint untuk mengambil semua gambar yang ada
	r.GET("/kegiatan/image", beritaController.GetKegiatanImageAll)

	r.POST("/jemaat/login", jemaatController.Login)

	// Enpoint untuk mengambil semua warta
	r.GET("/warta", WartaController.GetDataWarta)

	// Enpoint untuk mengambil warta home (limit 5 terakhir terbaru)
	r.GET("/warta/home", WartaController.GetDataWartaHome)

	// Endpoint untuk create data warta
	r.POST("/warta/create", WartaController.CreateWarta)

	// Endpoint untuk mengambil warta berdasarkan id tertentu
	r.GET("/warta/:id_warta", WartaController.GetDataWartaByID)

	// Endpoint untuk mengambil Data PelayanGereja
	r.GET("/pelayan-gereja", PelayanGerejaController.GetDataPelayanGereja)

	// Endpoint untuk mengambil Data Pelayan Ibadah
	r.GET("/pelayan-ibadah", PelayanIbadahController.GetAllPelayan)

	// Endpoint untuk mengambil semua data Pelayanan Ibadah
	r.GET("/pelayanan-ibadah-all", PelayananIbadahALLController.GetDataPelayanGereja)

	// Endpoint untuk mengedit data pelayanan ibadah dengan ID tertentu
	r.PUT("/pelayanan_ibadah/:id", PelayananIbadahALLController.EditDataPelayanGereja)

	// Endpoint untuk menampilkan semua data Jadwal Ibadah
	r.GET("/jadwal-ibadah", JadwalIbadah.GetAllJadwalIbadah)

	// Endpoint untuk mengedit data Jadwal Ibadah BYID
	r.PUT("/jadwal-ibadah/:id", JadwalIbadah.EditDataJadwalIbadah)

	// Endpoint untuk create data pelayan_ibadah
	r.POST("/pelayan-ibadah/create", PelayanIbadahController.AddPelayanIbadah)

	// Endpoint untuk create data pelayanan ibadah
	r.POST("/pelayanan-ibadah/create", PelayananIbadahALLController.CreatePelayanIbadah)

	// Endpoint untuk mengedit data pelayan gereja
	r.PUT("/pelayan-gereja/:id", PelayanGerejaController.EditDataPelayanGereja)

	// Endpoint untuk mengambil data sejarah
	r.GET("/sejarah-gereja", SejarahGereja.GetDataSejarah)

	// Endpoint untuk mengedit data sejarah gereja
	r.PUT("/sejarah-gereja/:id", SejarahGereja.UpdateSejarahGereja)

	// Endpoint untuk mengambil data jemaat berulang tahun
	r.GET("/jemaat/berulang-tahun", jemaatController.GetAllUlangTahunJemaat)

	// Endpoint untuk create Kegiatan
	r.POST("/pengeluaran/create", Pengeluaran.CreatePengeluaran)

	// Endpoint untuk mengambil data Pengeluaran
	r.GET("/pengeluaran", Pengeluaran.GetPengeluaranData)

	// Endpoint untuk mengedit data Pengeluaran
	r.PUT("/pengeluaran", Pengeluaran.UpdatePengeluaran)

	// Endpoint untuk mengambil data Pengeluaran berdasarkan ID
	r.GET("/pengeluaran/:id_pengeluaran", Pengeluaran.GetPengeluaranByID)

	// Endpoint untuk create Kegiatan
	r.POST("/pemasukan/create", Pemasukan.CreatePemasukan)

	// Endpoint untuk mengambil data Pemasukan
	r.GET("/pemasukan", Pemasukan.GetPemasukanData)

	// Endpoint untuk mengedit data Pemasukan
	r.PUT("/pemasukan", Pemasukan.UpdatePemasukan)

	// Endpoint untuk mengambil data Pengeluaran berdasarkan ID
	r.GET("/pemasukan/:id_pemasukan", Pemasukan.GetPemasukanByIDData)

	// Endpoint untuk create Baptis
	r.POST("/baptis/create", Baptis.CreateBaptis)

	// Endpoint untuk mengedit data Baptis
	r.PUT("/baptis", Baptis.UpdateRegistrasiBaptis)

	// Endpoint untuk mendapatkan data registrasi baptis berdasarkan ID
	r.GET("/registrasi-baptis/:id", Baptis.GetRegistrasiBaptisByID)

	// Endpoint untuk create Sidi
	r.POST("/sidi/create", Sidi.CreateRegistrasiSidi)

	// Endpoint untuk update warta
	r.PUT("/warta/edit/:id", WartaController.EditWarta)

	// Endpoint untuk image pemasukan berdasarkan ID
	r.GET("/pemasukan/image/:id_pemasukan", Pemasukan.GetImagePemasukanPemasukan)

	// Endpoint untuk image pengeluaran berdasarkan ID
	r.GET("/pengeluaran/image/:id_pengeluaran", Pengeluaran.GetImagePengeluaranPengeluaran)

	// Endpoint untuk jadwal ibadah create
	r.POST("/jadwal-ibadah/create", JadwalIbadah.AddJadwalIbadah)

	// Endpoint untuk GetJadwal-IbadahBYID
	r.GET("/jadwal-ibadah/:id", JadwalIbadah.GetJadwalIbadahByIDHandler)

	// Endpoint untuk GetNamaPelayan
	r.GET("/pelayanan-ibadah/:id", PelayananIbadahALLController.GetPelayananGerejaByIDHandler)

	// Endpoint untuk create majelis
	r.POST("/majelis/create", Majelis.CreatePelayanGereja)

	// Endpoint untuk Get Role Jemaat
	r.GET("/role-jemaat", Majelis.GetJemaatRole)

	// Endpoint untuk Get pelayan Majelis
	r.GET("/pelayan-majelis", PelayanMajelis.GetDataPelayanGereja)

	// Endpoint untuk edit majelis
	r.PUT("/majelis/edit/:id", Majelis.EditMajelis)

	// Endpoint untuk BY majelis
	r.GET("/majelis-gereja/:id_majelis", Majelis.GetMajelisByIDHandler)

	// Endpoint untuk delete majelis
	r.DELETE("/majelis/:id_majelis", Majelis.DeleteMajelisByIDHandler)

	// Endpoint untuk create pelayan church
	r.POST("/pelayan/create", PelayanChurch.CreatePelayanChruch)

	// Endpoint untuk edit pelayan
	r.PUT("/pelayan/edit/:id", PelayanChurch.UpdatePelayanChruch)

	// Endpoint untuk get BYID pelayan church
	r.GET("/pelayan/:id", PelayanChurch.GetPelayanChruchByID)

	// Delete PelayanGereja by ID
	r.DELETE("/pelayan-gereja/:id", PelayanChurch.DeletePelayanChruchByID)

	// GetALL BAPTIS
	r.GET("/registrasi-baptis", Baptis.GetAllRegistrasiBaptis)

	// GET BY ID JEMAAT Baptis
	r.GET("/baptis/:id_jemaat", Baptis.GetRegistrasiBaptisByIdJemaat)

	// Endpoint Download File Baptis
	r.GET("/download/baptis", Baptis.DownloadSuratBaptis)

	// Endpoint untuk GET ALL Sidi
	r.GET("/sidi/all", Sidi.GetRegistrasiSidi)

	// Endpoint untuk Get ALL Sidi By Jemaat
	r.GET("/sidi/jemaat/:id", Sidi.GetAllRegistrasiSidiByIdJemaat)

	// Endpoint untuk Update Sidi untuk Majelis
	r.POST("/sidi/update", Sidi.UpdateRegistrasiSidi)

	// Endpoint Download File Baptis
	r.GET("/download/sidi", Sidi.DownloadSuratBaptisSidi)

	// Endpoint untuk GetSidiById
	r.GET("/sidi/byid/:id", Sidi.GetRegistrasiSidiById)

	// Endpoint untuk Create Pernikahan
	r.POST("/pernikahan/create", PernikahanController.CreatePernikahan)

	// Endpoint untuk Get By Id Pernikahan
	r.GET("/pernikahan/:id", PernikahanController.GetPernikahanById)

	// Endpoint untuk Get All Pernikahan
	r.GET("/pernikahan/all", PernikahanController.GetAllPernikahan)

	// Endpoint untuk Get All Pernikahan By Id Jemaat
	r.GET("/pernikahan/jemaat/:id_jemaat", PernikahanController.GetPernikahanByJemaat)

	// Endpoint untuk Update Status Pernikahan
	r.PUT("/pernikahan/update/:id_registrasi_nikah", PernikahanController.UpdateStatusPernikahanByIdRegistrasiNikah)

	// Endpoint untuk DELETE Pelayan Kebaktian Gereja
	r.DELETE("/pelayan-kebaktian/delete/:id_pelayan_ibadah", PelayanIbadahController.DeletePelayanIbadahData)

	// Endpoint untuk Create Pelayan Ibadah Data
	r.POST("/pelayan-kebaktian/create", PelayanCreateController.CreateWarta)

	// Endpoint untuk Create Registras_keluarga
	r.POST("/registrasi-keluarga/create", RegistrasiKeluarga.CreatenoReg)

	// Endpoint untuk Get All Data Keluarga
	r.GET("/registrasi-keluarga", RegistrasiKeluarga.GetDataRegKeluarga)

	// Endpoint untuk Update No Reg Kel
	r.PUT("/registrasi-keluarga/update/:id", RegistrasiKeluarga.EditNoRegKel)

	// Endpoint untuk Get By Id Data Keluarga
	r.GET("/registrasi-keluarga/:id", RegistrasiKeluarga.GetNoRegById)

	// Endpoint untuk create Registrasi Account Jemaat
	r.POST("/jemaat/create/account", jemaatController.CreateAccount)

	// Endpoint untuk Get All Data Jemaat Account
	r.GET("/jemaat/account", jemaatController.GetJemaatALl)

	// Endpoint untuk Get Jemaat ACcount by id
	r.GET("/jemaat/account/:id", jemaatController.GetJemaatByIDAccount)

	// Endpoint untuk Update Jemaat Account
	r.PUT("/jemaat/account/edit/:id", jemaatController.UpdateJemaatAccount)

	// Endpoint untuk Get Data Kepala keluarga
	r.GET("/jemaat/kepala-keluarga/:id", jemaatController.GetJemaatByRegistrasiKeluarga)

	// Endpoint untuk Get Data Isteri
	r.GET("/jemaat/isteri-keluarga/:id", jemaatController.GetDataIsteri)

	// Endpoint untuk Get Data Anak
	r.GET("/jemaat/anak-keluarga/:id", jemaatController.GetJemaatByRegistrasiKeluargaAndHubungan)

	// Endpoint untuk Get Data Anak Lengkap
	r.GET("/jemaat-all/anak-keluarga/:id", jemaatController.GetDataJemaatByIdREQ)

	return r
}
