-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 05, 2024 at 03:34 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_ecommerce`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cart_items`
--

CREATE TABLE `cart_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `order_id` varchar(255) DEFAULT NULL,
  `user_id` bigint(20) UNSIGNED NOT NULL,
  `product_id` bigint(20) UNSIGNED NOT NULL,
  `qty` int(11) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` enum('unpaid','paid') NOT NULL DEFAULT 'unpaid',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

CREATE TABLE `failed_jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) UNSIGNED NOT NULL,
  `reserved_at` int(10) UNSIGNED DEFAULT NULL,
  `available_at` int(10) UNSIGNED NOT NULL,
  `created_at` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2024_07_30_070219_create_products_table', 1),
(5, '2024_08_02_071303_create_cart_items_table', 2),
(6, '2024_08_05_093956_add_order_id_to_cart_items_table', 3);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `description` text NOT NULL,
  `price` bigint(20) NOT NULL,
  `stock` int(11) NOT NULL DEFAULT 0,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `image`, `description`, `price`, `stock`, `status`, `created_at`, `updated_at`) VALUES
(1, 'Lenovo V14 Ryzen 3 7320U', '2dEWE6rqTRUpfp0vr7cztci8d5YxULFOFZ8NDoR5.jpg', '<p>Lenovo V14 Ryzen 3 7320U 256GB SSD 8GB Win11+OHS<br />\r\n<br />\r\nLenovo V14 G4 AMN<br />\r\nPart Number : 82YT000FID</p>', 5699000, 5, 'active', '2024-07-30 19:59:06', '2024-07-30 20:55:48'),
(4, 'Lenovo Ideapad 5i 2IN1 Intel 5 120U 512GB SSD 16GB', '2WP5zn5IQayMo5zWA0y2tTXa8NMAMQmXmnqpJ3VX.jpg', '<p>Lenovo Ideapad 5i 2IN1 Intel 5 120U 512GB SSD 16GB IPS Touch Win11+OHS<br />\r\n<br />\r\nIdeaPad 5 2-in-1 14IRU9<br />\r\nPart Number :<br />\r\n83DT0009ID - Cosmic Blue<br />\r\n83DT000AID - Luna Grey<br />\r\n<br />\r\nGARANSI RESMI LENOVO INDONESA 2 TAHUN + ADP<br />\r\n<br />\r\nProcessor : Intel&reg; Core&trade; 5 120U, 10C (2P + 8E) / 12T, P-core 1.4 / 5.0GHz, E-core 0.9 / 3.8GHz, 12MB<br />\r\nGraphics: Integrated Intel&reg; Graphics<br />\r\nChipset: Intel&reg; SoC Platform<br />\r\nMemory: 16GB Soldered LPDDR5x-5200<br />\r\nMemory Slots: Memory soldered to systemboard, no slots, dual-channel<br />\r\nMax Memory: 16GB soldered memory, not upgradable<br />\r\nStorage: 512GB SSD M.2 2242 PCIe&reg; 4.0x4 NVMe&reg;<br />\r\nStorage Support: One drive, up to 1TB M.2 2242 SSD<br />\r\nStorage Slot: One M.2 2242 PCIe&reg; 4.0 x4 slot<br />\r\nCard Reader: microSD Card Reader<br />\r\nAudio Chip: High Definition (HD) Audio, Realtek&reg; ALC3287 codec<br />\r\nSpeakers: Stereo speakers, 2W x2, optimized with Dolby&reg; Audio&trade;<br />\r\nCamera: FHD 1080p with Privacy Shutter<br />\r\nMicrophone: 2x, Array<br />\r\nBattery: Integrated 57Wh<br />\r\nPower Adapter: 65W USB-C&reg; (3-pin)</p>', 13000000, 0, 'active', '2024-07-31 00:45:04', '2024-07-31 06:27:38'),
(5, '[ADD ON RAM 8GB dan SCREEN] ASUS Vivobook 14 A1404ZA-VIPS354 - Quiet Blue [Intel Core i3-1215U / Intel UHD Graphics / 8GB / 512GB / 14inch / WIN11 / OHS]', '3Frnl1bYkf6Pwp8mpG74Y5FEGuyT2dvJBclEf32E.jpg', '<p>ASUS Vivobook 14 A1404ZA-VIPS354 - Quiet Blue [Intel&reg; Core&trade; i3-1215U / Intel&reg; UHD Graphics / 8GB / 512GB / 14inch / WIN11 / OHS] + ADD ON RAM 8GB dan Screen Protector<br />\r\n<br />\r\nOperating System : Windows 11 Home<br />\r\nOffice : Microsoft Office Home &amp; Student 2021<br />\r\n<br />\r\nLCD cover-material : Plastic<br />\r\nLCD cover-color : Quiet Blue<br />\r\nMilitary grade : US MIL-STD 810H military-grade standard<br />\r\nTouch Panel : Non-touch screen<br />\r\nDisplay : 14.0-inch FHD (1920 x 1080) 16:9 aspect ratio LED Backlit IPS-level Panel 60Hz refresh rate 250nits 45% NTSC color gamut Anti-glare display<br />\r\nScreen-to-body ratio : 82%<br />\r\n<br />\r\nIntel Athena Program : N/A<br />\r\nProcessor : Intel&reg; Core&trade; i3-1215U Processor 1.2 GHz (10M Cache, up to 4.4 GHz, 6 cores)<br />\r\nIntergrated GPU : Intel&reg; UHD Graphics<br />\r\nGraphics : N/A<br />\r\nVRAM : N/A<br />\r\nTotal System Memory : DDR4 8GB<br />\r\nOn board Memory : 8GB DDR4 on board<br />\r\nDIMM Memory : N/A<br />\r\nStorage : 512GB M.2 NVMe&trade; PCIe&reg; 4.0 SSD<br />\r\nHow to upgrade memory : N/A<br />\r\nExpansion Slot (includes used) :<br />\r\n1x DDR4 SO-DIMM slot<br />\r\n1x M.2 2280 PCIe 4.0x4</p>', 7505000, 10, 'active', '2024-07-31 19:11:42', '2024-07-31 19:11:42'),
(6, 'ASUS VivoBook 14 A1400EA-FHD323 - Indie Black [Intel Core i3-1115G4 / Intel UHD Graphics / 8GB / 256GB / 14inch / WIN11 / OHS]', '0VfE7uHhPu7wF9rdzdwV3Z1IyrwvnaxrTvhVCAnk.jpg', '<p>ASUS VivoBook 14 A1400EA-FHD323 - Indie Black [Intel Core i3-1115G4 / Intel UHD Graphics / 8GB / 256GB / 14inch / WIN11 / OHS]<br />\r\n<br />\r\nFREE Fantech Mouse Wireless GO<br />\r\n*Selama persediaan masih ada<br />\r\n<br />\r\n- Super Thin laptop with Full I/O ports<br />\r\n- Ultra Ligthweight with Dual Storage design<br />\r\n- NanoEdge Bezel with 82% Screen to body Ratio<br />\r\n<br />\r\nOS : Windows 11 Home<br />\r\nOffice : Office Home and Student 2021 included<br />\r\nLCD cover-color : Indie Black<br />\r\nTop case-material : Plastic<br />\r\nMilitary grade : N/A<br />\r\n<br />\r\nTouch Panel : Non-touch screen<br />\r\nDisplay : 14.0-inch FHD (1920 x 1080) 16:9 aspect ratio LED Backlit 60Hz refresh rate 220nits 45% NTSC color gamut Anti-glare display<br />\r\n<br />\r\nIntel Athena Program : N/A<br />\r\nProcessor : Intel Core i3-1115G4 Processor 3.0 GHz (6M Cache, up to 4.1 GHz, 2 cores)<br />\r\nIntergrated GPU : Intel UHD Graphics<br />\r\nGraphics : N/A<br />\r\nVRAM : N/A<br />\r\nTotal System Memory : DDR4 8GB<br />\r\nOn board memory : 8GB DDR4 on board<br />\r\nDIMM Memory :<br />\r\nStorage : 256GB M.2 NVMe PCIe 3.0 SSD<br />\r\nHow to upgrade memory : Upgradable - Need to remove bottom/top case<br />\r\n<br />\r\nExpansion Slot(includes used) :<br />\r\n1x DDR4 SO-DIMM slot<br />\r\n1x M.2 2280 PCIe 3.0x2<br />\r\n1x STD 2.5 SATA HDD</p>', 6200000, 4, 'active', '2024-07-31 19:12:59', '2024-07-31 19:12:59'),
(7, 'ASUS Zenbook 14 OLED UX3405MA-OLEDS714T - Foggy Silver', 'BQc5pvIWkswZ6o7gFciiJ6evBUAqGEu00iqlwrvB.jpg', '<p>ASUS Zenbook 14 OLED UX3405MA-OLEDS714T - Foggy Silver [Intel Core Ultra 7 Processor 155H / Intel Arc Graphics / 32GB / 1TB / 14inch / WIN11 / OHS]<br />\r\n<br />\r\nFREE AUKEY TWS Bluetooth EP-M2<br />\r\n*Selama persediaan masih ada<br />\r\n<br />\r\nOperating System : Windows 11 Home<br />\r\nOffice: Microsoft Office Home &amp; Student 2021<br />\r\nLCD cover-material : Aluminum<br />\r\nLCD cover-color : Foggy Silver<br />\r\n<br />\r\nMilitary grade : US MIL-STD 810H military-grade standard<br />\r\nDisplay : Touch screen 14.0-inch 3K (2880 x 1800) OLED 16:10 aspect ratio 120Hz refresh rate 400nits 100% DCI-P3 color gamut Glossy display<br />\r\n<br />\r\nIntel Athena Program : Intel Evo Platform<br />\r\nProcessor : Intel Core Ultra 7 Processor 155H 1.4 GHz (24MB Cache, up to 4.8 GHz, 16 cores, 22 Threads) Intel AI Boost NPU<br />\r\nIntergrated GPU : Intel Arc Graphics<br />\r\nTotal System Memory : LPDDR5X 32GB<br />\r\nOn board memory : 32GB LPDDR5X on board<br />\r\nStorage : 1TB M.2 NVMe PCIe 4.0 SSD<br />\r\nHow to upgrade memory : N/A<br />\r\nExpansion Slot(includes used) : N/A<br />\r\n<br />\r\nFront-facing camera : FHD camera with IR function to support Windows Hello With privacy shutter&quot;<br />\r\nWireless : N/A<br />\r\nNumberPad : N/A<br />\r\nScreenPad: N/A<br />\r\nFingerPrint : N/A<br />\r\n<br />\r\nI/O ports :<br />\r\n1x USB 3.2 Gen 1 Type-A<br />\r\n2x Thunderbolt 4 supports display / power delivery<br />\r\n1x HDMI 2.1 TMDS<br />\r\n1x 3.5mm Combo Audio Jack<br />\r\n<br />\r\nAudio :<br />\r\nSmart Amp Technology<br />\r\nBuilt-in speaker<br />\r\nBuilt-in array microphone<br />\r\nharman/kardon (Premium)</p>', 22200000, 6, 'active', '2024-07-31 19:15:02', '2024-07-31 19:15:02'),
(8, 'ASUS Vivobook 14 A1402ZA-IPS752 - Terra Cotta', 'mEhkIkASpheO1jYAk6SLiJKVRyPs5fPqEaNBLAl4.jpg', '<p>ASUS Vivobook 14 A1402ZA-IPS752 - Terra Cotta [Intel Core i7-1260P / Intel UHD Graphics / 8GB / 512GB / 14inch / WIN11 / OHS]<br />\r\n<br />\r\nOperating System : Windows 11 Home - ASUS recommends Windows 11 Pro for business<br />\r\nOffice : Office Home and Student 2021 included<br />\r\n<br />\r\nLCD cover-material : Plastic<br />\r\nLCD cover-color : Terra Cotta<br />\r\nTop case-material : Plastic<br />\r\n<br />\r\nMilitary grade : US MIL-STD 810H military-grade standard<br />\r\nDisplay : 14.0-inch FHD (1920 x 1080) 16:9 aspect ratio LED Backlit IPS-level Panel 250nits 100% sRGB color gamut<br />\r\nScreen-to-body ratio : 82<br />\r\n<br />\r\nProcessor : Intel Core i7-1260P Processor 2.1 GHz (18M Cache, up to 4.7 GHz, 4P+8E cores)<br />\r\nIntergrated GPU : Intel UHD Graphics<br />\r\nTotal System Memory : 8GB DDR4 on board<br />\r\nOn board memory : 8GB DDR4 on board<br />\r\nStorage : 512GB M.2 NVMe PCIe 3.0 SSD<br />\r\n<br />\r\nHow to upgrade memory : N/A<br />\r\nExpansion Slot(includes used) :<br />\r\n1x DDR4 SO-DIMM slot<br />\r\n1x M.2 2280 PCIe 4.0x4<br />\r\n<br />\r\nOptical Drive : N/A<br />\r\nFront-facing camera : 720p HD camera With privacy shutter<br />\r\nWireless : Wi-Fi 6(802.11ax) (Dual band) 2*2 + Bluetooth 5<br />\r\nKeyboard type : Backlit Chiclet Keyboard<br />\r\nNumberPad : N/A<br />\r\nScreenPad : N/A<br />\r\nFingerPrint : FingerPrint<br />\r\n<br />\r\nI/O ports :<br />\r\n1x USB 2.0 Type-A<br />\r\n1x USB 3.2 Gen 1 Type-C<br />\r\n2x USB 3.2 Gen 1 Type-A<br />\r\n1x HDMI 1.4<br />\r\n1x 3.5mm Combo Audio Jack<br />\r\n1x DC-in<br />\r\n<br />\r\nAudio :<br />\r\nSonicMaster<br />\r\nBuilt-in speaker<br />\r\nBuilt-in array microphone<br />\r\nVoice control : with Cortana and Alexa voice-recognition support</p>', 11699000, 8, 'active', '2024-07-31 19:16:31', '2024-07-31 19:16:59'),
(9, 'Lenovo Thinkbook 14s Yoga G3 IRU i7-1355U 1TB SSD 16GB 100%sRGB Touch', 'aIQoSM1JDm9kOOS8kx68SVbXn3oM3N3pJsBZt90G.jpg', '<p>Ini laptop Lenovo Thinkbook 14s Yoga G3</p>', 5400000, 7, 'active', '2024-08-05 05:26:49', '2024-08-05 05:27:10');

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('4pyTX9X1ALgu69huH700cBW0CsSbVti5vs52lyTX', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:127.0) Gecko/20100101 Firefox/127.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiTHdGVVIwenh2QmgzYlAyS3RvQUZ0cnRsNTMxMzBNMUQ4akVjWUdDWiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1722855496),
('GFc3o5cGBmXd0HC7ncb2Po8IHifYgLxgxSnCfnOk', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNEdVS1BWVDEwNHFVQ2xqSXRWbWRyb01QT01iQW0yT0RNU0VVWDE5eiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1722861671),
('wKaH8FCagi1kd3dzC7lxHrR2aMn8VBtvEmZrRlg0', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiRTBKUWl4cmhVSTg4QUZ6ekZLUTg5SzI1RTJ1dXVKOWlsQ0dscWl3SSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzU6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMC9jYXJ0L2NoZWNrb3V0Ijt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7fQ==', 1722860914),
('WPaHnOE1IShO0VCpEiBAxXyfKqy4Y5gqAiZdPH9H', 2, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/127.0.0.0 Safari/537.36', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoidkNCWXh2eU1TcUZMWGd0SjRzREFwSnhaTDBFOU5jTVVUTzJTV1BjayI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MjE6Imh0dHA6Ly9sb2NhbGhvc3Q6ODAwMCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjI7czozOiJ1cmwiO2E6MDp7fX0=', 1722853944);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `role` enum('admin','customer') NOT NULL DEFAULT 'customer',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `role`, `created_at`, `updated_at`) VALUES
(1, 'Admin', 'admin213@gmail.com', NULL, '$2y$12$PJd/LBwoBQ8GoP5wn9VjHO9zlicVpDS7uVCMU.FjUshXsqdBDokTi', NULL, 'admin', '2024-07-31 05:30:33', '2024-07-31 05:30:33'),
(2, 'Sinta', 'sinta@mail.com', NULL, '$2y$12$a7XRWjRsqaXxENsL9xjOqO4E7WA8WuQ/vo7hP3bN4yhjO/u34KlY2', NULL, 'customer', '2024-08-01 21:19:51', '2024-08-01 21:19:51');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cache`
--
ALTER TABLE `cache`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cache_locks`
--
ALTER TABLE `cache_locks`
  ADD PRIMARY KEY (`key`);

--
-- Indexes for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cart_items_user_id_foreign` (`user_id`),
  ADD KEY `cart_items_product_id_foreign` (`product_id`);

--
-- Indexes for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `jobs_queue_index` (`queue`);

--
-- Indexes for table `job_batches`
--
ALTER TABLE `job_batches`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_reset_tokens`
--
ALTER TABLE `password_reset_tokens`
  ADD PRIMARY KEY (`email`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sessions`
--
ALTER TABLE `sessions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `sessions_user_id_index` (`user_id`),
  ADD KEY `sessions_last_activity_index` (`last_activity`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cart_items`
--
ALTER TABLE `cart_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `failed_jobs`
--
ALTER TABLE `failed_jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cart_items`
--
ALTER TABLE `cart_items`
  ADD CONSTRAINT `cart_items_product_id_foreign` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `cart_items_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
