/*
 Navicat Premium Dump SQL

 Source Server         : Localhost
 Source Server Type    : MariaDB
 Source Server Version : 110502 (11.5.2-MariaDB)
 Source Host           : localhost:3306
 Source Schema         : sppd_bawaslu

 Target Server Type    : MariaDB
 Target Server Version : 110502 (11.5.2-MariaDB)
 File Encoding         : 65001

 Date: 21/09/2026 13:43:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cache
-- ----------------------------
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint(20) NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  INDEX `cache_expiration_index`(`expiration` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache
-- ----------------------------

-- ----------------------------
-- Table structure for cache_locks
-- ----------------------------
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks`  (
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint(20) NOT NULL,
  PRIMARY KEY (`key`) USING BTREE,
  INDEX `cache_locks_expiration_index`(`expiration` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cache_locks
-- ----------------------------

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `failed_jobs_uuid_unique`(`uuid` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for job_batches
-- ----------------------------
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `cancelled_at` int(11) NULL DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of job_batches
-- ----------------------------

-- ----------------------------
-- Table structure for jobs
-- ----------------------------
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED NULL DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `jobs_queue_index`(`queue` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of jobs
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES (1, '0001_01_01_000000_create_users_table', 1);
INSERT INTO `migrations` VALUES (2, '0001_01_01_000001_create_cache_table', 1);
INSERT INTO `migrations` VALUES (3, '0001_01_01_000002_create_jobs_table', 1);
INSERT INTO `migrations` VALUES (4, '2026_09_16_000001_add_role_id_and_avatar_to_users_table', 1);
INSERT INTO `migrations` VALUES (5, '2026_09_16_000002_create_roles_table', 1);
INSERT INTO `migrations` VALUES (6, '2026_09_16_000003_create_ref_menu_table', 1);
INSERT INTO `migrations` VALUES (7, '2026_09_16_000004_create_role_permissions_table', 1);
INSERT INTO `migrations` VALUES (8, '2026_09_16_000005_create_settings_table', 1);
INSERT INTO `migrations` VALUES (9, '2026_09_16_000006_create_ref_provinsi_table', 1);
INSERT INTO `migrations` VALUES (10, '2026_09_16_000007_create_ref_tarif_harian_table', 1);
INSERT INTO `migrations` VALUES (11, '2026_09_16_000008_create_ref_tarif_penginapan_table', 1);
INSERT INTO `migrations` VALUES (12, '2026_09_16_000009_create_ref_tarif_pesawat_table', 1);
INSERT INTO `migrations` VALUES (13, '2026_09_16_000010_create_ref_tarif_transport_darat_table', 1);
INSERT INTO `migrations` VALUES (14, '2026_09_16_000011_create_ref_tarif_transport_provinsi_table', 1);
INSERT INTO `migrations` VALUES (15, '2026_09_16_000012_create_ref_pegawai_table', 1);
INSERT INTO `migrations` VALUES (16, '2026_09_16_000013_create_tb_sppd_table', 1);
INSERT INTO `migrations` VALUES (17, '2026_09_16_000014_create_tb_sppd_rincian_table', 1);
INSERT INTO `migrations` VALUES (18, '2026_09_16_000015_add_avatar_to_ref_pegawai_table', 2);
INSERT INTO `migrations` VALUES (19, '2026_09_16_000016_add_tipe_to_ref_pegawai_table', 3);
INSERT INTO `migrations` VALUES (20, '2026_09_17_000001_add_transport_fields_to_tb_sppd_table', 4);
INSERT INTO `migrations` VALUES (21, '2026_09_17_000002_add_uang_saku_to_tb_sppd_table', 5);
INSERT INTO `migrations` VALUES (22, '2026_09_17_000003_drop_uang_saku_from_tb_sppd_table', 6);
INSERT INTO `migrations` VALUES (23, '2026_09_17_000004_add_bukti_to_tb_sppd_rincian_table', 7);
INSERT INTO `migrations` VALUES (24, '2026_09_17_000005_add_dokumen_to_tb_sppd_table', 8);
INSERT INTO `migrations` VALUES (25, '2026_09_18_000001_add_transport_kendaraan_dinas_pp_to_tb_sppd_table', 9);
INSERT INTO `migrations` VALUES (26, '2026_09_18_000002_add_tahun_to_tb_sppd_and_tb_sppd_rincian_tables', 10);
INSERT INTO `migrations` VALUES (27, '2026_09_18_000003_add_tahun_settings_to_settings_table', 10);
INSERT INTO `migrations` VALUES (28, '2026_09_21_000001_add_jenis_sppd_to_tb_sppd_table', 11);

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens`  (
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------

-- ----------------------------
-- Table structure for ref_menu
-- ----------------------------
DROP TABLE IF EXISTS `ref_menu`;
CREATE TABLE `ref_menu`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ref_menu_parent_id_foreign`(`parent_id` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 18 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_menu
-- ----------------------------
INSERT INTO `ref_menu` VALUES (1, NULL, 'Referensi', 'FolderIcon', NULL, 2, 1);
INSERT INTO `ref_menu` VALUES (2, NULL, 'SPPD', 'DocsIcon', NULL, 3, 1);
INSERT INTO `ref_menu` VALUES (4, NULL, 'Pengaturan', 'SettingsIcon', NULL, 5, 1);
INSERT INTO `ref_menu` VALUES (5, NULL, 'Dashboard', 'LayoutDashboardIcon', '/dashboard', 1, 1);
INSERT INTO `ref_menu` VALUES (6, 2, 'Laporan', NULL, '/sppd/laporan', 2, 1);
INSERT INTO `ref_menu` VALUES (7, 2, 'Daftar SPPD', NULL, '/sppd', 1, 1);
INSERT INTO `ref_menu` VALUES (8, 1, 'Data Tarif', NULL, '/admin/referensi', 2, 1);
INSERT INTO `ref_menu` VALUES (13, 1, 'Data Pegawai', NULL, '/admin/master/pegawai', 1, 1);
INSERT INTO `ref_menu` VALUES (14, 4, 'Users', NULL, '/users', 1, 1);
INSERT INTO `ref_menu` VALUES (15, 4, 'Roles', NULL, '/roles', 2, 1);
INSERT INTO `ref_menu` VALUES (16, 4, 'Menus', NULL, '/menus', 3, 1);
INSERT INTO `ref_menu` VALUES (17, NULL, 'Pengaturan Sistem', 'SupportIcon', '/admin/system', 5, 1);

-- ----------------------------
-- Table structure for ref_pegawai
-- ----------------------------
DROP TABLE IF EXISTS `ref_pegawai`;
CREATE TABLE `ref_pegawai`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nama_pegawai` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `pangkat_golongan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `jabatan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tipe` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pegawai',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_pegawai
-- ----------------------------
INSERT INTO `ref_pegawai` VALUES (1, 'Fauzi, S.H., M.H.', '197501012000031001', 'Pembina Tk. I / IV-b', 'Ketua Bawaslu Kab. Pidie', 'pegawai', NULL);
INSERT INTO `ref_pegawai` VALUES (2, 'Cut Nurul Husna, S.T.', '198103152004122002', 'Pembina / IV-a', 'Anggota Bawaslu Kab. Pidie', 'pegawai', 'avatars/E1xTu3jG3bC7VEHW6Ak0TpBRdWPFfBkmexa7XOyN.png');
INSERT INTO `ref_pegawai` VALUES (3, 'Teuku Ilhamsyah, S.IP.', '198506122009011003', 'Penata Tk. I / III-d', 'Sekretaris Bawaslu Kab. Pidie', 'pegawai', NULL);
INSERT INTO `ref_pegawai` VALUES (4, 'Rahmad Hidayat, S.E.', '199002032014031004', 'Penata Muda Tk. I / III-b', 'Bendahara Pengeluaran', 'pegawai', NULL);
INSERT INTO `ref_pegawai` VALUES (5, 'Muliadi, S.Kom.', '199304182019031006', 'Pengatur / II-c', 'Staf Sekretariat', 'pegawai', NULL);

-- ----------------------------
-- Table structure for ref_provinsi
-- ----------------------------
DROP TABLE IF EXISTS `ref_provinsi`;
CREATE TABLE `ref_provinsi`  (
  `id_provinsi` int(11) NOT NULL AUTO_INCREMENT,
  `nama_provinsi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ibukota` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_provinsi`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_provinsi
-- ----------------------------
INSERT INTO `ref_provinsi` VALUES (1, 'ACEH', 'Banda Aceh');
INSERT INTO `ref_provinsi` VALUES (2, 'SUMATRA UTARA', 'Medan');
INSERT INTO `ref_provinsi` VALUES (3, 'R I A U', 'Pekanbaru');
INSERT INTO `ref_provinsi` VALUES (4, 'KEPULAUAN RIAU', 'Tanjung Pinang');
INSERT INTO `ref_provinsi` VALUES (5, 'J A M B I', 'Jambi');
INSERT INTO `ref_provinsi` VALUES (6, 'SUMATRA BARAT', 'Padang');
INSERT INTO `ref_provinsi` VALUES (7, 'SUMATRA SELATAN', 'Palembang');
INSERT INTO `ref_provinsi` VALUES (8, 'LAMPUNG', 'Bandar Lampung');
INSERT INTO `ref_provinsi` VALUES (9, 'BENGKULU', 'Bengkulu');
INSERT INTO `ref_provinsi` VALUES (10, 'BANGKA BELITUNG', 'Pangkal Pinang');
INSERT INTO `ref_provinsi` VALUES (11, 'B A N T E N', 'Serang');
INSERT INTO `ref_provinsi` VALUES (12, 'JAWA BARAT', 'Bandung');
INSERT INTO `ref_provinsi` VALUES (13, 'D.K.I. JAKARTA', 'Jakarta');
INSERT INTO `ref_provinsi` VALUES (14, 'JAWA TENGAH', 'Semarang');
INSERT INTO `ref_provinsi` VALUES (15, 'D.I. YOGYAKARTA', 'Yogyakarta');
INSERT INTO `ref_provinsi` VALUES (16, 'JAWA TIMUR', 'Surabaya');
INSERT INTO `ref_provinsi` VALUES (17, 'B A L I', 'Denpasar');
INSERT INTO `ref_provinsi` VALUES (18, 'NUSA TENGGARA BARAT', 'Mataram');
INSERT INTO `ref_provinsi` VALUES (19, 'NUSA TENGGARA TIMUR', 'Kupang');
INSERT INTO `ref_provinsi` VALUES (20, 'KALIMANTAN BARAT', 'Pontianak');
INSERT INTO `ref_provinsi` VALUES (21, 'KALIMANTAN TENGAH', 'Palangkaraya');
INSERT INTO `ref_provinsi` VALUES (22, 'KALIMANTAN SELATAN', 'Banjarmasin');
INSERT INTO `ref_provinsi` VALUES (23, 'KALIMANTAN TIMUR', 'Samarinda');
INSERT INTO `ref_provinsi` VALUES (24, 'KALIMANTAN UTARA', 'Tanjung Selor');
INSERT INTO `ref_provinsi` VALUES (25, 'SULAWESI UTARA', 'Manado');
INSERT INTO `ref_provinsi` VALUES (26, 'GORONTALO', 'Gorontalo');
INSERT INTO `ref_provinsi` VALUES (27, 'SULAWESI BARAT', 'Mamuju');
INSERT INTO `ref_provinsi` VALUES (28, 'SULAWESI SELATAN', 'Makassar');
INSERT INTO `ref_provinsi` VALUES (29, 'SULAWESI TENGAH', 'Palu');
INSERT INTO `ref_provinsi` VALUES (30, 'SULAWESI TENGGARA', 'Kendari');
INSERT INTO `ref_provinsi` VALUES (31, 'MALUKU', 'Ambon');
INSERT INTO `ref_provinsi` VALUES (32, 'MALUKU UTARA', 'Sofifi');
INSERT INTO `ref_provinsi` VALUES (33, 'P A P U A', 'Jayapura');
INSERT INTO `ref_provinsi` VALUES (34, 'PAPUA BARAT', 'Manokwari');
INSERT INTO `ref_provinsi` VALUES (35, 'PAPUA BARAT DAYA', 'Sorong');
INSERT INTO `ref_provinsi` VALUES (36, 'PAPUA TENGAH', 'Nabire');
INSERT INTO `ref_provinsi` VALUES (37, 'PAPUA SELATAN', 'Merauke');
INSERT INTO `ref_provinsi` VALUES (38, 'PAPUA PEGUNUNGAN', 'Wamena');

-- ----------------------------
-- Table structure for ref_tarif_harian
-- ----------------------------
DROP TABLE IF EXISTS `ref_tarif_harian`;
CREATE TABLE `ref_tarif_harian`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_provinsi` int(11) NOT NULL,
  `luar_kota` int(11) NOT NULL DEFAULT 0,
  `dalam_kota_lebih_8_jam` int(11) NOT NULL DEFAULT 0,
  `diklat` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ref_tarif_harian_id_provinsi_foreign`(`id_provinsi` ASC) USING BTREE,
  CONSTRAINT `ref_tarif_harian_id_provinsi_foreign` FOREIGN KEY (`id_provinsi`) REFERENCES `ref_provinsi` (`id_provinsi`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_tarif_harian
-- ----------------------------
INSERT INTO `ref_tarif_harian` VALUES (1, 1, 360000, 140000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (2, 2, 370000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (3, 3, 370000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (4, 4, 370000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (5, 5, 370000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (6, 6, 380000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (7, 7, 380000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (8, 8, 380000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (9, 9, 380000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (10, 10, 410000, 160000, 120000);
INSERT INTO `ref_tarif_harian` VALUES (11, 11, 370000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (12, 12, 430000, 170000, 130000);
INSERT INTO `ref_tarif_harian` VALUES (13, 13, 530000, 210000, 160000);
INSERT INTO `ref_tarif_harian` VALUES (14, 14, 370000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (15, 15, 420000, 170000, 130000);
INSERT INTO `ref_tarif_harian` VALUES (16, 16, 410000, 160000, 120000);
INSERT INTO `ref_tarif_harian` VALUES (17, 17, 480000, 190000, 140000);
INSERT INTO `ref_tarif_harian` VALUES (18, 18, 440000, 180000, 130000);
INSERT INTO `ref_tarif_harian` VALUES (19, 19, 430000, 170000, 130000);
INSERT INTO `ref_tarif_harian` VALUES (20, 20, 380000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (21, 21, 360000, 140000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (22, 22, 380000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (23, 23, 430000, 170000, 130000);
INSERT INTO `ref_tarif_harian` VALUES (24, 24, 430000, 170000, 130000);
INSERT INTO `ref_tarif_harian` VALUES (25, 25, 370000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (26, 26, 370000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (27, 27, 410000, 160000, 120000);
INSERT INTO `ref_tarif_harian` VALUES (28, 28, 430000, 170000, 130000);
INSERT INTO `ref_tarif_harian` VALUES (29, 29, 370000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (30, 30, 380000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (31, 31, 380000, 150000, 110000);
INSERT INTO `ref_tarif_harian` VALUES (32, 32, 430000, 170000, 130000);
INSERT INTO `ref_tarif_harian` VALUES (33, 33, 580000, 230000, 170000);
INSERT INTO `ref_tarif_harian` VALUES (34, 34, 480000, 190000, 140000);
INSERT INTO `ref_tarif_harian` VALUES (35, 35, 480000, 190000, 140000);
INSERT INTO `ref_tarif_harian` VALUES (36, 36, 580000, 230000, 170000);
INSERT INTO `ref_tarif_harian` VALUES (37, 37, 580000, 230000, 170000);
INSERT INTO `ref_tarif_harian` VALUES (38, 38, 580000, 230000, 170000);

-- ----------------------------
-- Table structure for ref_tarif_penginapan
-- ----------------------------
DROP TABLE IF EXISTS `ref_tarif_penginapan`;
CREATE TABLE `ref_tarif_penginapan`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_provinsi` int(11) NOT NULL,
  `pejabat_negara_eselon_1` int(11) NOT NULL DEFAULT 0,
  `pejabat_lainnya_eselon_2` int(11) NOT NULL DEFAULT 0,
  `eselon_3_gol_4` int(11) NOT NULL DEFAULT 0,
  `eselon_4_gol_3_2_1` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ref_tarif_penginapan_id_provinsi_foreign`(`id_provinsi` ASC) USING BTREE,
  CONSTRAINT `ref_tarif_penginapan_id_provinsi_foreign` FOREIGN KEY (`id_provinsi`) REFERENCES `ref_provinsi` (`id_provinsi`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_tarif_penginapan
-- ----------------------------
INSERT INTO `ref_tarif_penginapan` VALUES (1, 1, 5109000, 3526000, 1578000, 770000);
INSERT INTO `ref_tarif_penginapan` VALUES (2, 2, 4960000, 2195000, 1188000, 699000);
INSERT INTO `ref_tarif_penginapan` VALUES (3, 3, 3820000, 3119000, 1650000, 852000);
INSERT INTO `ref_tarif_penginapan` VALUES (4, 4, 6177000, 2481000, 1388000, 792000);
INSERT INTO `ref_tarif_penginapan` VALUES (5, 5, 5004000, 4102000, 1252000, 580000);
INSERT INTO `ref_tarif_penginapan` VALUES (6, 6, 5603000, 3373000, 1353000, 701000);
INSERT INTO `ref_tarif_penginapan` VALUES (7, 7, 6298000, 3134000, 1966000, 861000);
INSERT INTO `ref_tarif_penginapan` VALUES (8, 8, 4806000, 2663000, 1539000, 621000);
INSERT INTO `ref_tarif_penginapan` VALUES (9, 9, 2140000, 1628000, 1546000, 692000);
INSERT INTO `ref_tarif_penginapan` VALUES (10, 10, 4424000, 2838000, 1957000, 724000);
INSERT INTO `ref_tarif_penginapan` VALUES (11, 11, 5725000, 2373000, 1301000, 775000);
INSERT INTO `ref_tarif_penginapan` VALUES (12, 12, 5812000, 2755000, 1366000, 735000);
INSERT INTO `ref_tarif_penginapan` VALUES (13, 13, 9331000, 2084000, 1062000, 730000);
INSERT INTO `ref_tarif_penginapan` VALUES (14, 14, 6129000, 2138000, 1286000, 810000);
INSERT INTO `ref_tarif_penginapan` VALUES (15, 15, 5100000, 2695000, 1600000, 845000);
INSERT INTO `ref_tarif_penginapan` VALUES (16, 16, 4449000, 2007000, 1234000, 814000);
INSERT INTO `ref_tarif_penginapan` VALUES (17, 17, 7328000, 2433000, 1754000, 1138000);
INSERT INTO `ref_tarif_penginapan` VALUES (18, 18, 4682000, 2648000, 1418000, 907000);
INSERT INTO `ref_tarif_penginapan` VALUES (19, 19, 4013000, 2283000, 1450000, 737000);
INSERT INTO `ref_tarif_penginapan` VALUES (20, 20, 2654000, 1923000, 1125000, 576000);
INSERT INTO `ref_tarif_penginapan` VALUES (21, 21, 4901000, 3391000, 1189000, 706000);
INSERT INTO `ref_tarif_penginapan` VALUES (22, 22, 4797000, 3316000, 1500000, 746000);
INSERT INTO `ref_tarif_penginapan` VALUES (23, 23, 4000000, 2342000, 1507000, 804000);
INSERT INTO `ref_tarif_penginapan` VALUES (24, 24, 4000000, 2854000, 1507000, 904000);
INSERT INTO `ref_tarif_penginapan` VALUES (25, 25, 5264000, 2290000, 1270000, 978000);
INSERT INTO `ref_tarif_penginapan` VALUES (26, 26, 4168000, 3107000, 1606000, 955000);
INSERT INTO `ref_tarif_penginapan` VALUES (27, 27, 4076000, 3098000, 1344000, 704000);
INSERT INTO `ref_tarif_penginapan` VALUES (28, 28, 4820000, 1938000, 1423000, 745000);
INSERT INTO `ref_tarif_penginapan` VALUES (29, 29, 2309000, 2166000, 1679000, 951000);
INSERT INTO `ref_tarif_penginapan` VALUES (30, 30, 3089000, 2755000, 1297000, 786000);
INSERT INTO `ref_tarif_penginapan` VALUES (31, 31, 3467000, 3240000, 1059000, 667000);
INSERT INTO `ref_tarif_penginapan` VALUES (32, 32, 4612000, 3843000, 1160000, 654000);
INSERT INTO `ref_tarif_penginapan` VALUES (33, 33, 3859000, 3318000, 2521000, 1038000);
INSERT INTO `ref_tarif_penginapan` VALUES (34, 34, 3872000, 3575000, 2056000, 967000);
INSERT INTO `ref_tarif_penginapan` VALUES (35, 35, 3872000, 3575000, 2056000, 967000);
INSERT INTO `ref_tarif_penginapan` VALUES (36, 36, 3859000, 3318000, 2521000, 1038000);
INSERT INTO `ref_tarif_penginapan` VALUES (37, 37, 5673000, 4877000, 3706000, 1526000);
INSERT INTO `ref_tarif_penginapan` VALUES (38, 38, 5711000, 4911000, 3731000, 1536000);

-- ----------------------------
-- Table structure for ref_tarif_pesawat
-- ----------------------------
DROP TABLE IF EXISTS `ref_tarif_pesawat`;
CREATE TABLE `ref_tarif_pesawat`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `kota_asal` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kota_tujuan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tarif_bisnis` int(11) NOT NULL DEFAULT 0,
  `tarif_ekonomi` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 317 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_tarif_pesawat
-- ----------------------------
INSERT INTO `ref_tarif_pesawat` VALUES (1, 'JAKARTA', 'AMBON', 13285000, 7081000);
INSERT INTO `ref_tarif_pesawat` VALUES (2, 'JAKARTA', 'BALIKPAPAN', 7412000, 3797000);
INSERT INTO `ref_tarif_pesawat` VALUES (3, 'JAKARTA', 'BANDA ACEH', 7519000, 4807000);
INSERT INTO `ref_tarif_pesawat` VALUES (4, 'JAKARTA', 'BANDAR LAMPUNG', 2407000, 1583000);
INSERT INTO `ref_tarif_pesawat` VALUES (5, 'JAKARTA', 'BANJARMASIN', 5252000, 3205000);
INSERT INTO `ref_tarif_pesawat` VALUES (6, 'JAKARTA', 'BATAM', 4867000, 3091000);
INSERT INTO `ref_tarif_pesawat` VALUES (7, 'JAKARTA', 'BENGKULU', 4364000, 2770000);
INSERT INTO `ref_tarif_pesawat` VALUES (8, 'JAKARTA', 'BIAK', 14065000, 8046000);
INSERT INTO `ref_tarif_pesawat` VALUES (9, 'JAKARTA', 'DENPASAR', 5305000, 3262000);
INSERT INTO `ref_tarif_pesawat` VALUES (10, 'JAKARTA', 'GORONTALO', 7231000, 5162000);
INSERT INTO `ref_tarif_pesawat` VALUES (11, 'JAKARTA', 'JAMBI', 4065000, 2584000);
INSERT INTO `ref_tarif_pesawat` VALUES (12, 'JAKARTA', 'JAYAPURA', 14568000, 8767000);
INSERT INTO `ref_tarif_pesawat` VALUES (13, 'JAKARTA', 'YOGYAKARTA', 4107000, 2268000);
INSERT INTO `ref_tarif_pesawat` VALUES (14, 'JAKARTA', 'KENDARI', 7658000, 4265000);
INSERT INTO `ref_tarif_pesawat` VALUES (15, 'JAKARTA', 'KUPANG', 9413000, 5081000);
INSERT INTO `ref_tarif_pesawat` VALUES (16, 'JAKARTA', 'MAKASSAR', 7444000, 3829000);
INSERT INTO `ref_tarif_pesawat` VALUES (17, 'JAKARTA', 'MALANG', 4599000, 2695000);
INSERT INTO `ref_tarif_pesawat` VALUES (18, 'JAKARTA', 'MAMUJU', 7295000, 5208000);
INSERT INTO `ref_tarif_pesawat` VALUES (19, 'JAKARTA', 'MANADO', 10824000, 5460000);
INSERT INTO `ref_tarif_pesawat` VALUES (20, 'JAKARTA', 'MANOKWARI', 16226000, 10824000);
INSERT INTO `ref_tarif_pesawat` VALUES (21, 'JAKARTA', 'MATARAM', 5316000, 3230000);
INSERT INTO `ref_tarif_pesawat` VALUES (22, 'JAKARTA', 'MEDAN', 7252000, 4054000);
INSERT INTO `ref_tarif_pesawat` VALUES (23, 'JAKARTA', 'PADANG', 5530000, 3159000);
INSERT INTO `ref_tarif_pesawat` VALUES (24, 'JAKARTA', 'PALANGKARAYA', 4984000, 2984000);
INSERT INTO `ref_tarif_pesawat` VALUES (25, 'JAKARTA', 'PALEMBANG', 3861000, 2268000);
INSERT INTO `ref_tarif_pesawat` VALUES (26, 'JAKARTA', 'PALU', 9348000, 5113000);
INSERT INTO `ref_tarif_pesawat` VALUES (27, 'JAKARTA', 'PANGKAL PINANG', 3412000, 2139000);
INSERT INTO `ref_tarif_pesawat` VALUES (28, 'JAKARTA', 'PEKANBARU', 5583000, 3016000);
INSERT INTO `ref_tarif_pesawat` VALUES (29, 'JAKARTA', 'PONTIANAK', 4353000, 2781000);
INSERT INTO `ref_tarif_pesawat` VALUES (30, 'JAKARTA', 'SEMARANG', 3861000, 2182000);
INSERT INTO `ref_tarif_pesawat` VALUES (31, 'JAKARTA', 'SOLO', 3861000, 2342000);
INSERT INTO `ref_tarif_pesawat` VALUES (32, 'JAKARTA', 'SURABAYA', 5466000, 2674000);
INSERT INTO `ref_tarif_pesawat` VALUES (33, 'JAKARTA', 'TERNATE', 10001000, 6664000);
INSERT INTO `ref_tarif_pesawat` VALUES (34, 'JAKARTA', 'TIMIKA', 13830000, 7902000);
INSERT INTO `ref_tarif_pesawat` VALUES (35, 'JAKARTA', 'TANJUNG SELOR', 7424000, 4341000);
INSERT INTO `ref_tarif_pesawat` VALUES (36, 'AMBON', 'DENPASAR', 8054000, 4784000);
INSERT INTO `ref_tarif_pesawat` VALUES (37, 'AMBON', 'JAYAPURA', 7434000, 4453000);
INSERT INTO `ref_tarif_pesawat` VALUES (38, 'AMBON', 'KENDARI', 4824000, 3056000);
INSERT INTO `ref_tarif_pesawat` VALUES (39, 'AMBON', 'MAKASSAR', 6022000, 3697000);
INSERT INTO `ref_tarif_pesawat` VALUES (40, 'AMBON', 'MANOKWARI', 5177000, 3239000);
INSERT INTO `ref_tarif_pesawat` VALUES (41, 'AMBON', 'PALU', 6140000, 3754000);
INSERT INTO `ref_tarif_pesawat` VALUES (42, 'AMBON', 'SORONG', 3637000, 2415000);
INSERT INTO `ref_tarif_pesawat` VALUES (43, 'AMBON', 'SURABAYA', 8803000, 5185000);
INSERT INTO `ref_tarif_pesawat` VALUES (44, 'AMBON', 'TERNATE', 4022000, 2621000);
INSERT INTO `ref_tarif_pesawat` VALUES (45, 'BALIKPAPAN', 'BANDA ACEH', 12739000, 7222000);
INSERT INTO `ref_tarif_pesawat` VALUES (46, 'BALIKPAPAN', 'BATAM', 10354000, 5677000);
INSERT INTO `ref_tarif_pesawat` VALUES (47, 'BALIKPAPAN', 'DENPASAR', 10739000, 6044000);
INSERT INTO `ref_tarif_pesawat` VALUES (48, 'BALIKPAPAN', 'JAYAPURA', 19071000, 10793000);
INSERT INTO `ref_tarif_pesawat` VALUES (49, 'BALIKPAPAN', 'YOGYAKARTA', 9669000, 5082000);
INSERT INTO `ref_tarif_pesawat` VALUES (50, 'BALIKPAPAN', 'MAKASSAR', 12664000, 6581000);
INSERT INTO `ref_tarif_pesawat` VALUES (51, 'BALIKPAPAN', 'MANADO', 15702000, 7806000);
INSERT INTO `ref_tarif_pesawat` VALUES (52, 'BALIKPAPAN', 'MEDAN', 12493000, 6570000);
INSERT INTO `ref_tarif_pesawat` VALUES (53, 'BALIKPAPAN', 'PADANG', 10942000, 5745000);
INSERT INTO `ref_tarif_pesawat` VALUES (54, 'BALIKPAPAN', 'PALEMBANG', 9445000, 5082000);
INSERT INTO `ref_tarif_pesawat` VALUES (55, 'BALIKPAPAN', 'PEKANBARU', 10996000, 5803000);
INSERT INTO `ref_tarif_pesawat` VALUES (56, 'BALIKPAPAN', 'SEMARANG', 9445000, 5002000);
INSERT INTO `ref_tarif_pesawat` VALUES (57, 'BALIKPAPAN', 'SOLO', 9445000, 5150000);
INSERT INTO `ref_tarif_pesawat` VALUES (58, 'BALIKPAPAN', 'SURABAYA', 10889000, 5471000);
INSERT INTO `ref_tarif_pesawat` VALUES (59, 'BALIKPAPAN', 'TIMIKA', 18408000, 10107000);
INSERT INTO `ref_tarif_pesawat` VALUES (60, 'BANDA ACEH', 'DENPASAR', 10835000, 6719000);
INSERT INTO `ref_tarif_pesawat` VALUES (61, 'BANDA ACEH', 'JAYAPURA', 19167000, 11468000);
INSERT INTO `ref_tarif_pesawat` VALUES (62, 'BANDA ACEH', 'YOGYAKARTA', 9765000, 5757000);
INSERT INTO `ref_tarif_pesawat` VALUES (63, 'BANDA ACEH', 'MAKASSAR', 12760000, 7256000);
INSERT INTO `ref_tarif_pesawat` VALUES (64, 'BANDA ACEH', 'MANADO', 15798000, 8481000);
INSERT INTO `ref_tarif_pesawat` VALUES (65, 'BANDA ACEH', 'PONTIANAK', 9990000, 6249000);
INSERT INTO `ref_tarif_pesawat` VALUES (66, 'BANDA ACEH', 'SEMARANG', 9530000, 5677000);
INSERT INTO `ref_tarif_pesawat` VALUES (67, 'BANDA ACEH', 'SOLO', 9530000, 5826000);
INSERT INTO `ref_tarif_pesawat` VALUES (68, 'BANDA ACEH', 'SURABAYA', 10985000, 6147000);
INSERT INTO `ref_tarif_pesawat` VALUES (69, 'BANDA ACEH', 'TIMIKA', 18504000, 10782000);
INSERT INTO `ref_tarif_pesawat` VALUES (70, 'BANDAR LAMPUNG', 'BALIKPAPAN', 8129000, 4419000);
INSERT INTO `ref_tarif_pesawat` VALUES (71, 'BANDAR LAMPUNG', 'BANDA ACEH', 8225000, 5094000);
INSERT INTO `ref_tarif_pesawat` VALUES (72, 'BANDAR LAMPUNG', 'BANJARMASIN', 6193000, 3651000);
INSERT INTO `ref_tarif_pesawat` VALUES (73, 'BANDAR LAMPUNG', 'BATAM', 5840000, 3549000);
INSERT INTO `ref_tarif_pesawat` VALUES (74, 'BANDAR LAMPUNG', 'BIAK', 14119000, 8012000);
INSERT INTO `ref_tarif_pesawat` VALUES (75, 'BANDAR LAMPUNG', 'DENPASAR', 6236000, 3903000);
INSERT INTO `ref_tarif_pesawat` VALUES (76, 'BANDAR LAMPUNG', 'JAYAPURA', 14568000, 8664000);
INSERT INTO `ref_tarif_pesawat` VALUES (77, 'BANDAR LAMPUNG', 'YOGYAKARTA', 5155000, 2954000);
INSERT INTO `ref_tarif_pesawat` VALUES (78, 'BANDAR LAMPUNG', 'KENDARI', 8354000, 4796000);
INSERT INTO `ref_tarif_pesawat` VALUES (79, 'BANDAR LAMPUNG', 'MAKASSAR', 8161000, 4453000);
INSERT INTO `ref_tarif_pesawat` VALUES (80, 'BANDAR LAMPUNG', 'MALANG', 5594000, 3354000);
INSERT INTO `ref_tarif_pesawat` VALUES (81, 'BANDAR LAMPUNG', 'MANADO', 11199000, 5677000);
INSERT INTO `ref_tarif_pesawat` VALUES (82, 'BANDAR LAMPUNG', 'MATARAM', 6246000, 3880000);
INSERT INTO `ref_tarif_pesawat` VALUES (83, 'BANDAR LAMPUNG', 'MEDAN', 7979000, 4441000);
INSERT INTO `ref_tarif_pesawat` VALUES (84, 'BANDAR LAMPUNG', 'PADANG', 6439000, 3617000);
INSERT INTO `ref_tarif_pesawat` VALUES (85, 'BANDAR LAMPUNG', 'PALANGKARAYA', 5947000, 3640000);
INSERT INTO `ref_tarif_pesawat` VALUES (86, 'BANDAR LAMPUNG', 'PALEMBANG', 4931000, 2954000);
INSERT INTO `ref_tarif_pesawat` VALUES (87, 'BANDAR LAMPUNG', 'PEKANBARU', 6482000, 3674000);
INSERT INTO `ref_tarif_pesawat` VALUES (88, 'BANDAR LAMPUNG', 'PONTIANAK', 5380000, 3446000);
INSERT INTO `ref_tarif_pesawat` VALUES (89, 'BANDAR LAMPUNG', 'SEMARANG', 4931000, 2873000);
INSERT INTO `ref_tarif_pesawat` VALUES (90, 'BANDAR LAMPUNG', 'SOLO', 4931000, 3022000);
INSERT INTO `ref_tarif_pesawat` VALUES (91, 'BANDAR LAMPUNG', 'SURABAYA', 6386000, 3342000);
INSERT INTO `ref_tarif_pesawat` VALUES (92, 'BANDAR LAMPUNG', 'TIMIKA', 13905000, 7977000);
INSERT INTO `ref_tarif_pesawat` VALUES (93, 'BANDUNG', 'BATAM', 6289000, 3583000);
INSERT INTO `ref_tarif_pesawat` VALUES (94, 'BANDUNG', 'DENPASAR', 5626000, 3252000);
INSERT INTO `ref_tarif_pesawat` VALUES (95, 'BANDUNG', 'JAMBI', 5006000, 2941000);
INSERT INTO `ref_tarif_pesawat` VALUES (96, 'BANDUNG', 'YOGYAKARTA', 3369000, 2279000);
INSERT INTO `ref_tarif_pesawat` VALUES (97, 'BANDUNG', 'PADANG', 6129000, 3508000);
INSERT INTO `ref_tarif_pesawat` VALUES (98, 'BANDUNG', 'PALEMBANG', 4385000, 2631000);
INSERT INTO `ref_tarif_pesawat` VALUES (99, 'BANDUNG', 'PANGKAL PINANG', 4599000, 2738000);
INSERT INTO `ref_tarif_pesawat` VALUES (100, 'BANDUNG', 'PEKANBARU', 6525000, 3701000);
INSERT INTO `ref_tarif_pesawat` VALUES (101, 'BANDUNG', 'SEMARANG', 3027000, 1957000);
INSERT INTO `ref_tarif_pesawat` VALUES (102, 'BANDUNG', 'SOLO', 3647000, 2268000);
INSERT INTO `ref_tarif_pesawat` VALUES (103, 'BANDUNG', 'SURABAYA', 4824000, 3056000);
INSERT INTO `ref_tarif_pesawat` VALUES (104, 'BANDUNG', 'TANJUNG PANDAN', 4439000, 2850000);
INSERT INTO `ref_tarif_pesawat` VALUES (105, 'BANJARMASIN', 'BANDA ACEH', 10792000, 6022000);
INSERT INTO `ref_tarif_pesawat` VALUES (106, 'BANJARMASIN', 'BATAM', 8407000, 4578000);
INSERT INTO `ref_tarif_pesawat` VALUES (107, 'BANJARMASIN', 'BIAK', 16686000, 8749000);
INSERT INTO `ref_tarif_pesawat` VALUES (108, 'BANJARMASIN', 'DENPASAR', 8792000, 4920000);
INSERT INTO `ref_tarif_pesawat` VALUES (109, 'BANJARMASIN', 'JAYAPURA', 17135000, 9359000);
INSERT INTO `ref_tarif_pesawat` VALUES (110, 'BANJARMASIN', 'YOGYAKARTA', 7723000, 4304000);
INSERT INTO `ref_tarif_pesawat` VALUES (111, 'BANJARMASIN', 'MEDAN', 10546000, 5412000);
INSERT INTO `ref_tarif_pesawat` VALUES (112, 'BANJARMASIN', 'PADANG', 9006000, 4642000);
INSERT INTO `ref_tarif_pesawat` VALUES (113, 'BANJARMASIN', 'PALEMBANG', 7498000, 4022000);
INSERT INTO `ref_tarif_pesawat` VALUES (114, 'BANJARMASIN', 'PEKANBARU', 9049000, 4696000);
INSERT INTO `ref_tarif_pesawat` VALUES (115, 'BANJARMASIN', 'SEMARANG', 7498000, 3958000);
INSERT INTO `ref_tarif_pesawat` VALUES (116, 'BANJARMASIN', 'SOLO', 7498000, 4097000);
INSERT INTO `ref_tarif_pesawat` VALUES (117, 'BANJARMASIN', 'SURABAYA', 8942000, 4592000);
INSERT INTO `ref_tarif_pesawat` VALUES (118, 'BANJARMASIN', 'TIMIKA', 16472000, 8897000);
INSERT INTO `ref_tarif_pesawat` VALUES (119, 'BATAM', 'BANDA ACEH', 10439000, 5936000);
INSERT INTO `ref_tarif_pesawat` VALUES (120, 'BATAM', 'DENPASAR', 8450000, 4824000);
INSERT INTO `ref_tarif_pesawat` VALUES (121, 'BATAM', 'JAYAPURA', 16782000, 9263000);
INSERT INTO `ref_tarif_pesawat` VALUES (122, 'BATAM', 'YOGYAKARTA', 7370000, 3936000);
INSERT INTO `ref_tarif_pesawat` VALUES (123, 'BATAM', 'MAKASSAR', 10375000, 5711000);
INSERT INTO `ref_tarif_pesawat` VALUES (124, 'BATAM', 'MANADO', 13413000, 6482000);
INSERT INTO `ref_tarif_pesawat` VALUES (125, 'BATAM', 'MEDAN', 10193000, 5316000);
INSERT INTO `ref_tarif_pesawat` VALUES (126, 'BATAM', 'PADANG', 8653000, 4546000);
INSERT INTO `ref_tarif_pesawat` VALUES (127, 'BATAM', 'PALEMBANG', 7145000, 3936000);
INSERT INTO `ref_tarif_pesawat` VALUES (128, 'BATAM', 'PEKANBARU', 8707000, 4599000);
INSERT INTO `ref_tarif_pesawat` VALUES (129, 'BATAM', 'PONTIANAK', 7594000, 4396000);
INSERT INTO `ref_tarif_pesawat` VALUES (130, 'BATAM', 'SEMARANG', 7145000, 3861000);
INSERT INTO `ref_tarif_pesawat` VALUES (131, 'BATAM', 'SOLO', 7145000, 4000000);
INSERT INTO `ref_tarif_pesawat` VALUES (132, 'BATAM', 'SURABAYA', 8600000, 4300000);
INSERT INTO `ref_tarif_pesawat` VALUES (133, 'BATAM', 'TIMIKA', 16119000, 8621000);
INSERT INTO `ref_tarif_pesawat` VALUES (134, 'BENGKULU', 'PALEMBANG', 2899000, 2026000);
INSERT INTO `ref_tarif_pesawat` VALUES (135, 'BIAK', 'BALIKPAPAN', 18622000, 9477000);
INSERT INTO `ref_tarif_pesawat` VALUES (136, 'BIAK', 'BANDA ACEH', 18718000, 10108000);
INSERT INTO `ref_tarif_pesawat` VALUES (137, 'BIAK', 'BATAM', 16333000, 8664000);
INSERT INTO `ref_tarif_pesawat` VALUES (138, 'BIAK', 'DENPASAR', 16729000, 8995000);
INSERT INTO `ref_tarif_pesawat` VALUES (139, 'BIAK', 'JAYAPURA', 3615000, 2321000);
INSERT INTO `ref_tarif_pesawat` VALUES (140, 'BIAK', 'YOGYAKARTA', 15648000, 8108000);
INSERT INTO `ref_tarif_pesawat` VALUES (141, 'BIAK', 'MANADO', 11734000, 6353000);
INSERT INTO `ref_tarif_pesawat` VALUES (142, 'BIAK', 'MEDAN', 18472000, 9498000);
INSERT INTO `ref_tarif_pesawat` VALUES (143, 'BIAK', 'PADANG', 16932000, 8728000);
INSERT INTO `ref_tarif_pesawat` VALUES (144, 'BIAK', 'PALEMBANG', 15424000, 8108000);
INSERT INTO `ref_tarif_pesawat` VALUES (145, 'BIAK', 'PEKANBARU', 16985000, 8781000);
INSERT INTO `ref_tarif_pesawat` VALUES (146, 'BIAK', 'PONTIANAK', 15873000, 8568000);
INSERT INTO `ref_tarif_pesawat` VALUES (147, 'BIAK', 'SURABAYA', 12782000, 7081000);
INSERT INTO `ref_tarif_pesawat` VALUES (148, 'BIAK', 'TIMIKA', 5808000, 3444000);
INSERT INTO `ref_tarif_pesawat` VALUES (149, 'DENPASAR', 'JAYAPURA', 11680000, 7325000);
INSERT INTO `ref_tarif_pesawat` VALUES (150, 'DENPASAR', 'KUPANG', 5091000, 3159000);
INSERT INTO `ref_tarif_pesawat` VALUES (151, 'DENPASAR', 'MAKASSAR', 4182000, 2816000);
INSERT INTO `ref_tarif_pesawat` VALUES (152, 'DENPASAR', 'MANADO', 7851000, 4578000);
INSERT INTO `ref_tarif_pesawat` VALUES (153, 'DENPASAR', 'MATARAM', 1840000, 1488000);
INSERT INTO `ref_tarif_pesawat` VALUES (154, 'DENPASAR', 'MEDAN', 10589000, 5658000);
INSERT INTO `ref_tarif_pesawat` VALUES (155, 'DENPASAR', 'PADANG', 9049000, 4888000);
INSERT INTO `ref_tarif_pesawat` VALUES (156, 'DENPASAR', 'PALANGKARAYA', 8557000, 4909000);
INSERT INTO `ref_tarif_pesawat` VALUES (157, 'DENPASAR', 'PALEMBANG', 7541000, 4278000);
INSERT INTO `ref_tarif_pesawat` VALUES (158, 'DENPASAR', 'PEKANBARU', 9092000, 4942000);
INSERT INTO `ref_tarif_pesawat` VALUES (159, 'DENPASAR', 'PONTIANAK', 7990000, 4738000);
INSERT INTO `ref_tarif_pesawat` VALUES (160, 'DENPASAR', 'TIMIKA', 10140000, 6559000);
INSERT INTO `ref_tarif_pesawat` VALUES (161, 'JAMBI', 'BALIKPAPAN', 7733000, 4407000);
INSERT INTO `ref_tarif_pesawat` VALUES (162, 'JAMBI', 'BANJARMASIN', 7690000, 4193000);
INSERT INTO `ref_tarif_pesawat` VALUES (163, 'JAMBI', 'DENPASAR', 7733000, 4439000);
INSERT INTO `ref_tarif_pesawat` VALUES (164, 'JAMBI', 'YOGYAKARTA', 6653000, 3551000);
INSERT INTO `ref_tarif_pesawat` VALUES (165, 'JAMBI', 'KUPANG', 11434000, 6075000);
INSERT INTO `ref_tarif_pesawat` VALUES (166, 'JAMBI', 'MAKASSAR', 9659000, 4952000);
INSERT INTO `ref_tarif_pesawat` VALUES (167, 'JAMBI', 'MALANG', 7091000, 3925000);
INSERT INTO `ref_tarif_pesawat` VALUES (168, 'JAMBI', 'MANADO', 12707000, 6097000);
INSERT INTO `ref_tarif_pesawat` VALUES (169, 'JAMBI', 'PALANGKARAYA', 7444000, 4193000);
INSERT INTO `ref_tarif_pesawat` VALUES (170, 'JAMBI', 'PONTIANAK', 6878000, 4011000);
INSERT INTO `ref_tarif_pesawat` VALUES (171, 'JAMBI', 'SEMARANG', 6428000, 3476000);
INSERT INTO `ref_tarif_pesawat` VALUES (172, 'JAMBI', 'SOLO', 6428000, 3615000);
INSERT INTO `ref_tarif_pesawat` VALUES (173, 'JAMBI', 'SURABAYA', 7883000, 3915000);
INSERT INTO `ref_tarif_pesawat` VALUES (174, 'JAYAPURA', 'YOGYAKARTA', 13274000, 7690000);
INSERT INTO `ref_tarif_pesawat` VALUES (175, 'JAYAPURA', 'MANADO', 22109000, 11263000);
INSERT INTO `ref_tarif_pesawat` VALUES (176, 'JAYAPURA', 'MEDAN', 18932000, 10097000);
INSERT INTO `ref_tarif_pesawat` VALUES (177, 'JAYAPURA', 'PADANG', 17381000, 9327000);
INSERT INTO `ref_tarif_pesawat` VALUES (178, 'JAYAPURA', 'PALEMBANG', 15873000, 8717000);
INSERT INTO `ref_tarif_pesawat` VALUES (179, 'JAYAPURA', 'PEKANBARU', 17435000, 9380000);
INSERT INTO `ref_tarif_pesawat` VALUES (180, 'JAYAPURA', 'PONTIANAK', 16322000, 9177000);
INSERT INTO `ref_tarif_pesawat` VALUES (181, 'JAYAPURA', 'TIMIKA', 3615000, 2289000);
INSERT INTO `ref_tarif_pesawat` VALUES (182, 'YOGYAKARTA', 'DENPASAR', 3861000, 2655000);
INSERT INTO `ref_tarif_pesawat` VALUES (183, 'YOGYAKARTA', 'MAKASSAR', 6525000, 3893000);
INSERT INTO `ref_tarif_pesawat` VALUES (184, 'YOGYAKARTA', 'MANADO', 10536000, 5722000);
INSERT INTO `ref_tarif_pesawat` VALUES (185, 'YOGYAKARTA', 'MEDAN', 9519000, 4770000);
INSERT INTO `ref_tarif_pesawat` VALUES (186, 'YOGYAKARTA', 'PADANG', 7969000, 4280000);
INSERT INTO `ref_tarif_pesawat` VALUES (187, 'YOGYAKARTA', 'PALEMBANG', 6460000, 3617000);
INSERT INTO `ref_tarif_pesawat` VALUES (188, 'YOGYAKARTA', 'PEKANBARU', 8022000, 4054000);
INSERT INTO `ref_tarif_pesawat` VALUES (189, 'YOGYAKARTA', 'PONTIANAK', 6910000, 3840000);
INSERT INTO `ref_tarif_pesawat` VALUES (190, 'YOGYAKARTA', 'TIMIKA', 11894000, 7114000);
INSERT INTO `ref_tarif_pesawat` VALUES (191, 'KENDARI', 'BANDA ACEH', 12953000, 7102000);
INSERT INTO `ref_tarif_pesawat` VALUES (192, 'KENDARI', 'BATAM', 10568000, 5658000);
INSERT INTO `ref_tarif_pesawat` VALUES (193, 'KENDARI', 'DENPASAR', 5455000, 3503000);
INSERT INTO `ref_tarif_pesawat` VALUES (194, 'KENDARI', 'YOGYAKARTA', 8129000, 4706000);
INSERT INTO `ref_tarif_pesawat` VALUES (195, 'KENDARI', 'PADANG', 11167000, 5722000);
INSERT INTO `ref_tarif_pesawat` VALUES (196, 'KENDARI', 'PALEMBANG', 9659000, 5102000);
INSERT INTO `ref_tarif_pesawat` VALUES (197, 'KENDARI', 'PEKANBARU', 11220000, 5776000);
INSERT INTO `ref_tarif_pesawat` VALUES (198, 'KENDARI', 'SEMARANG', 9659000, 5027000);
INSERT INTO `ref_tarif_pesawat` VALUES (199, 'KENDARI', 'SOLO', 9659000, 5166000);
INSERT INTO `ref_tarif_pesawat` VALUES (200, 'KENDARI', 'SURABAYA', 11103000, 5466000);
INSERT INTO `ref_tarif_pesawat` VALUES (201, 'KENDARI', 'TIMIKA', 18633000, 9798000);
INSERT INTO `ref_tarif_pesawat` VALUES (202, 'KUPANG', 'JAYAPURA', 14386000, 8676000);
INSERT INTO `ref_tarif_pesawat` VALUES (203, 'KUPANG', 'YOGYAKARTA', 7348000, 4182000);
INSERT INTO `ref_tarif_pesawat` VALUES (204, 'KUPANG', 'MAKASSAR', 7637000, 4311000);
INSERT INTO `ref_tarif_pesawat` VALUES (205, 'KUPANG', 'MANADO', 11648000, 6140000);
INSERT INTO `ref_tarif_pesawat` VALUES (206, 'KUPANG', 'SURABAYA', 6749000, 3983000);
INSERT INTO `ref_tarif_pesawat` VALUES (207, 'MAKASSAR', 'BIAK', 8493000, 4931000);
INSERT INTO `ref_tarif_pesawat` VALUES (208, 'MAKASSAR', 'JAYAPURA', 10193000, 6193000);
INSERT INTO `ref_tarif_pesawat` VALUES (209, 'MAKASSAR', 'KENDARI', 2663000, 1912000);
INSERT INTO `ref_tarif_pesawat` VALUES (210, 'MAKASSAR', 'MANADO', 5327000, 2909000);
INSERT INTO `ref_tarif_pesawat` VALUES (211, 'MAKASSAR', 'TIMIKA', 11723000, 7027000);
INSERT INTO `ref_tarif_pesawat` VALUES (212, 'MALANG', 'BALIKPAPAN', 10108000, 5134000);
INSERT INTO `ref_tarif_pesawat` VALUES (213, 'MALANG', 'BANDA ACEH', 10204000, 5765000);
INSERT INTO `ref_tarif_pesawat` VALUES (214, 'MALANG', 'BANJARMASIN', 8161000, 4407000);
INSERT INTO `ref_tarif_pesawat` VALUES (215, 'MALANG', 'BATAM', 7819000, 4311000);
INSERT INTO `ref_tarif_pesawat` VALUES (216, 'MALANG', 'BIAK', 16087000, 8482000);
INSERT INTO `ref_tarif_pesawat` VALUES (217, 'MALANG', 'JAYAPURA', 16536000, 9092000);
INSERT INTO `ref_tarif_pesawat` VALUES (218, 'MALANG', 'KENDARI', 10322000, 5487000);
INSERT INTO `ref_tarif_pesawat` VALUES (219, 'MALANG', 'MAKASSAR', 10129000, 5166000);
INSERT INTO `ref_tarif_pesawat` VALUES (220, 'MALANG', 'MANADO', 13167000, 6311000);
INSERT INTO `ref_tarif_pesawat` VALUES (221, 'MALANG', 'MEDAN', 9958000, 5145000);
INSERT INTO `ref_tarif_pesawat` VALUES (222, 'MALANG', 'PADANG', 8418000, 4385000);
INSERT INTO `ref_tarif_pesawat` VALUES (223, 'MALANG', 'PALANGKARAYA', 7915000, 4407000);
INSERT INTO `ref_tarif_pesawat` VALUES (224, 'MALANG', 'PALEMBANG', 6899000, 3765000);
INSERT INTO `ref_tarif_pesawat` VALUES (225, 'MALANG', 'PEKANBARU', 8461000, 4439000);
INSERT INTO `ref_tarif_pesawat` VALUES (226, 'MALANG', 'TIMIKA', 15873000, 8461000);
INSERT INTO `ref_tarif_pesawat` VALUES (227, 'MANADO', 'MEDAN', 15552000, 7316000);
INSERT INTO `ref_tarif_pesawat` VALUES (228, 'MANADO', 'PADANG', 14012000, 6546000);
INSERT INTO `ref_tarif_pesawat` VALUES (229, 'MANADO', 'PALEMBANG', 12504000, 5926000);
INSERT INTO `ref_tarif_pesawat` VALUES (230, 'MANADO', 'PEKANBARU', 14055000, 6599000);
INSERT INTO `ref_tarif_pesawat` VALUES (231, 'MANADO', 'PONTIANAK', 12953000, 6396000);
INSERT INTO `ref_tarif_pesawat` VALUES (232, 'MANADO', 'SEMARANG', 12504000, 5851000);
INSERT INTO `ref_tarif_pesawat` VALUES (233, 'MANADO', 'SOLO', 12504000, 5990000);
INSERT INTO `ref_tarif_pesawat` VALUES (234, 'MANADO', 'SURABAYA', 9937000, 5262000);
INSERT INTO `ref_tarif_pesawat` VALUES (235, 'MANADO', 'TIMIKA', 16183000, 8995000);
INSERT INTO `ref_tarif_pesawat` VALUES (236, 'MATARAM', 'BALIKPAPAN', 10750000, 5615000);
INSERT INTO `ref_tarif_pesawat` VALUES (237, 'MATARAM', 'BANDA ACEH', 10846000, 6246000);
INSERT INTO `ref_tarif_pesawat` VALUES (238, 'MATARAM', 'BANJARMASIN', 8803000, 4888000);
INSERT INTO `ref_tarif_pesawat` VALUES (239, 'MATARAM', 'BATAM', 8461000, 4803000);
INSERT INTO `ref_tarif_pesawat` VALUES (240, 'MATARAM', 'BIAK', 11552000, 6546000);
INSERT INTO `ref_tarif_pesawat` VALUES (241, 'MATARAM', 'JAYAPURA', 13092000, 7575000);
INSERT INTO `ref_tarif_pesawat` VALUES (242, 'MATARAM', 'YOGYAKARTA', 4417000, 2968000);
INSERT INTO `ref_tarif_pesawat` VALUES (243, 'MATARAM', 'MAKASSAR', 4717000, 3113000);
INSERT INTO `ref_tarif_pesawat` VALUES (244, 'MATARAM', 'MANADO', 8717000, 5070000);
INSERT INTO `ref_tarif_pesawat` VALUES (245, 'MATARAM', 'MEDAN', 10600000, 5637000);
INSERT INTO `ref_tarif_pesawat` VALUES (246, 'MATARAM', 'PADANG', 9060000, 4867000);
INSERT INTO `ref_tarif_pesawat` VALUES (247, 'MATARAM', 'PALEMBANG', 7551000, 4246000);
INSERT INTO `ref_tarif_pesawat` VALUES (248, 'MATARAM', 'PEKANBARU', 9102000, 4909000);
INSERT INTO `ref_tarif_pesawat` VALUES (249, 'MATARAM', 'PONTIANAK', 8001000, 4706000);
INSERT INTO `ref_tarif_pesawat` VALUES (250, 'MATARAM', 'SURABAYA', 3829000, 2484000);
INSERT INTO `ref_tarif_pesawat` VALUES (251, 'MEDAN', 'BANDA ACEH', 3466000, 2347000);
INSERT INTO `ref_tarif_pesawat` VALUES (252, 'MEDAN', 'MAKASSAR', 12514000, 6172000);
INSERT INTO `ref_tarif_pesawat` VALUES (253, 'MEDAN', 'PONTIANAK', 9733000, 5230000);
INSERT INTO `ref_tarif_pesawat` VALUES (254, 'MEDAN', 'SEMARANG', 9284000, 4696000);
INSERT INTO `ref_tarif_pesawat` VALUES (255, 'MEDAN', 'SOLO', 9284000, 4835000);
INSERT INTO `ref_tarif_pesawat` VALUES (256, 'MEDAN', 'SURABAYA', 10739000, 5134000);
INSERT INTO `ref_tarif_pesawat` VALUES (257, 'MEDAN', 'TIMIKA', 18258000, 9455000);
INSERT INTO `ref_tarif_pesawat` VALUES (258, 'PADANG', 'MAKASSAR', 10974000, 5402000);
INSERT INTO `ref_tarif_pesawat` VALUES (259, 'PADANG', 'PONTIANAK', 8193000, 4460000);
INSERT INTO `ref_tarif_pesawat` VALUES (260, 'PADANG', 'SEMARANG', 7744000, 3925000);
INSERT INTO `ref_tarif_pesawat` VALUES (261, 'PADANG', 'SOLO', 7744000, 4065000);
INSERT INTO `ref_tarif_pesawat` VALUES (262, 'PADANG', 'SURABAYA', 9199000, 4364000);
INSERT INTO `ref_tarif_pesawat` VALUES (263, 'PADANG', 'TIMIKA', 16718000, 8685000);
INSERT INTO `ref_tarif_pesawat` VALUES (264, 'PALANGKARAYA', 'BANDA ACEH', 10546000, 6022000);
INSERT INTO `ref_tarif_pesawat` VALUES (265, 'PALANGKARAYA', 'BATAM', 8161000, 4578000);
INSERT INTO `ref_tarif_pesawat` VALUES (266, 'PALANGKARAYA', 'YOGYAKARTA', 7477000, 4304000);
INSERT INTO `ref_tarif_pesawat` VALUES (267, 'PALANGKARAYA', 'MATARAM', 8557000, 4888000);
INSERT INTO `ref_tarif_pesawat` VALUES (268, 'PALANGKARAYA', 'MEDAN', 10300000, 5412000);
INSERT INTO `ref_tarif_pesawat` VALUES (269, 'PALANGKARAYA', 'PADANG', 8760000, 4642000);
INSERT INTO `ref_tarif_pesawat` VALUES (270, 'PALANGKARAYA', 'PALEMBANG', 7252000, 4022000);
INSERT INTO `ref_tarif_pesawat` VALUES (271, 'PALANGKARAYA', 'PEKANBARU', 8803000, 4696000);
INSERT INTO `ref_tarif_pesawat` VALUES (272, 'PALANGKARAYA', 'SEMARANG', 7252000, 3947000);
INSERT INTO `ref_tarif_pesawat` VALUES (273, 'PALANGKARAYA', 'SOLO', 7252000, 4086000);
INSERT INTO `ref_tarif_pesawat` VALUES (274, 'PALANGKARAYA', 'SURABAYA', 8696000, 4385000);
INSERT INTO `ref_tarif_pesawat` VALUES (275, 'PALEMBANG', 'BALIKPAPAN', 9894000, 5220000);
INSERT INTO `ref_tarif_pesawat` VALUES (276, 'PALEMBANG', 'MAKASSAR', 9466000, 4781000);
INSERT INTO `ref_tarif_pesawat` VALUES (277, 'PALEMBANG', 'PONTIANAK', 6685000, 3840000);
INSERT INTO `ref_tarif_pesawat` VALUES (278, 'PALEMBANG', 'SEMARANG', 6236000, 3305000);
INSERT INTO `ref_tarif_pesawat` VALUES (279, 'PALEMBANG', 'SOLO', 6236000, 3444000);
INSERT INTO `ref_tarif_pesawat` VALUES (280, 'PALEMBANG', 'SURABAYA', 7690000, 3744000);
INSERT INTO `ref_tarif_pesawat` VALUES (281, 'PALEMBANG', 'TIMIKA', 15210000, 8076000);
INSERT INTO `ref_tarif_pesawat` VALUES (282, 'PALU', 'MAKASSAR', 4268000, 2578000);
INSERT INTO `ref_tarif_pesawat` VALUES (283, 'PALU', 'POSO', 1957000, 1423000);
INSERT INTO `ref_tarif_pesawat` VALUES (284, 'PALU', 'SORONG', 6878000, 4155000);
INSERT INTO `ref_tarif_pesawat` VALUES (285, 'PALU', 'SURABAYA', 6878000, 3883000);
INSERT INTO `ref_tarif_pesawat` VALUES (286, 'PALU', 'TOLI-TOLI', 2941000, 1915000);
INSERT INTO `ref_tarif_pesawat` VALUES (287, 'PANGKAL PINANG', 'BALIKPAPAN', 9038000, 4631000);
INSERT INTO `ref_tarif_pesawat` VALUES (288, 'PANGKAL PINANG', 'BANJARMASIN', 7091000, 3915000);
INSERT INTO `ref_tarif_pesawat` VALUES (289, 'PANGKAL PINANG', 'BATAM', 6739000, 3818000);
INSERT INTO `ref_tarif_pesawat` VALUES (290, 'PANGKAL PINANG', 'YOGYAKARTA', 6065000, 3262000);
INSERT INTO `ref_tarif_pesawat` VALUES (291, 'PANGKAL PINANG', 'MAKASSAR', 9060000, 4663000);
INSERT INTO `ref_tarif_pesawat` VALUES (292, 'PANGKAL PINANG', 'MANADO', 12097000, 5808000);
INSERT INTO `ref_tarif_pesawat` VALUES (293, 'PANGKAL PINANG', 'MEDAN', 8888000, 4653000);
INSERT INTO `ref_tarif_pesawat` VALUES (294, 'PANGKAL PINANG', 'PADANG', 7337000, 3883000);
INSERT INTO `ref_tarif_pesawat` VALUES (295, 'PANGKAL PINANG', 'PALEMBANG', 5829000, 3262000);
INSERT INTO `ref_tarif_pesawat` VALUES (296, 'PANGKAL PINANG', 'PEKANBARU', 7391000, 3936000);
INSERT INTO `ref_tarif_pesawat` VALUES (297, 'PANGKAL PINANG', 'PONTIANAK', 6279000, 3733000);
INSERT INTO `ref_tarif_pesawat` VALUES (298, 'PANGKAL PINANG', 'SEMARANG', 5829000, 3187000);
INSERT INTO `ref_tarif_pesawat` VALUES (299, 'PANGKAL PINANG', 'SOLO', 5829000, 3326000);
INSERT INTO `ref_tarif_pesawat` VALUES (300, 'PANGKAL PINANG', 'SURABAYA', 7284000, 3626000);
INSERT INTO `ref_tarif_pesawat` VALUES (301, 'PEKANBARU', 'PONTIANAK', 8247000, 4514000);
INSERT INTO `ref_tarif_pesawat` VALUES (302, 'PEKANBARU', 'SEMARANG', 7797000, 3979000);
INSERT INTO `ref_tarif_pesawat` VALUES (303, 'PEKANBARU', 'SOLO', 7797000, 4118000);
INSERT INTO `ref_tarif_pesawat` VALUES (304, 'PEKANBARU', 'SURABAYA', 9241000, 4407000);
INSERT INTO `ref_tarif_pesawat` VALUES (305, 'PEKANBARU', 'TIMIKA', 16771000, 8739000);
INSERT INTO `ref_tarif_pesawat` VALUES (306, 'PONTIANAK', 'MAKASSAR', 9915000, 5241000);
INSERT INTO `ref_tarif_pesawat` VALUES (307, 'PONTIANAK', 'SEMARANG', 6685000, 3765000);
INSERT INTO `ref_tarif_pesawat` VALUES (308, 'PONTIANAK', 'SOLO', 6685000, 3904000);
INSERT INTO `ref_tarif_pesawat` VALUES (309, 'PONTIANAK', 'SURABAYA', 8140000, 4204000);
INSERT INTO `ref_tarif_pesawat` VALUES (310, 'PONTIANAK', 'TIMIKA', 15659000, 8535000);
INSERT INTO `ref_tarif_pesawat` VALUES (311, 'SEMARANG', 'MAKASSAR', 9466000, 4706000);
INSERT INTO `ref_tarif_pesawat` VALUES (312, 'SOLO', 'MAKASSAR', 9466000, 4845000);
INSERT INTO `ref_tarif_pesawat` VALUES (313, 'SURABAYA', 'DENPASAR', 3198000, 2118000);
INSERT INTO `ref_tarif_pesawat` VALUES (314, 'SURABAYA', 'JAYAPURA', 12675000, 7250000);
INSERT INTO `ref_tarif_pesawat` VALUES (315, 'SURABAYA', 'MAKASSAR', 5936000, 3674000);
INSERT INTO `ref_tarif_pesawat` VALUES (316, 'SURABAYA', 'TIMIKA', 11295000, 6589000);

-- ----------------------------
-- Table structure for ref_tarif_transport_darat
-- ----------------------------
DROP TABLE IF EXISTS `ref_tarif_transport_darat`;
CREATE TABLE `ref_tarif_transport_darat`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `ibukota_provinsi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `kabupaten_kota_tujuan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `besaran` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 371 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_tarif_transport_darat
-- ----------------------------
INSERT INTO `ref_tarif_transport_darat` VALUES (1, 'Banda Aceh', 'Kab. Aceh Barat', 275000);
INSERT INTO `ref_tarif_transport_darat` VALUES (2, 'Banda Aceh', 'Kab. Aceh Barat Daya', 298000);
INSERT INTO `ref_tarif_transport_darat` VALUES (3, 'Banda Aceh', 'Kab. Aceh Besar', 183000);
INSERT INTO `ref_tarif_transport_darat` VALUES (4, 'Banda Aceh', 'Kab. Aceh Jaya', 238000);
INSERT INTO `ref_tarif_transport_darat` VALUES (5, 'Banda Aceh', 'Kab. Aceh Selatan', 325000);
INSERT INTO `ref_tarif_transport_darat` VALUES (6, 'Banda Aceh', 'Kab. Aceh Singkil', 420000);
INSERT INTO `ref_tarif_transport_darat` VALUES (7, 'Banda Aceh', 'Kab. Aceh Tamiang', 315000);
INSERT INTO `ref_tarif_transport_darat` VALUES (8, 'Banda Aceh', 'Kab. Aceh Tengah', 293000);
INSERT INTO `ref_tarif_transport_darat` VALUES (9, 'Banda Aceh', 'Kab. Aceh Tenggara', 460000);
INSERT INTO `ref_tarif_transport_darat` VALUES (10, 'Banda Aceh', 'Kab. Aceh Timur', 289000);
INSERT INTO `ref_tarif_transport_darat` VALUES (11, 'Banda Aceh', 'Kab. Aceh Utara', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (12, 'Banda Aceh', 'Kab. Bener Meriah', 278000);
INSERT INTO `ref_tarif_transport_darat` VALUES (13, 'Banda Aceh', 'Kab. Bireuen', 220000);
INSERT INTO `ref_tarif_transport_darat` VALUES (14, 'Banda Aceh', 'Kab. Gayo Lues', 370000);
INSERT INTO `ref_tarif_transport_darat` VALUES (15, 'Banda Aceh', 'Kab. Nagan Raya', 275000);
INSERT INTO `ref_tarif_transport_darat` VALUES (16, 'Banda Aceh', 'Kab. Pidie', 190000);
INSERT INTO `ref_tarif_transport_darat` VALUES (17, 'Banda Aceh', 'Kab. Pidie Jaya', 205000);
INSERT INTO `ref_tarif_transport_darat` VALUES (18, 'Banda Aceh', 'Kota Langsa', 301000);
INSERT INTO `ref_tarif_transport_darat` VALUES (19, 'Banda Aceh', 'Kota Lhokseumawe', 240000);
INSERT INTO `ref_tarif_transport_darat` VALUES (20, 'Banda Aceh', 'Kota Subulussalam', 400000);
INSERT INTO `ref_tarif_transport_darat` VALUES (21, 'Medan', 'Kab. Asahan', 259000);
INSERT INTO `ref_tarif_transport_darat` VALUES (22, 'Medan', 'Kab. Batubara', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (23, 'Medan', 'Kab. Dairi', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (24, 'Medan', 'Kab. Deli Serdang', 186000);
INSERT INTO `ref_tarif_transport_darat` VALUES (25, 'Medan', 'Kab. Humbang Hasundutan', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (26, 'Medan', 'Kab. Karo', 200000);
INSERT INTO `ref_tarif_transport_darat` VALUES (27, 'Medan', 'Kab. Labuhan Batu', 287000);
INSERT INTO `ref_tarif_transport_darat` VALUES (28, 'Medan', 'Kab. Labuhan Batu Selatan', 360000);
INSERT INTO `ref_tarif_transport_darat` VALUES (29, 'Medan', 'Kab. Labuhan Batu Utara', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (30, 'Medan', 'Kab. Langkat', 186000);
INSERT INTO `ref_tarif_transport_darat` VALUES (31, 'Medan', 'Kab. Mandailing Natal', 420000);
INSERT INTO `ref_tarif_transport_darat` VALUES (32, 'Medan', 'Kab. Padang Lawas', 420000);
INSERT INTO `ref_tarif_transport_darat` VALUES (33, 'Medan', 'Kab. Padang Lawas Utara', 420000);
INSERT INTO `ref_tarif_transport_darat` VALUES (34, 'Medan', 'Kab. Pakpak Bharat', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (35, 'Medan', 'Kab. Samosir', 330000);
INSERT INTO `ref_tarif_transport_darat` VALUES (36, 'Medan', 'Kab. Serdang Bedagai', 200000);
INSERT INTO `ref_tarif_transport_darat` VALUES (37, 'Medan', 'Kab. Simalungun', 264000);
INSERT INTO `ref_tarif_transport_darat` VALUES (38, 'Medan', 'Kab. Tapanuli Selatan', 328000);
INSERT INTO `ref_tarif_transport_darat` VALUES (39, 'Medan', 'Kab. Tapanuli Tengah', 345000);
INSERT INTO `ref_tarif_transport_darat` VALUES (40, 'Medan', 'Kab. Tapanuli Utara', 330000);
INSERT INTO `ref_tarif_transport_darat` VALUES (41, 'Medan', 'Kab. Toba Samosir', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (42, 'Medan', 'Kota Binjai', 180000);
INSERT INTO `ref_tarif_transport_darat` VALUES (43, 'Medan', 'Kota Pematang Siantar', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (44, 'Medan', 'Kota Sibolga', 345000);
INSERT INTO `ref_tarif_transport_darat` VALUES (45, 'Medan', 'Kota Tanjung Balai', 285000);
INSERT INTO `ref_tarif_transport_darat` VALUES (46, 'Medan', 'Kota Tebing Tinggi', 203000);
INSERT INTO `ref_tarif_transport_darat` VALUES (47, 'Pekanbaru', 'Kab. Indragiri Hilir', 380000);
INSERT INTO `ref_tarif_transport_darat` VALUES (48, 'Pekanbaru', 'Kab. Indragiri Hulu', 315000);
INSERT INTO `ref_tarif_transport_darat` VALUES (49, 'Pekanbaru', 'Kab. Kampar', 200000);
INSERT INTO `ref_tarif_transport_darat` VALUES (50, 'Pekanbaru', 'Kab. Kuantan Singingi', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (51, 'Pekanbaru', 'Kab. Pelalawan', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (52, 'Pekanbaru', 'Kab. Rokan Hilir', 350000);
INSERT INTO `ref_tarif_transport_darat` VALUES (53, 'Pekanbaru', 'Kab. Rokan Hulu', 322000);
INSERT INTO `ref_tarif_transport_darat` VALUES (54, 'Pekanbaru', 'Kab. Siak', 350000);
INSERT INTO `ref_tarif_transport_darat` VALUES (55, 'Pekanbaru', 'Kota Dumai', 400000);
INSERT INTO `ref_tarif_transport_darat` VALUES (56, 'Tanjung Pinang', 'Kab. Bintan', 185000);
INSERT INTO `ref_tarif_transport_darat` VALUES (57, 'Jambi', 'Kab. Batanghari', 175000);
INSERT INTO `ref_tarif_transport_darat` VALUES (58, 'Jambi', 'Kab. Bungo', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (59, 'Jambi', 'Kab. Kerinci', 325000);
INSERT INTO `ref_tarif_transport_darat` VALUES (60, 'Jambi', 'Kab. Merangin', 260000);
INSERT INTO `ref_tarif_transport_darat` VALUES (61, 'Jambi', 'Kab. Muaro Jambi', 170000);
INSERT INTO `ref_tarif_transport_darat` VALUES (62, 'Jambi', 'Kab. Sarolangun', 241000);
INSERT INTO `ref_tarif_transport_darat` VALUES (63, 'Jambi', 'Kab. Tanjung Jabung Barat', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (64, 'Jambi', 'Kab. Tanjung Jabung Timur', 190000);
INSERT INTO `ref_tarif_transport_darat` VALUES (65, 'Jambi', 'Kab. Tebo', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (66, 'Jambi', 'Kota Sungai Penuh', 308000);
INSERT INTO `ref_tarif_transport_darat` VALUES (67, 'Padang', 'Kab. Agam', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (68, 'Padang', 'Kab. Dharmasraya', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (69, 'Padang', 'Kab. Lima Puluh Kota', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (70, 'Padang', 'Kab. Padang Pariaman', 205000);
INSERT INTO `ref_tarif_transport_darat` VALUES (71, 'Padang', 'Kab. Pasaman', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (72, 'Padang', 'Kab. Pasaman Barat', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (73, 'Padang', 'Kab. Pesisir Selatan', 205000);
INSERT INTO `ref_tarif_transport_darat` VALUES (74, 'Padang', 'Kab. Sijunjung', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (75, 'Padang', 'Kab. Solok', 210000);
INSERT INTO `ref_tarif_transport_darat` VALUES (76, 'Padang', 'Kab. Solok Selatan', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (77, 'Padang', 'Kab. Tanah Datar', 220000);
INSERT INTO `ref_tarif_transport_darat` VALUES (78, 'Padang', 'Kota Bukit Tinggi', 215000);
INSERT INTO `ref_tarif_transport_darat` VALUES (79, 'Padang', 'Kota Padang Panjang', 210000);
INSERT INTO `ref_tarif_transport_darat` VALUES (80, 'Padang', 'Kota Pariaman', 200000);
INSERT INTO `ref_tarif_transport_darat` VALUES (81, 'Padang', 'Kota Payakumbuh', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (82, 'Padang', 'Kota Sawahlunto', 215000);
INSERT INTO `ref_tarif_transport_darat` VALUES (83, 'Padang', 'Kota Solok', 210000);
INSERT INTO `ref_tarif_transport_darat` VALUES (84, 'Palembang', 'Kab. Banyuasin', 203000);
INSERT INTO `ref_tarif_transport_darat` VALUES (85, 'Palembang', 'Kab. Empat Lawang', 315000);
INSERT INTO `ref_tarif_transport_darat` VALUES (86, 'Palembang', 'Kab. Lahat', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (87, 'Palembang', 'Kab. Muara Enim', 235000);
INSERT INTO `ref_tarif_transport_darat` VALUES (88, 'Palembang', 'Kab. Musi Banyuasin', 235000);
INSERT INTO `ref_tarif_transport_darat` VALUES (89, 'Palembang', 'Kab. Musi Rawas', 320000);
INSERT INTO `ref_tarif_transport_darat` VALUES (90, 'Palembang', 'Kab. Musi Rawas Utara', 325000);
INSERT INTO `ref_tarif_transport_darat` VALUES (91, 'Palembang', 'Kab. Ogan Ilir', 205000);
INSERT INTO `ref_tarif_transport_darat` VALUES (92, 'Palembang', 'Kab. Ogan Komering Ilir', 205000);
INSERT INTO `ref_tarif_transport_darat` VALUES (93, 'Palembang', 'Kab. Ogan Komering Ulu', 248000);
INSERT INTO `ref_tarif_transport_darat` VALUES (94, 'Palembang', 'Kab. Ogan Komering Ulu Selatan', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (95, 'Palembang', 'Kab. Ogan Komering Ulu Timur', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (96, 'Palembang', 'Kab. Pali', 265000);
INSERT INTO `ref_tarif_transport_darat` VALUES (97, 'Palembang', 'Kota Lubuk Linggau', 290000);
INSERT INTO `ref_tarif_transport_darat` VALUES (98, 'Palembang', 'Kota Pagar Alam', 280000);
INSERT INTO `ref_tarif_transport_darat` VALUES (99, 'Palembang', 'Kota Prabumulih', 205000);
INSERT INTO `ref_tarif_transport_darat` VALUES (100, 'Bandar Lampung', 'Kab. Lampung Barat', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (101, 'Bandar Lampung', 'Kab. Lampung Selatan', 234000);
INSERT INTO `ref_tarif_transport_darat` VALUES (102, 'Bandar Lampung', 'Kab. Lampung Tengah', 246000);
INSERT INTO `ref_tarif_transport_darat` VALUES (103, 'Bandar Lampung', 'Kab. Lampung Timur', 246000);
INSERT INTO `ref_tarif_transport_darat` VALUES (104, 'Bandar Lampung', 'Kab. Lampung Utara', 252000);
INSERT INTO `ref_tarif_transport_darat` VALUES (105, 'Bandar Lampung', 'Kab. Mesuji', 276000);
INSERT INTO `ref_tarif_transport_darat` VALUES (106, 'Bandar Lampung', 'Kab. Pesawaran', 216000);
INSERT INTO `ref_tarif_transport_darat` VALUES (107, 'Bandar Lampung', 'Kab. Pesisir Barat', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (108, 'Bandar Lampung', 'Kab. Pringsewu', 222000);
INSERT INTO `ref_tarif_transport_darat` VALUES (109, 'Bandar Lampung', 'Kab. Tanggamus', 240000);
INSERT INTO `ref_tarif_transport_darat` VALUES (110, 'Bandar Lampung', 'Kab. Tulang Bawang', 252000);
INSERT INTO `ref_tarif_transport_darat` VALUES (111, 'Bandar Lampung', 'Kab. Tulang Bawang Barat', 267000);
INSERT INTO `ref_tarif_transport_darat` VALUES (112, 'Bandar Lampung', 'Kab. Way Kanan', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (113, 'Bandar Lampung', 'Kota Metro', 234000);
INSERT INTO `ref_tarif_transport_darat` VALUES (114, 'Bengkulu', 'Kab. Bengkulu Selatan', 344000);
INSERT INTO `ref_tarif_transport_darat` VALUES (115, 'Bengkulu', 'Kab. Bengkulu Tengah', 232000);
INSERT INTO `ref_tarif_transport_darat` VALUES (116, 'Bengkulu', 'Kab. Bengkulu Utara', 313000);
INSERT INTO `ref_tarif_transport_darat` VALUES (117, 'Bengkulu', 'Kab. Kaur', 385000);
INSERT INTO `ref_tarif_transport_darat` VALUES (118, 'Bengkulu', 'Kab. Kepahiang', 298000);
INSERT INTO `ref_tarif_transport_darat` VALUES (119, 'Bengkulu', 'Kab. Lebong', 375000);
INSERT INTO `ref_tarif_transport_darat` VALUES (120, 'Bengkulu', 'Kab. Mukomuko', 423000);
INSERT INTO `ref_tarif_transport_darat` VALUES (121, 'Bengkulu', 'Kab. Rejang Lebong', 313000);
INSERT INTO `ref_tarif_transport_darat` VALUES (122, 'Bengkulu', 'Kab. Seluma', 282000);
INSERT INTO `ref_tarif_transport_darat` VALUES (123, 'Pangkalpinang', 'Kab. Bangka', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (124, 'Pangkalpinang', 'Kab. Bangka Barat', 275000);
INSERT INTO `ref_tarif_transport_darat` VALUES (125, 'Pangkalpinang', 'Kab. Bangka Selatan', 275000);
INSERT INTO `ref_tarif_transport_darat` VALUES (126, 'Pangkalpinang', 'Kab. Bangka Tengah', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (127, 'Serang', 'Kab. Lebak', 208000);
INSERT INTO `ref_tarif_transport_darat` VALUES (128, 'Serang', 'Kab. Pandeglang', 138000);
INSERT INTO `ref_tarif_transport_darat` VALUES (129, 'Serang', 'Kab. Serang', 160000);
INSERT INTO `ref_tarif_transport_darat` VALUES (130, 'Serang', 'Kab. Tangerang', 254000);
INSERT INTO `ref_tarif_transport_darat` VALUES (131, 'Serang', 'Kota Cilegon', 160000);
INSERT INTO `ref_tarif_transport_darat` VALUES (132, 'Serang', 'Kota Tangerang', 313000);
INSERT INTO `ref_tarif_transport_darat` VALUES (133, 'Serang', 'Kota Tangerang Selatan', 347000);
INSERT INTO `ref_tarif_transport_darat` VALUES (134, 'Bandung', 'Kab. Bandung', 183000);
INSERT INTO `ref_tarif_transport_darat` VALUES (135, 'Bandung', 'Kab. Bandung Barat', 275000);
INSERT INTO `ref_tarif_transport_darat` VALUES (136, 'Bandung', 'Kab. Bekasi', 265000);
INSERT INTO `ref_tarif_transport_darat` VALUES (137, 'Bandung', 'Kab. Bogor', 275000);
INSERT INTO `ref_tarif_transport_darat` VALUES (138, 'Bandung', 'Kab. Ciamis', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (139, 'Bandung', 'Kab. Cianjur', 215000);
INSERT INTO `ref_tarif_transport_darat` VALUES (140, 'Bandung', 'Kab. Cirebon', 280000);
INSERT INTO `ref_tarif_transport_darat` VALUES (141, 'Bandung', 'Kab. Garut', 243000);
INSERT INTO `ref_tarif_transport_darat` VALUES (142, 'Bandung', 'Kab. Indramayu', 275000);
INSERT INTO `ref_tarif_transport_darat` VALUES (143, 'Bandung', 'Kab. Karawang', 248000);
INSERT INTO `ref_tarif_transport_darat` VALUES (144, 'Bandung', 'Kab. Kuningan', 275000);
INSERT INTO `ref_tarif_transport_darat` VALUES (145, 'Bandung', 'Kab. Majalengka', 235000);
INSERT INTO `ref_tarif_transport_darat` VALUES (146, 'Bandung', 'Kab. Pangadaran', 283000);
INSERT INTO `ref_tarif_transport_darat` VALUES (147, 'Bandung', 'Kab. Purwakarta', 218000);
INSERT INTO `ref_tarif_transport_darat` VALUES (148, 'Bandung', 'Kab. Subang', 208000);
INSERT INTO `ref_tarif_transport_darat` VALUES (149, 'Bandung', 'Kab. Sukabumi', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (150, 'Bandung', 'Kab. Sumedang', 230000);
INSERT INTO `ref_tarif_transport_darat` VALUES (151, 'Bandung', 'Kab. Tasikmalaya', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (152, 'Bandung', 'Kota Banjar', 283000);
INSERT INTO `ref_tarif_transport_darat` VALUES (153, 'Bandung', 'Kota Bekasi', 265000);
INSERT INTO `ref_tarif_transport_darat` VALUES (154, 'Bandung', 'Kota Bogor', 285000);
INSERT INTO `ref_tarif_transport_darat` VALUES (155, 'Bandung', 'Kota Cimahi', 168000);
INSERT INTO `ref_tarif_transport_darat` VALUES (156, 'Bandung', 'Kota Cirebon', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (157, 'Bandung', 'Kota Depok', 275000);
INSERT INTO `ref_tarif_transport_darat` VALUES (158, 'Bandung', 'Kota Sukabumi', 226000);
INSERT INTO `ref_tarif_transport_darat` VALUES (159, 'Bandung', 'Kota Tasikmalaya', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (160, 'Semarang', 'Kab. Banjarnegara', 260000);
INSERT INTO `ref_tarif_transport_darat` VALUES (161, 'Semarang', 'Kab. Banyumas', 257000);
INSERT INTO `ref_tarif_transport_darat` VALUES (162, 'Semarang', 'Kab. Batang', 240000);
INSERT INTO `ref_tarif_transport_darat` VALUES (163, 'Semarang', 'Kab. Blora', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (164, 'Semarang', 'Kab. Boyolali', 240000);
INSERT INTO `ref_tarif_transport_darat` VALUES (165, 'Semarang', 'Kab. Brebes', 263000);
INSERT INTO `ref_tarif_transport_darat` VALUES (166, 'Semarang', 'Kab. Cilacap', 280000);
INSERT INTO `ref_tarif_transport_darat` VALUES (167, 'Semarang', 'Kab. Demak', 230000);
INSERT INTO `ref_tarif_transport_darat` VALUES (168, 'Semarang', 'Kab. Grobogan', 235000);
INSERT INTO `ref_tarif_transport_darat` VALUES (169, 'Semarang', 'Kab. Jepara', 240000);
INSERT INTO `ref_tarif_transport_darat` VALUES (170, 'Semarang', 'Kab. Karanganyar', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (171, 'Semarang', 'Kab. Kebumen', 260000);
INSERT INTO `ref_tarif_transport_darat` VALUES (172, 'Semarang', 'Kab. Kendal', 230000);
INSERT INTO `ref_tarif_transport_darat` VALUES (173, 'Semarang', 'Kab. Klaten', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (174, 'Semarang', 'Kab. Kudus', 235000);
INSERT INTO `ref_tarif_transport_darat` VALUES (175, 'Semarang', 'Kab. Magelang', 240000);
INSERT INTO `ref_tarif_transport_darat` VALUES (176, 'Semarang', 'Kab. Pati', 240000);
INSERT INTO `ref_tarif_transport_darat` VALUES (177, 'Semarang', 'Kab. Pekalongan', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (178, 'Semarang', 'Kab. Pemalang', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (179, 'Semarang', 'Kab. Purbalingga', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (180, 'Semarang', 'Kab. Purworejo', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (181, 'Semarang', 'Kab. Rembang', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (182, 'Semarang', 'Kab. Semarang', 230000);
INSERT INTO `ref_tarif_transport_darat` VALUES (183, 'Semarang', 'Kab. Sragen', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (184, 'Semarang', 'Kab. Sukoharjo', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (185, 'Semarang', 'Kab. Tegal', 260000);
INSERT INTO `ref_tarif_transport_darat` VALUES (186, 'Semarang', 'Kab. Temanggung', 240000);
INSERT INTO `ref_tarif_transport_darat` VALUES (187, 'Semarang', 'Kab. Wonogiri', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (188, 'Semarang', 'Kab. Wonosobo', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (189, 'Semarang', 'Kota Magelang', 240000);
INSERT INTO `ref_tarif_transport_darat` VALUES (190, 'Semarang', 'Kota Pekalongan', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (191, 'Semarang', 'Kota Salatiga', 235000);
INSERT INTO `ref_tarif_transport_darat` VALUES (192, 'Semarang', 'Kota Surakarta', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (193, 'Semarang', 'Kota Tegal', 260000);
INSERT INTO `ref_tarif_transport_darat` VALUES (194, 'Yogyakarta', 'Kab. Bantul', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (195, 'Yogyakarta', 'Kab. Gunung Kidul', 350000);
INSERT INTO `ref_tarif_transport_darat` VALUES (196, 'Yogyakarta', 'Kab. Kulon Progo', 350000);
INSERT INTO `ref_tarif_transport_darat` VALUES (197, 'Yogyakarta', 'Kab. Sleman', 200000);
INSERT INTO `ref_tarif_transport_darat` VALUES (198, 'Surabaya', 'Kab. Bangkalan', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (199, 'Surabaya', 'Kab. Banyuwangi', 285000);
INSERT INTO `ref_tarif_transport_darat` VALUES (200, 'Surabaya', 'Kab. Blitar', 255000);
INSERT INTO `ref_tarif_transport_darat` VALUES (201, 'Surabaya', 'Kab. Bojonegoro', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (202, 'Surabaya', 'Kab. Bondowoso', 255000);
INSERT INTO `ref_tarif_transport_darat` VALUES (203, 'Surabaya', 'Kab. Gresik', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (204, 'Surabaya', 'Kab. Jember', 261000);
INSERT INTO `ref_tarif_transport_darat` VALUES (205, 'Surabaya', 'Kab. Jombang', 235000);
INSERT INTO `ref_tarif_transport_darat` VALUES (206, 'Surabaya', 'Kab. Kediri', 235000);
INSERT INTO `ref_tarif_transport_darat` VALUES (207, 'Surabaya', 'Kab. Lamongan', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (208, 'Surabaya', 'Kab. Lumajang', 261000);
INSERT INTO `ref_tarif_transport_darat` VALUES (209, 'Surabaya', 'Kab. Madiun', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (210, 'Surabaya', 'Kab. Magetan', 253000);
INSERT INTO `ref_tarif_transport_darat` VALUES (211, 'Surabaya', 'Kab. Malang', 228000);
INSERT INTO `ref_tarif_transport_darat` VALUES (212, 'Surabaya', 'Kab. Mojokerto', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (213, 'Surabaya', 'Kab. Nganjuk', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (214, 'Surabaya', 'Kab. Ngawi', 253000);
INSERT INTO `ref_tarif_transport_darat` VALUES (215, 'Surabaya', 'Kab. Pacitan', 285000);
INSERT INTO `ref_tarif_transport_darat` VALUES (216, 'Surabaya', 'Kab. Pamekasan', 243000);
INSERT INTO `ref_tarif_transport_darat` VALUES (217, 'Surabaya', 'Kab. Pasuruan', 228000);
INSERT INTO `ref_tarif_transport_darat` VALUES (218, 'Surabaya', 'Kab. Ponorogo', 255000);
INSERT INTO `ref_tarif_transport_darat` VALUES (219, 'Surabaya', 'Kab. Probolinggo', 228000);
INSERT INTO `ref_tarif_transport_darat` VALUES (220, 'Surabaya', 'Kab. Sampang', 235000);
INSERT INTO `ref_tarif_transport_darat` VALUES (221, 'Surabaya', 'Kab. Sidoarjo', 240000);
INSERT INTO `ref_tarif_transport_darat` VALUES (222, 'Surabaya', 'Kab. Situbondo', 255000);
INSERT INTO `ref_tarif_transport_darat` VALUES (223, 'Surabaya', 'Kab. Sumenep', 255000);
INSERT INTO `ref_tarif_transport_darat` VALUES (224, 'Surabaya', 'Kab. Trenggalek', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (225, 'Surabaya', 'Kab. Tuban', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (226, 'Surabaya', 'Kab. Tulungagung', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (227, 'Surabaya', 'Kota Batu', 242000);
INSERT INTO `ref_tarif_transport_darat` VALUES (228, 'Surabaya', 'Kota Blitar', 255000);
INSERT INTO `ref_tarif_transport_darat` VALUES (229, 'Surabaya', 'Kota Bojonegoro', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (230, 'Surabaya', 'Kota Kediri', 235000);
INSERT INTO `ref_tarif_transport_darat` VALUES (231, 'Surabaya', 'Kota Madiun', 245000);
INSERT INTO `ref_tarif_transport_darat` VALUES (232, 'Surabaya', 'Kota Malang', 228000);
INSERT INTO `ref_tarif_transport_darat` VALUES (233, 'Surabaya', 'Kota Mojokerto', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (234, 'Surabaya', 'Kota Probolinggo', 228000);
INSERT INTO `ref_tarif_transport_darat` VALUES (235, 'Denpasar', 'Kab. Badung', 188000);
INSERT INTO `ref_tarif_transport_darat` VALUES (236, 'Denpasar', 'Kab. Bangli', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (237, 'Denpasar', 'Kab. Buleleng', 265000);
INSERT INTO `ref_tarif_transport_darat` VALUES (238, 'Denpasar', 'Kab. Gianyar', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (239, 'Denpasar', 'Kab. Jembrana', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (240, 'Denpasar', 'Kab. Karangasem', 263000);
INSERT INTO `ref_tarif_transport_darat` VALUES (241, 'Denpasar', 'Kab. Tabanan', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (242, 'Mataram', 'Kab. Lombok Barat', 325000);
INSERT INTO `ref_tarif_transport_darat` VALUES (243, 'Mataram', 'Kab. Lombok Tengah', 450000);
INSERT INTO `ref_tarif_transport_darat` VALUES (244, 'Mataram', 'Kab. Lombok Timur', 350000);
INSERT INTO `ref_tarif_transport_darat` VALUES (245, 'Kupang', 'Kab. Belu', 325000);
INSERT INTO `ref_tarif_transport_darat` VALUES (246, 'Kupang', 'Kab. Kupang', 175000);
INSERT INTO `ref_tarif_transport_darat` VALUES (247, 'Kupang', 'Kab. Timor Tengah Selatan', 218000);
INSERT INTO `ref_tarif_transport_darat` VALUES (248, 'Kupang', 'Kab. Timor Tengah Utara', 275000);
INSERT INTO `ref_tarif_transport_darat` VALUES (249, 'Pontianak', 'Kab. Bengkayang', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (250, 'Pontianak', 'Kab. Kapuas Hulu', 550000);
INSERT INTO `ref_tarif_transport_darat` VALUES (251, 'Pontianak', 'Kab. Kayong Utara', 550000);
INSERT INTO `ref_tarif_transport_darat` VALUES (252, 'Pontianak', 'Kab. Ketapang', 550000);
INSERT INTO `ref_tarif_transport_darat` VALUES (253, 'Pontianak', 'Kab. Kubu Raya', 185000);
INSERT INTO `ref_tarif_transport_darat` VALUES (254, 'Pontianak', 'Kab. Landak', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (255, 'Pontianak', 'Kab. Melawi', 430000);
INSERT INTO `ref_tarif_transport_darat` VALUES (256, 'Pontianak', 'Kab. Mempawah', 230000);
INSERT INTO `ref_tarif_transport_darat` VALUES (257, 'Pontianak', 'Kab. Sambas', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (258, 'Pontianak', 'Kab. Sanggau', 303000);
INSERT INTO `ref_tarif_transport_darat` VALUES (259, 'Pontianak', 'Kab. Sekadau', 343000);
INSERT INTO `ref_tarif_transport_darat` VALUES (260, 'Pontianak', 'Kab. Sintang', 392000);
INSERT INTO `ref_tarif_transport_darat` VALUES (261, 'Pontianak', 'Kota Singkawang', 257000);
INSERT INTO `ref_tarif_transport_darat` VALUES (262, 'Palangkaraya', 'Kab. Barito Selatan', 290000);
INSERT INTO `ref_tarif_transport_darat` VALUES (263, 'Palangkaraya', 'Kab. Barito Timur', 333000);
INSERT INTO `ref_tarif_transport_darat` VALUES (264, 'Palangkaraya', 'Kab. Barito Utara', 425000);
INSERT INTO `ref_tarif_transport_darat` VALUES (265, 'Palangkaraya', 'Kab. Gunung Mas', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (266, 'Palangkaraya', 'Kab. Kapuas', 275000);
INSERT INTO `ref_tarif_transport_darat` VALUES (267, 'Palangkaraya', 'Kab. Katingan', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (268, 'Palangkaraya', 'Kab. Kotawaringin Barat', 425000);
INSERT INTO `ref_tarif_transport_darat` VALUES (269, 'Palangkaraya', 'Kab. Kotawaringin Timur', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (270, 'Palangkaraya', 'Kab. Lamandau', 525000);
INSERT INTO `ref_tarif_transport_darat` VALUES (271, 'Palangkaraya', 'Kab. Murung Raya', 448000);
INSERT INTO `ref_tarif_transport_darat` VALUES (272, 'Palangkaraya', 'Kab. Pulau Pisau', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (273, 'Palangkaraya', 'Kab. Seruyan', 328000);
INSERT INTO `ref_tarif_transport_darat` VALUES (274, 'Palangkaraya', 'Kab. Sukamara', 525000);
INSERT INTO `ref_tarif_transport_darat` VALUES (275, 'Banjarmasin', 'Kab. Balangan', 230000);
INSERT INTO `ref_tarif_transport_darat` VALUES (276, 'Banjarmasin', 'Kab. Banjar', 170000);
INSERT INTO `ref_tarif_transport_darat` VALUES (277, 'Banjarmasin', 'Kab. Barito Kuala', 200000);
INSERT INTO `ref_tarif_transport_darat` VALUES (278, 'Banjarmasin', 'Kab. Hulu Sungai Selatan', 200000);
INSERT INTO `ref_tarif_transport_darat` VALUES (279, 'Banjarmasin', 'Kab. Hulu Sungai Tengah', 212000);
INSERT INTO `ref_tarif_transport_darat` VALUES (280, 'Banjarmasin', 'Kab. Hulu Sungai Utara', 218000);
INSERT INTO `ref_tarif_transport_darat` VALUES (281, 'Banjarmasin', 'Kab. Kota Baru', 290000);
INSERT INTO `ref_tarif_transport_darat` VALUES (282, 'Banjarmasin', 'Kab. Tabalong', 234000);
INSERT INTO `ref_tarif_transport_darat` VALUES (283, 'Banjarmasin', 'Kab. Tanah Bumbu', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (284, 'Banjarmasin', 'Kab. Tanah Laut', 200000);
INSERT INTO `ref_tarif_transport_darat` VALUES (285, 'Banjarmasin', 'Kab. Tapin', 189000);
INSERT INTO `ref_tarif_transport_darat` VALUES (286, 'Banjarmasin', 'Kota Banjarbaru', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (287, 'Samarinda', 'Kab. Kutai Barat', 1500000);
INSERT INTO `ref_tarif_transport_darat` VALUES (288, 'Samarinda', 'Kab. Kutai Kartanegara', 500000);
INSERT INTO `ref_tarif_transport_darat` VALUES (289, 'Samarinda', 'Kab. Kutai Timur', 1350000);
INSERT INTO `ref_tarif_transport_darat` VALUES (290, 'Samarinda', 'Kab. Paser', 1650000);
INSERT INTO `ref_tarif_transport_darat` VALUES (291, 'Samarinda', 'Kab. Penajam Paser Utara', 650000);
INSERT INTO `ref_tarif_transport_darat` VALUES (292, 'Samarinda', 'Kota Balikpapan', 550000);
INSERT INTO `ref_tarif_transport_darat` VALUES (293, 'Samarinda', 'Kota Bontang', 600000);
INSERT INTO `ref_tarif_transport_darat` VALUES (294, 'Manado', 'Kab. Bolaang Mongondow', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (295, 'Manado', 'Kab. Bolaang Mongondow Selatan', 275000);
INSERT INTO `ref_tarif_transport_darat` VALUES (296, 'Manado', 'Kab. Bolaang Mongondow Timur', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (297, 'Manado', 'Kab. Bolaang Mongondow Utara', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (298, 'Manado', 'Kab. Minahasa', 180000);
INSERT INTO `ref_tarif_transport_darat` VALUES (299, 'Manado', 'Kab. Minahasa Selatan', 180000);
INSERT INTO `ref_tarif_transport_darat` VALUES (300, 'Manado', 'Kab. Minahasa Tenggara', 200000);
INSERT INTO `ref_tarif_transport_darat` VALUES (301, 'Manado', 'Kab. Minahasa Utara', 175000);
INSERT INTO `ref_tarif_transport_darat` VALUES (302, 'Manado', 'Kota Bitung', 175000);
INSERT INTO `ref_tarif_transport_darat` VALUES (303, 'Manado', 'Kota Kotamobagu', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (304, 'Manado', 'Kota Tomohon', 170000);
INSERT INTO `ref_tarif_transport_darat` VALUES (305, 'Gorontalo', 'Kab. Boalemo', 400000);
INSERT INTO `ref_tarif_transport_darat` VALUES (306, 'Gorontalo', 'Kab. Gorontalo', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (307, 'Gorontalo', 'Kab. Gorontalo Utara', 350000);
INSERT INTO `ref_tarif_transport_darat` VALUES (308, 'Gorontalo', 'Kab. Pahuwato', 650000);
INSERT INTO `ref_tarif_transport_darat` VALUES (309, 'Mamuju', 'Kab. Majene', 240000);
INSERT INTO `ref_tarif_transport_darat` VALUES (310, 'Mamuju', 'Kab. Mamasa', 359000);
INSERT INTO `ref_tarif_transport_darat` VALUES (311, 'Mamuju', 'Kab. Mamuju Tengah', 200000);
INSERT INTO `ref_tarif_transport_darat` VALUES (312, 'Mamuju', 'Kab. Mamuju utara', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (313, 'Mamuju', 'Kab. Polewali Mandar', 260000);
INSERT INTO `ref_tarif_transport_darat` VALUES (314, 'Makassar', 'Kab. Bantaeng', 235000);
INSERT INTO `ref_tarif_transport_darat` VALUES (315, 'Makassar', 'Kab. Barru', 210000);
INSERT INTO `ref_tarif_transport_darat` VALUES (316, 'Makassar', 'Kab. Bone', 240000);
INSERT INTO `ref_tarif_transport_darat` VALUES (317, 'Makassar', 'Kab. Bulukumba', 240000);
INSERT INTO `ref_tarif_transport_darat` VALUES (318, 'Makassar', 'Kab. Enrekang', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (319, 'Makassar', 'Kab. Gowa', 175000);
INSERT INTO `ref_tarif_transport_darat` VALUES (320, 'Makassar', 'Kab. Jeneponto', 230000);
INSERT INTO `ref_tarif_transport_darat` VALUES (321, 'Makassar', 'Kab. Luwu', 350000);
INSERT INTO `ref_tarif_transport_darat` VALUES (322, 'Makassar', 'Kab. Luwu Timur', 375000);
INSERT INTO `ref_tarif_transport_darat` VALUES (323, 'Makassar', 'Kab. Luwu Utara', 365000);
INSERT INTO `ref_tarif_transport_darat` VALUES (324, 'Makassar', 'Kab. Maros', 170000);
INSERT INTO `ref_tarif_transport_darat` VALUES (325, 'Makassar', 'Kab. Pinrang', 230000);
INSERT INTO `ref_tarif_transport_darat` VALUES (326, 'Makassar', 'Kab. Sidenreng Rappang', 230000);
INSERT INTO `ref_tarif_transport_darat` VALUES (327, 'Makassar', 'Kab. Sinjai', 235000);
INSERT INTO `ref_tarif_transport_darat` VALUES (328, 'Makassar', 'Kab. Soppeng', 235000);
INSERT INTO `ref_tarif_transport_darat` VALUES (329, 'Makassar', 'Kab. Takalar', 190000);
INSERT INTO `ref_tarif_transport_darat` VALUES (330, 'Makassar', 'Kab. Tanatoraja', 350000);
INSERT INTO `ref_tarif_transport_darat` VALUES (331, 'Makassar', 'Kab. Toraja Utara', 350000);
INSERT INTO `ref_tarif_transport_darat` VALUES (332, 'Makassar', 'Kab. Wajo', 230000);
INSERT INTO `ref_tarif_transport_darat` VALUES (333, 'Makassar', 'Kota Palopo', 350000);
INSERT INTO `ref_tarif_transport_darat` VALUES (334, 'Makassar', 'Kota Pare-Pare', 225000);
INSERT INTO `ref_tarif_transport_darat` VALUES (335, 'Palu', 'Kab. Luwuk', 400000);
INSERT INTO `ref_tarif_transport_darat` VALUES (336, 'Palu', 'Kab. Buol', 472000);
INSERT INTO `ref_tarif_transport_darat` VALUES (337, 'Palu', 'Kab. Donggala', 130000);
INSERT INTO `ref_tarif_transport_darat` VALUES (338, 'Palu', 'Kab. Morowali', 400000);
INSERT INTO `ref_tarif_transport_darat` VALUES (339, 'Palu', 'Kab. Morowali Utara', 400000);
INSERT INTO `ref_tarif_transport_darat` VALUES (340, 'Palu', 'Kab. Parigi Moutong', 250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (341, 'Palu', 'Kab. Poso', 280000);
INSERT INTO `ref_tarif_transport_darat` VALUES (342, 'Palu', 'Kab. Sigi', 219000);
INSERT INTO `ref_tarif_transport_darat` VALUES (343, 'Palu', 'Kab. Tojouna-Una', 350000);
INSERT INTO `ref_tarif_transport_darat` VALUES (344, 'Palu', 'Kab. Toli-Toli', 412000);
INSERT INTO `ref_tarif_transport_darat` VALUES (345, 'Kendari', 'Kab. Bombana', 355000);
INSERT INTO `ref_tarif_transport_darat` VALUES (346, 'Kendari', 'Kab. Kolaka', 370000);
INSERT INTO `ref_tarif_transport_darat` VALUES (347, 'Kendari', 'Kab. Kolaka Timur', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (348, 'Kendari', 'Kab. Kolaka Utara', 425000);
INSERT INTO `ref_tarif_transport_darat` VALUES (349, 'Kendari', 'Kab. Konawe', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (350, 'Kendari', 'Kab. Konawe Selatan', 305000);
INSERT INTO `ref_tarif_transport_darat` VALUES (351, 'Kendari', 'Kab. Konawe Utara', 300000);
INSERT INTO `ref_tarif_transport_darat` VALUES (352, 'Sofifi', 'Kab. Halmahera Barat', 850000);
INSERT INTO `ref_tarif_transport_darat` VALUES (353, 'Sofifi', 'Kab. Halmahera Tengah', 1000000);
INSERT INTO `ref_tarif_transport_darat` VALUES (354, 'Sofifi', 'Kab. Halmahera Timur', 1250000);
INSERT INTO `ref_tarif_transport_darat` VALUES (355, 'Sofifi', 'Kab. Halmahera Utara', 900000);
INSERT INTO `ref_tarif_transport_darat` VALUES (356, 'Jayapura', 'Kab. Jayapura', 600000);
INSERT INTO `ref_tarif_transport_darat` VALUES (357, 'Jayapura', 'Kab. Keerom', 900000);
INSERT INTO `ref_tarif_transport_darat` VALUES (358, 'Jayapura', 'Kab. Sarmi', 2700000);
INSERT INTO `ref_tarif_transport_darat` VALUES (359, 'Manokwari', 'Kab. Teluk Bintuni', 900000);
INSERT INTO `ref_tarif_transport_darat` VALUES (360, 'Manokwari', 'Kab. Manokwari Selatan', 750000);
INSERT INTO `ref_tarif_transport_darat` VALUES (361, 'Manokwari', 'Kab. Pegunungan Arfak', 265000);
INSERT INTO `ref_tarif_transport_darat` VALUES (362, 'Jakarta', 'Kota Bekasi', 256000);
INSERT INTO `ref_tarif_transport_darat` VALUES (363, 'Jakarta', 'Kab. Bekasi', 256000);
INSERT INTO `ref_tarif_transport_darat` VALUES (364, 'Jakarta', 'Kab. Bogor', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (365, 'Jakarta', 'Kota Bogor', 270000);
INSERT INTO `ref_tarif_transport_darat` VALUES (366, 'Jakarta', 'Kota Depok', 248000);
INSERT INTO `ref_tarif_transport_darat` VALUES (367, 'Jakarta', 'Kota Tangerang', 258000);
INSERT INTO `ref_tarif_transport_darat` VALUES (368, 'Jakarta', 'Kota Tangerang Selatan', 258000);
INSERT INTO `ref_tarif_transport_darat` VALUES (369, 'Jakarta', 'Kab. Tangerang', 279000);
INSERT INTO `ref_tarif_transport_darat` VALUES (370, 'Jakarta', 'Kepulauan Seribu', 386000);

-- ----------------------------
-- Table structure for ref_tarif_transport_provinsi
-- ----------------------------
DROP TABLE IF EXISTS `ref_tarif_transport_provinsi`;
CREATE TABLE `ref_tarif_transport_provinsi`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_provinsi` int(11) NOT NULL,
  `besaran` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `ref_tarif_transport_provinsi_id_provinsi_foreign`(`id_provinsi` ASC) USING BTREE,
  CONSTRAINT `ref_tarif_transport_provinsi_id_provinsi_foreign` FOREIGN KEY (`id_provinsi`) REFERENCES `ref_provinsi` (`id_provinsi`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of ref_tarif_transport_provinsi
-- ----------------------------
INSERT INTO `ref_tarif_transport_provinsi` VALUES (1, 1, 123000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (2, 2, 278000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (3, 3, 99000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (4, 4, 159000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (5, 5, 133000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (6, 6, 171000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (7, 7, 162000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (8, 8, 162000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (9, 9, 106000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (10, 10, 94000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (11, 11, 300000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (12, 12, 180000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (13, 13, 250000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (14, 14, 105000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (15, 15, 258000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (16, 16, 225000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (17, 17, 219000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (18, 18, 224000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (19, 19, 105000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (20, 20, 165000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (21, 21, 130000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (22, 22, 174000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (23, 23, 300000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (24, 24, 211000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (25, 25, 134000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (26, 26, 256000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (27, 27, 283000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (28, 28, 181000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (29, 29, 149000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (30, 30, 154000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (31, 31, 279000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (32, 32, 208000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (33, 33, 462000);
INSERT INTO `ref_tarif_transport_provinsi` VALUES (34, 34, 228000);

-- ----------------------------
-- Table structure for role_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_permissions`;
CREATE TABLE `role_permissions`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) UNSIGNED NOT NULL,
  `menu_id` bigint(20) UNSIGNED NOT NULL,
  `can_view` tinyint(1) NOT NULL DEFAULT 0,
  `can_create` tinyint(1) NOT NULL DEFAULT 0,
  `can_edit` tinyint(1) NOT NULL DEFAULT 0,
  `can_delete` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `role_permissions_role_id_menu_id_unique`(`role_id` ASC, `menu_id` ASC) USING BTREE,
  INDEX `role_permissions_menu_id_foreign`(`menu_id` ASC) USING BTREE,
  CONSTRAINT `role_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 58 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_permissions
-- ----------------------------
INSERT INTO `role_permissions` VALUES (25, 3, 7, 1, 0, 1, 0);
INSERT INTO `role_permissions` VALUES (26, 3, 6, 1, 0, 0, 0);
INSERT INTO `role_permissions` VALUES (27, 4, 7, 1, 0, 0, 0);
INSERT INTO `role_permissions` VALUES (28, 4, 6, 1, 0, 0, 0);
INSERT INTO `role_permissions` VALUES (37, 2, 7, 1, 1, 1, 0);
INSERT INTO `role_permissions` VALUES (38, 2, 6, 1, 1, 0, 0);
INSERT INTO `role_permissions` VALUES (39, 2, 13, 1, 1, 1, 0);
INSERT INTO `role_permissions` VALUES (40, 2, 8, 1, 0, 0, 0);
INSERT INTO `role_permissions` VALUES (46, 1, 1, 1, 1, 1, 1);
INSERT INTO `role_permissions` VALUES (47, 1, 2, 1, 1, 1, 1);
INSERT INTO `role_permissions` VALUES (48, 1, 4, 1, 1, 1, 1);
INSERT INTO `role_permissions` VALUES (49, 1, 5, 1, 1, 1, 1);
INSERT INTO `role_permissions` VALUES (50, 1, 6, 1, 1, 1, 1);
INSERT INTO `role_permissions` VALUES (51, 1, 7, 1, 1, 1, 1);
INSERT INTO `role_permissions` VALUES (52, 1, 8, 1, 1, 1, 1);
INSERT INTO `role_permissions` VALUES (53, 1, 13, 1, 1, 1, 1);
INSERT INTO `role_permissions` VALUES (54, 1, 14, 1, 1, 1, 1);
INSERT INTO `role_permissions` VALUES (55, 1, 15, 1, 1, 1, 1);
INSERT INTO `role_permissions` VALUES (56, 1, 16, 1, 1, 1, 1);
INSERT INTO `role_permissions` VALUES (57, 1, 17, 1, 1, 1, 1);

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES (1, 'Administrator', 'Administrator penuh', NULL, '2026-09-17 06:29:13');
INSERT INTO `roles` VALUES (2, 'Operator', 'Operator SPPD', NULL, NULL);
INSERT INTO `roles` VALUES (3, 'PPK', 'Pejabat Pembuat Komitmen', NULL, NULL);
INSERT INTO `roles` VALUES (4, 'Bendahara', 'Bendahara Pengeluaran', NULL, NULL);

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint(20) UNSIGNED NULL DEFAULT NULL,
  `ip_address` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `user_agent` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `payload` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `sessions_user_id_index`(`user_id` ASC) USING BTREE,
  INDEX `sessions_last_activity_index`(`last_activity` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sessions
-- ----------------------------
INSERT INTO `sessions` VALUES ('NCYlkxy2FzAEcndhPWk9LtFKQce0lV4uk28icyU4', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/152.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiJTY1Rkdkw4QXZRSWFpTGdHZldNczFld2F3R25tcmUwUzVtYUJmSGxRIiwidXJsIjpbXSwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwXC9hcGlcL2Rhc2hib2FyZFwvZmluYW5jaW5nP3RhaHVuPTIwMjYiLCJyb3V0ZSI6bnVsbH0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfSwibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiOjF9', 1789970564);

-- ----------------------------
-- Table structure for settings
-- ----------------------------
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `group` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'general',
  `key` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'text',
  `order` int(11) NOT NULL DEFAULT 0,
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `settings_key_unique`(`key` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of settings
-- ----------------------------
INSERT INTO `settings` VALUES (1, 'general', 'app_name', 'SPPD Bawaslu', 'Nama Aplikasi', 'text', 1, 1, '2026-09-03 06:45:41', '2026-09-17 06:15:09');
INSERT INTO `settings` VALUES (2, 'general', 'app_description', 'Bawaslu Kabupaten Pidie', 'Deskripsi Aplikasi', 'textarea', 2, 1, '2026-09-03 06:45:41', '2026-09-17 06:15:09');
INSERT INTO `settings` VALUES (3, 'general', 'app_logo', '/storage/settings/5jF4TD74F8qeOV5woM2Y4zpkZO4JCTmSzsGjC8S7.png', 'Logo', 'file', 3, 1, '2026-09-03 06:45:41', '2026-09-17 06:15:09');
INSERT INTO `settings` VALUES (4, 'general', 'app_favicon', '/storage/settings/t0nXjleoEwYWKwXeOuh4h3JxO9V9f8heWbZgK89w.png', 'Favicon', 'file', 4, 1, '2026-09-03 06:45:41', '2026-09-16 13:45:51');
INSERT INTO `settings` VALUES (5, 'contact', 'app_email', 'admin@bawaslu-pidie.go.id', 'Email', 'text', 1, 1, '2026-09-03 06:45:41', '2026-09-17 06:15:09');
INSERT INTO `settings` VALUES (6, 'contact', 'app_phone', '+62 853-XXXX-XXXX', 'No. Telepon', 'text', 2, 1, '2026-09-03 06:45:41', '2026-09-17 06:15:09');
INSERT INTO `settings` VALUES (7, 'contact', 'app_whatsapp', NULL, 'No. WhatsApp', 'text', 3, 1, '2026-09-03 06:45:41', '2026-09-17 06:15:09');
INSERT INTO `settings` VALUES (8, 'contact', 'app_address', 'Kabupaten Pidie, Provinsi Aceh', 'Alamat', 'textarea', 4, 1, '2026-09-03 06:45:41', '2026-09-17 06:15:09');
INSERT INTO `settings` VALUES (9, 'general', 'login_background', '/storage/settings/8o81LWhjBsnOezADEBjcO9M5g8YwLRiWdxyeSebB.png', 'Latar Halaman Login', 'file', 5, 1, '2026-09-06 08:43:42', '2026-09-16 13:45:51');
INSERT INTO `settings` VALUES (10, 'general', 'list_tahun', '2026,2027', 'Daftar Tahun', 'text', 6, 1, NULL, NULL);
INSERT INTO `settings` VALUES (11, 'general', 'default_tahun', '2026', 'Tahun Default', 'text', 7, 1, NULL, NULL);

-- ----------------------------
-- Table structure for tb_sppd
-- ----------------------------
DROP TABLE IF EXISTS `tb_sppd`;
CREATE TABLE `tb_sppd`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `nomor_sppd` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `tahun` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `atas_nama` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nip` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `pangkat_golongan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `jabatan` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `tanggal_mulai` date NOT NULL,
  `tanggal_selesai` date NOT NULL,
  `lama_hari` int(11) NOT NULL DEFAULT 0,
  `asal_daerah` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'Sigli',
  `jenis_sppd` enum('dalam','luar') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'luar',
  `tujuan_daerah` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `provinsi_tujuan` int(11) NOT NULL,
  `keperluan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `transport_udara` tinyint(1) NOT NULL DEFAULT 0,
  `transport_darat_pp` tinyint(1) NOT NULL DEFAULT 0,
  `taksi_bandara` tinyint(1) NOT NULL DEFAULT 0,
  `transport_kendaraan_dinas_pp` tinyint(1) NOT NULL DEFAULT 0,
  `golongan` enum('eselon_1','eselon_2','eselon_3','eselon_4') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `kota_asal_pesawat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `kota_tujuan_pesawat` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `file_surat_tugas` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `file_sppd` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `status` enum('draft','proses','selesai','batal') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'draft',
  `total_biaya` bigint(20) NOT NULL DEFAULT 0,
  `created_by` int(11) NULL DEFAULT NULL,
  `approved_by` int(11) NULL DEFAULT NULL,
  `paid_by` int(11) NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `tb_sppd_nomor_sppd_unique`(`nomor_sppd` ASC) USING BTREE,
  INDEX `tb_sppd_provinsi_tujuan_foreign`(`provinsi_tujuan` ASC) USING BTREE,
  CONSTRAINT `tb_sppd_provinsi_tujuan_foreign` FOREIGN KEY (`provinsi_tujuan`) REFERENCES `ref_provinsi` (`id_provinsi`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sppd
-- ----------------------------
INSERT INTO `tb_sppd` VALUES (1, 'SPPD-0001', 2026, 'Cut Nurul Husna, S.T.', '198103152004122002', 'Pembina / IV-a', 'Anggota Bawaslu Kab. Pidie', '2026-09-14', '2026-09-17', 4, 'Sigli', 'luar', 'Jakarta', 13, 'Perjalanan Dinas', 1, 0, 1, 0, 'eselon_3', 'Banda Aceh', 'Jakarta', NULL, NULL, 'draft', 15420000, 1, 1, 1, '2026-09-17 12:12:47', '2026-09-17 16:48:36');
INSERT INTO `tb_sppd` VALUES (2, '005/SPPD/BAWASLU-PD/I/2026', 2026, 'Fauzi, S.H., M.H.', '197501012000031001', 'Pembina Tk. I / IV-b', 'Ketua Bawaslu Kab. Pidie', '2026-01-12', '2026-01-16', 5, 'Sigli', 'luar', 'Jakarta', 13, 'Mengikuti Rapat Koordinasi Nasional Pengawasan Pemilu', 1, 0, 1, 0, 'eselon_2', 'Banda Aceh', 'Jakarta', NULL, NULL, 'selesai', 6150000, 1, 1, 1, '2026-08-18 01:28:11', '2026-09-18 01:28:11');
INSERT INTO `tb_sppd` VALUES (3, '008/SPPD/BAWASLU-PD/II/2026', 2026, 'Cut Nurul Husna, S.T.', '198103152004122002', 'Pembina / IV-a', 'Anggota Bawaslu Kab. Pidie', '2026-09-09', '2026-09-11', 3, 'Sigli', 'dalam', 'Medan', 2, 'Sosialisasi Pengawasan Partisipatif', 0, 1, 0, 0, 'eselon_3', NULL, NULL, NULL, NULL, 'draft', 4112000, 1, 1, 1, '2026-09-08 01:28:11', '2026-09-21 06:01:08');
INSERT INTO `tb_sppd` VALUES (4, '012/SPPD/BAWASLU-PD/III/2026', 2026, 'Teuku Ilhamsyah, S.IP.', '198506122009011003', 'Penata Tk. I / III-d', 'Sekretaris Bawaslu Kab. Pidie', '2026-03-03', '2026-03-04', 2, 'Sigli', 'luar', 'Banda Aceh', 1, 'Rapat Koordinasi Sekretariat Bawaslu Provinsi Aceh', 0, 1, 0, 0, 'eselon_3', NULL, NULL, NULL, NULL, 'proses', 800000, 1, NULL, NULL, '2026-07-17 01:28:11', '2026-09-18 01:28:11');
INSERT INTO `tb_sppd` VALUES (5, '015/SPPD/BAWASLU-PD/III/2026', 2026, 'Rahmad Hidayat, S.E.', '199002032014031004', 'Penata Muda Tk. I / III-b', 'Bendahara Pengeluaran', '2026-03-17', '2026-03-20', 4, 'Sigli', 'luar', 'Padang', 6, 'Bimbingan Teknis Administrasi Keuangan', 1, 0, 0, 0, 'eselon_4', 'Banda Aceh', 'Padang', NULL, NULL, 'proses', 6710000, 1, NULL, NULL, '2026-06-23 01:28:11', '2026-09-18 01:28:11');
INSERT INTO `tb_sppd` VALUES (6, '020/SPPD/BAWASLU-PD/VI/2026', 2026, 'Muliadi, S.Kom.', '199304182019031006', 'Pengatur / II-c', 'Staf Sekretariat', '2026-09-17', '2026-09-18', 2, 'Sigli', 'luar', 'Banda Aceh', 1, 'Mengantar dokumen ke Sekretariat Bawaslu Provinsi Aceh', 0, 0, 0, 0, 'eselon_4', NULL, NULL, NULL, NULL, 'draft', 190000, 1, NULL, NULL, '2026-08-30 01:28:11', '2026-09-18 11:27:11');
INSERT INTO `tb_sppd` VALUES (11, 'SPD-26090001', 2026, 'Muliadi, S.Kom.', '199304182019031006', 'Pengatur / II-c', 'Staf Sekretariat', '2026-09-20', '2026-09-25', 6, 'Sigli', 'luar', 'Banda Aceh', 1, 'Koordinasi Tentang SIRUP', 1, 1, 1, 0, 'eselon_3', 'Banda Aceh', 'Jakarta', NULL, NULL, 'draft', 20790000, 1, NULL, NULL, '2026-09-21 06:00:28', '2026-09-21 06:00:30');

-- ----------------------------
-- Table structure for tb_sppd_rincian
-- ----------------------------
DROP TABLE IF EXISTS `tb_sppd_rincian`;
CREATE TABLE `tb_sppd_rincian`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `id_sppd` bigint(20) UNSIGNED NOT NULL,
  `tahun` smallint(5) UNSIGNED NULL DEFAULT NULL,
  `jenis_biaya` enum('uang_harian','uang_saku','penginapan','transport_udara_pp','transport_udara_pergi','transport_udara_pulang','transport_darat','transport_dinas_pp','taksi_bandara','transport_lainnya') CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `uraian` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `hari` int(11) NOT NULL DEFAULT 1,
  `satuan` int(11) NOT NULL DEFAULT 0,
  `jumlah` int(11) NOT NULL DEFAULT 0,
  `keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `bukti` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `tb_sppd_rincian_id_sppd_foreign`(`id_sppd` ASC) USING BTREE,
  CONSTRAINT `tb_sppd_rincian_id_sppd_foreign` FOREIGN KEY (`id_sppd`) REFERENCES `tb_sppd` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 57 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tb_sppd_rincian
-- ----------------------------
INSERT INTO `tb_sppd_rincian` VALUES (19, 1, 2026, 'uang_harian', 'Uang Harian', 4, 530000, 2120000, 'Tingkat Satuan (4 hari)', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (20, 1, 2026, 'penginapan', 'Penginapan', 3, 1062000, 3186000, 'Terlampir', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (21, 1, 2026, 'transport_udara_pergi', 'Transportasi Udara (Pergi) BANDA ACEH - JAKARTA', 1, 4807000, 4807000, 'Terlampir', 'sppd/bukti/RTnnkH4VjOb2Q4Gi3gmuSoK03tVylXErnOajsHLo.png');
INSERT INTO `tb_sppd_rincian` VALUES (22, 1, 2026, 'transport_udara_pulang', 'Transportasi Udara (Pulang) JAKARTA - BANDA ACEH', 1, 4807000, 4807000, 'Terlampir', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (23, 1, 2026, 'taksi_bandara', 'Taksi Bandara Hotel-PP', 1, 500000, 500000, 'Terlampir', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (24, 2, 2026, 'uang_harian', 'Uang harian dinas luar kota', 5, 370000, 1850000, NULL, NULL);
INSERT INTO `tb_sppd_rincian` VALUES (25, 2, 2026, 'penginapan', 'Sewa hotel 4 malam', 4, 500000, 2000000, 'Hotel Santika Jakarta', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (26, 2, 2026, 'transport_udara_pp', 'Tiket pesawat PP Banda Aceh - Jakarta', 1, 2000000, 2000000, 'Maskapai Garuda Indonesia', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (27, 2, 2026, 'taksi_bandara', 'Taksi bandara PP', 2, 150000, 300000, NULL, NULL);
INSERT INTO `tb_sppd_rincian` VALUES (31, 4, 2026, 'uang_harian', 'Uang harian dinas luar kota', 2, 300000, 600000, NULL, NULL);
INSERT INTO `tb_sppd_rincian` VALUES (32, 4, 2026, 'transport_dinas_pp', 'Transport dinas Sigli - Banda Aceh PP', 1, 200000, 200000, NULL, NULL);
INSERT INTO `tb_sppd_rincian` VALUES (33, 5, 2026, 'uang_harian', 'Uang harian dinas luar kota', 4, 340000, 1360000, NULL, NULL);
INSERT INTO `tb_sppd_rincian` VALUES (34, 5, 2026, 'penginapan', 'Sewa hotel 3 malam', 3, 450000, 1350000, 'Hotel Pangeran Padang', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (35, 5, 2026, 'transport_udara_pergi', 'Tiket pesawat Banda Aceh - Padang', 1, 1800000, 1800000, 'Maskapai Lion Air', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (36, 5, 2026, 'transport_udara_pulang', 'Tiket pesawat Padang - Banda Aceh', 1, 1800000, 1800000, 'Maskapai Lion Air', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (37, 5, 2026, 'uang_saku', 'Uang saku', 4, 100000, 400000, NULL, NULL);
INSERT INTO `tb_sppd_rincian` VALUES (40, 6, 2026, 'uang_harian', 'Uang harian dalam kota lebih 8 jam', 1, 90000, 90000, NULL, NULL);
INSERT INTO `tb_sppd_rincian` VALUES (41, 6, 2026, 'transport_darat', 'Transport Sigli - Banda Aceh PP', 1, 100000, 100000, NULL, NULL);
INSERT INTO `tb_sppd_rincian` VALUES (46, 11, NULL, 'uang_harian', 'Uang Harian', 6, 360000, 2160000, 'Tingkat Satuan (6 hari)', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (47, 11, NULL, 'penginapan', 'Penginapan', 5, 1578000, 7890000, 'Terlampir', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (48, 11, NULL, 'transport_udara_pergi', 'Transportasi Udara (Pergi) BANDA ACEH - JAKARTA', 1, 4807000, 4807000, 'Terlampir', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (49, 11, NULL, 'transport_udara_pulang', 'Transportasi Udara (Pulang) JAKARTA - BANDA ACEH', 1, 4807000, 4807000, 'Terlampir', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (50, 11, NULL, 'transport_darat', 'Dari Sigli - Banda Aceh', 1, 380000, 380000, 'PP', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (51, 11, NULL, 'transport_darat', 'Dari Banda Aceh - Bandara SIM', 1, 246000, 246000, 'PP', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (52, 11, NULL, 'taksi_bandara', 'Taksi Bandara Hotel-PP', 1, 500000, 500000, 'Terlampir', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (53, 3, NULL, 'uang_harian', 'Uang Harian', 3, 370000, 1110000, 'Tingkat Satuan (3 hari)', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (54, 3, NULL, 'penginapan', 'Penginapan', 2, 1188000, 2376000, 'Terlampir', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (55, 3, NULL, 'transport_darat', 'Dari Sigli - Banda Aceh', 1, 380000, 380000, 'PP', NULL);
INSERT INTO `tb_sppd_rincian` VALUES (56, 3, NULL, 'transport_darat', 'Dari Banda Aceh - Bandara SIM', 1, 246000, 246000, 'PP', NULL);

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `role_id` int(11) NULL DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `remember_token` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `users_email_unique`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, 'Hendra Sagita', 'admin@bawaslupidie.id', 1, NULL, '$2y$12$NWxl3Gg1TcMovlKJ.Q6sJ.3y2beTMDZD5U9eZxt4ZWlotalIznUKu', 'avatars/UA7vXNErf5LQHsxyIzxlfFa4CP8IFwpUw6Rigee4.png', NULL, NULL, '2026-09-17 06:29:41');

SET FOREIGN_KEY_CHECKS = 1;
