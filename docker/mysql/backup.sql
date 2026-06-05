-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: May 18, 2026 at 06:22 PM
-- Server version: 8.4.7
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `vehicle_booking`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
CREATE TABLE IF NOT EXISTS `bookings` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_id` bigint UNSIGNED NOT NULL,
  `branch_id` bigint UNSIGNED NOT NULL,
  `destination` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `purpose` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `estimated_distance` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `requires_allowance` tinyint(1) NOT NULL DEFAULT '0',
  `remarks` text COLLATE utf8mb4_unicode_ci,
  `start_time` datetime NOT NULL,
  `end_time` datetime NOT NULL,
  `status` enum('pending','approved','on_trip','completed','rejected') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bookings_user_id_foreign` (`user_id`),
  KEY `bookings_branch_id_foreign` (`branch_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`id`, `user_id`, `branch_id`, `destination`, `purpose`, `estimated_distance`, `requires_allowance`, `remarks`, `start_time`, `end_time`, `status`, `created_at`, `updated_at`) VALUES
(1, 4, 2, 'cdd', 'dfdf', NULL, 0, NULL, '2026-05-18 22:40:00', '2026-05-18 22:43:00', 'approved', '2026-05-18 17:09:51', '2026-05-18 17:09:58');

-- --------------------------------------------------------

--
-- Table structure for table `branches`
--

DROP TABLE IF EXISTS `branches`;
CREATE TABLE IF NOT EXISTS `branches` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `logo_path` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `branches`
--

INSERT INTO `branches` (`id`, `name`, `logo_path`, `created_at`, `updated_at`) VALUES
(2, 'Administration Branch', NULL, '2026-05-18 16:58:01', '2026-05-18 16:58:01'),
(3, 'Land Branch', NULL, '2026-05-18 16:58:09', '2026-05-18 16:58:09'),
(4, 'Social Services Branch', NULL, '2026-05-18 16:58:21', '2026-05-18 16:58:29'),
(5, 'Account Branch', NULL, '2026-05-18 16:58:39', '2026-05-18 16:58:39'),
(6, 'Registar Branch', NULL, '2026-05-18 16:58:54', '2026-05-18 16:58:54'),
(7, 'NIC Branch', NULL, '2026-05-18 16:59:04', '2026-05-18 16:59:04'),
(8, 'Development Branch', NULL, '2026-05-18 16:59:19', '2026-05-18 16:59:19'),
(9, 'Field Branch', NULL, '2026-05-18 16:59:32', '2026-05-18 16:59:32'),
(10, 'Grama Niladari Branch', NULL, '2026-05-18 16:59:54', '2026-05-18 16:59:54'),
(11, 'Praja Shakthi Branch', NULL, '2026-05-18 17:00:18', '2026-05-18 17:00:18'),
(12, 'Samuddhi Branch', NULL, '2026-05-18 17:00:28', '2026-05-18 17:00:28');

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
CREATE TABLE IF NOT EXISTS `cache` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_expiration_index` (`expiration`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `cache`
--

INSERT INTO `cache` (`key`, `value`, `expiration`) VALUES
('laravel-cache-ac3478d69a3c81fa62e60f5c3696165a4e5e6ac4:timer', 'i:1779120820;', 1779120820),
('laravel-cache-ac3478d69a3c81fa62e60f5c3696165a4e5e6ac4', 'i:1;', 1779120820),
('laravel-cache-c1dfd96eea8cc2b62785275bca38ac261256e278:timer', 'i:1779120820;', 1779120820),
('laravel-cache-c1dfd96eea8cc2b62785275bca38ac261256e278', 'i:1;', 1779120820),
('laravel-cache-ayomi1@gmail.com|127.0.0.1:timer', 'i:1779121575;', 1779121575),
('laravel-cache-ayomi1@gmail.com|127.0.0.1', 'i:2;', 1779121575),
('laravel-cache-super_admin|127.0.0.1:timer', 'i:1779127808;', 1779127808),
('laravel-cache-super_admin|127.0.0.1', 'i:1;', 1779127808),
('laravel-cache-test@example.com|127.0.0.1:timer', 'i:1779121706;', 1779121706),
('laravel-cache-test@example.com|127.0.0.1', 'i:1;', 1779121706),
('laravel-cache-boost:mcp:database-schema:mysql:users:0:0:0:0', 'a:2:{s:6:\"engine\";s:5:\"mysql\";s:6:\"tables\";a:1:{s:5:\"users\";a:5:{s:7:\"columns\";a:16:{s:2:\"id\";a:1:{s:4:\"type\";s:15:\"bigint unsigned\";}s:9:\"branch_id\";a:1:{s:4:\"type\";s:15:\"bigint unsigned\";}s:4:\"name\";a:1:{s:4:\"type\";s:12:\"varchar(191)\";}s:11:\"designation\";a:1:{s:4:\"type\";s:12:\"varchar(191)\";}s:5:\"email\";a:1:{s:4:\"type\";s:12:\"varchar(191)\";}s:8:\"username\";a:1:{s:4:\"type\";s:12:\"varchar(191)\";}s:17:\"email_verified_at\";a:1:{s:4:\"type\";s:9:\"timestamp\";}s:8:\"password\";a:1:{s:4:\"type\";s:12:\"varchar(191)\";}s:15:\"current_team_id\";a:1:{s:4:\"type\";s:15:\"bigint unsigned\";}s:17:\"two_factor_secret\";a:1:{s:4:\"type\";s:4:\"text\";}s:25:\"two_factor_recovery_codes\";a:1:{s:4:\"type\";s:4:\"text\";}s:23:\"two_factor_confirmed_at\";a:1:{s:4:\"type\";s:9:\"timestamp\";}s:4:\"role\";a:1:{s:4:\"type\";s:68:\"enum(\'super_admin\',\'top_management\',\'transport_admin\',\'branch_user\')\";}s:14:\"remember_token\";a:1:{s:4:\"type\";s:12:\"varchar(100)\";}s:10:\"created_at\";a:1:{s:4:\"type\";s:9:\"timestamp\";}s:10:\"updated_at\";a:1:{s:4:\"type\";s:9:\"timestamp\";}}s:7:\"indexes\";a:5:{s:7:\"primary\";a:4:{s:7:\"columns\";a:1:{i:0;s:2:\"id\";}s:4:\"type\";s:5:\"btree\";s:9:\"is_unique\";b:1;s:10:\"is_primary\";b:1;}s:23:\"users_branch_id_foreign\";a:4:{s:7:\"columns\";a:1:{i:0;s:9:\"branch_id\";}s:4:\"type\";s:5:\"btree\";s:9:\"is_unique\";b:0;s:10:\"is_primary\";b:0;}s:29:\"users_current_team_id_foreign\";a:4:{s:7:\"columns\";a:1:{i:0;s:15:\"current_team_id\";}s:4:\"type\";s:5:\"btree\";s:9:\"is_unique\";b:0;s:10:\"is_primary\";b:0;}s:18:\"users_email_unique\";a:4:{s:7:\"columns\";a:1:{i:0;s:5:\"email\";}s:4:\"type\";s:5:\"btree\";s:9:\"is_unique\";b:1;s:10:\"is_primary\";b:0;}s:21:\"users_username_unique\";a:4:{s:7:\"columns\";a:1:{i:0;s:8:\"username\";}s:4:\"type\";s:5:\"btree\";s:9:\"is_unique\";b:1;s:10:\"is_primary\";b:0;}}s:12:\"foreign_keys\";a:0:{}s:8:\"triggers\";a:0:{}s:17:\"check_constraints\";a:0:{}}}}', 1779122862),
('laravel-cache-boost:mcp:database-schema:mysql:branches:0:0:0:0', 'a:2:{s:6:\"engine\";s:5:\"mysql\";s:6:\"tables\";a:1:{s:8:\"branches\";a:5:{s:7:\"columns\";a:5:{s:2:\"id\";a:1:{s:4:\"type\";s:15:\"bigint unsigned\";}s:4:\"name\";a:1:{s:4:\"type\";s:12:\"varchar(191)\";}s:9:\"logo_path\";a:1:{s:4:\"type\";s:12:\"varchar(191)\";}s:10:\"created_at\";a:1:{s:4:\"type\";s:9:\"timestamp\";}s:10:\"updated_at\";a:1:{s:4:\"type\";s:9:\"timestamp\";}}s:7:\"indexes\";a:1:{s:7:\"primary\";a:4:{s:7:\"columns\";a:1:{i:0;s:2:\"id\";}s:4:\"type\";s:5:\"btree\";s:9:\"is_unique\";b:1;s:10:\"is_primary\";b:1;}}s:12:\"foreign_keys\";a:0:{}s:8:\"triggers\";a:0:{}s:17:\"check_constraints\";a:0:{}}}}', 1779122870);

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE IF NOT EXISTS `cache_locks` (
  `key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `owner` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `expiration` bigint NOT NULL,
  PRIMARY KEY (`key`),
  KEY `cache_locks_expiration_index` (`expiration`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE IF NOT EXISTS `failed_jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
CREATE TABLE IF NOT EXISTS `jobs` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempts` smallint UNSIGNED NOT NULL,
  `reserved_at` int UNSIGNED DEFAULT NULL,
  `available_at` int UNSIGNED NOT NULL,
  `created_at` int UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE IF NOT EXISTS `job_batches` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_jobs` int NOT NULL,
  `pending_jobs` int NOT NULL,
  `failed_jobs` int NOT NULL,
  `failed_job_ids` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `options` mediumtext COLLATE utf8mb4_unicode_ci,
  `cancelled_at` int DEFAULT NULL,
  `created_at` int NOT NULL,
  `finished_at` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
CREATE TABLE IF NOT EXISTS `migrations` (
  `id` int UNSIGNED NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2025_08_14_170933_add_two_factor_columns_to_users_table', 1),
(5, '2026_01_27_000001_create_teams_table', 1),
(6, '2026_01_27_000002_add_current_team_id_to_users_table', 1),
(7, '2026_05_13_183330_create_bookings_table', 1),
(8, '2026_05_17_201806_add_username_to_users_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE IF NOT EXISTS `password_reset_tokens` (
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
CREATE TABLE IF NOT EXISTS `sessions` (
  `id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_agent` text COLLATE utf8mb4_unicode_ci,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_activity` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('E5nijl6DPWDSHmBqvlfjUOQwKD34GhXeDossycIL', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Code/1.120.0 Chrome/142.0.7444.265 Electron/39.8.8 Safari/537.36', 'eyJfdG9rZW4iOiJHd01qRFdxWnhPUldrRkllT1YyVnFHS2xWVlIyMGtGSzlETWhoTUxBIiwiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwIiwicm91dGUiOiJob21lIn0sIl9mbGFzaCI6eyJvbGQiOltdLCJuZXciOltdfX0=', 1779127332),
('VzOw5ZWkweeLKw7QUluNwXQNqVvl4lhpJvpYJgqE', 3, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36 Edg/148.0.0.0', 'eyJfdG9rZW4iOiJIbU5UdDNsVWVMczlpb3B0VFB1MXBXSGJ5eko3QzVXOHN0bzlLSzNUIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI6MywiX3ByZXZpb3VzIjp7InVybCI6Imh0dHA6XC9cLzEyNy4wLjAuMTo4MDAwXC9kYXNoYm9hcmQiLCJyb3V0ZSI6ImRhc2hib2FyZCJ9fQ==', 1779125989),
('XGS7q8WpeuVafx0NZwmrguHuVvDUbkn4ti8Rbzfv', 1, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/148.0.0.0 Safari/537.36', 'eyJfdG9rZW4iOiI2Sk8zTEZqT3dZdVEwZjVBZGJFRzdqZFBYT3FvaUJldElVdHRueFZRIiwiX2ZsYXNoIjp7Im9sZCI6W10sIm5ldyI6W119LCJfcHJldmlvdXMiOnsidXJsIjoiaHR0cDpcL1wvMTI3LjAuMC4xOjgwMDBcL2Rhc2hib2FyZCIsInJvdXRlIjoiZGFzaGJvYXJkIn0sImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjoxfQ==', 1779128549);

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

DROP TABLE IF EXISTS `teams`;
CREATE TABLE IF NOT EXISTS `teams` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_personal` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `teams_slug_unique` (`slug`)
) ENGINE=MyISAM AUTO_INCREMENT=116 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `name`, `slug`, `is_personal`, `created_at`, `updated_at`, `deleted_at`) VALUES
(1, 'Alexys Ryan\'s Team', 'sauer-plc', 1, '2026-05-18 16:12:38', '2026-05-18 16:12:38', NULL),
(2, 'Laurence Schuppe\'s Team', 'littel-considine', 1, '2026-05-18 16:12:38', '2026-05-18 16:12:38', NULL),
(3, 'Mr. Elbert Mraz Sr.\'s Team', 'kovacek-ltd', 1, '2026-05-18 16:12:38', '2026-05-18 16:12:38', NULL),
(4, 'Joey Kemmer\'s Team', 'hessel-jakubowski-and-kling', 1, '2026-05-18 16:12:38', '2026-05-18 16:12:38', NULL),
(5, 'Dr. Jermey Daniel DDS\'s Team', 'douglas-roberts', 1, '2026-05-18 16:12:40', '2026-05-18 16:12:40', NULL),
(6, 'Dr. Margie Klein DDS\'s Team', 'carter-schuster-and-boehm', 1, '2026-05-18 16:12:40', '2026-05-18 16:12:40', NULL),
(7, 'Prof. Akeem Murphy\'s Team', 'fisher-inc', 1, '2026-05-18 16:12:40', '2026-05-18 16:12:40', NULL),
(8, 'Morris Schumm DVM\'s Team', 'hagenes-and-sons', 1, '2026-05-18 16:12:42', '2026-05-18 16:12:42', NULL),
(9, 'Kenyon Volkman\'s Team', 'schiller-kunze-and-schultz', 1, '2026-05-18 16:12:42', '2026-05-18 16:12:42', NULL),
(10, 'Madeline Boehm\'s Team', 'prohaska-inc', 1, '2026-05-18 16:12:44', '2026-05-18 16:12:44', NULL),
(11, 'Prof. Frederique Abernathy\'s Team', 'wuckert-ltd', 1, '2026-05-18 16:12:44', '2026-05-18 16:12:44', NULL),
(12, 'Elnora Douglas\'s Team', 'schmitt-simonis', 1, '2026-05-18 16:12:44', '2026-05-18 16:12:44', NULL),
(13, 'Ms. Donna Johnson II\'s Team', 'bergstrom-hane-and-swift', 1, '2026-05-18 16:12:44', '2026-05-18 16:12:44', NULL),
(14, 'Mrs. Winona Collins\'s Team', 'williamson-tromp-and-simonis', 1, '2026-05-18 16:12:44', '2026-05-18 16:12:44', NULL),
(15, 'Karli Rohan\'s Team', 'king-inc', 1, '2026-05-18 16:12:46', '2026-05-18 16:12:46', NULL),
(16, 'Charlotte Goyette V\'s Team', 'stroman-becker', 1, '2026-05-18 16:12:46', '2026-05-18 16:12:46', NULL),
(17, 'Maxie Roob\'s Team', 'bogan-kuhn', 1, '2026-05-18 16:12:46', '2026-05-18 16:12:46', NULL),
(18, 'Haylie Simonis\'s Team', 'nader-ltd', 1, '2026-05-18 16:12:46', '2026-05-18 16:12:46', NULL),
(19, 'Cristian Metz PhD\'s Team', 'jast-and-sons', 1, '2026-05-18 16:12:46', '2026-05-18 16:12:46', NULL),
(20, 'Alexzander Harvey IV\'s Team', 'mccullough-king', 1, '2026-05-18 16:12:49', '2026-05-18 16:12:49', NULL),
(21, 'Rebeka O\'Connell\'s Team', 'ortiz-kuhlman', 1, '2026-05-18 16:12:51', '2026-05-18 16:12:51', NULL),
(22, 'Frank Hickle\'s Team', 'deckow-and-sons', 1, '2026-05-18 16:12:51', '2026-05-18 16:12:51', NULL),
(23, 'Baby Heathcote\'s Team', 'lemke-pagac', 1, '2026-05-18 16:12:51', '2026-05-18 16:12:51', NULL),
(24, 'Mr. Alford McDermott\'s Team', 'kessler-monahan', 1, '2026-05-18 16:12:52', '2026-05-18 16:12:52', NULL),
(25, 'Birdie Volkman\'s Team', 'lowe-deckow-and-parker', 1, '2026-05-18 16:12:52', '2026-05-18 16:12:52', NULL),
(26, 'Dr. Jaylan Rowe I\'s Team', 'wintheiser-jacobs-and-considine', 1, '2026-05-18 16:12:53', '2026-05-18 16:12:53', NULL),
(27, 'Dr. Adella O\'Conner V\'s Team', 'donnelly-deckow-and-crooks', 1, '2026-05-18 16:12:53', '2026-05-18 16:12:53', NULL),
(28, 'Ross O\'Connell\'s Team', 'little-turner', 1, '2026-05-18 16:12:53', '2026-05-18 16:12:53', NULL),
(29, 'Cassidy Collier\'s Team', 'bode-tromp-and-rippin', 1, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(30, 'Haylie Schoen Jr.\'s Team', 'jacobi-group', 1, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(31, 'Elmore Mosciski\'s Team', 'leffler-block-and-klein', 1, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(32, 'Beatrice Tillman DDS\'s Team', 'donnelly-ltd', 1, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(33, 'Ms. Amy Simonis Jr.\'s Team', 'haag-treutel-and-dubuque', 1, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(34, 'Cruz Cartwright MD\'s Team', 'turcotte-llc', 1, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(35, 'Isabella Gutkowski\'s Team', 'vandervort-haley', 1, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(36, 'Myrtie McCullough\'s Team', 'russel-inc', 1, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(37, 'Tromp Ltd', 'tromp-ltd', 0, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(38, 'Adalberto Mosciski\'s Team', 'feest-ritchie', 1, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(39, 'Dr. Terry Jaskolski\'s Team', 'bayer-group', 1, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(40, 'Tillman LLC', 'tillman-llc', 0, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(41, 'Oral Murazik\'s Team', 'jenkins-spinka-and-ratke', 1, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(42, 'Elian Kihn PhD\'s Team', 'mueller-swift-and-ebert', 1, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(43, 'Block-Botsford', 'block-botsford', 0, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(44, 'Sydney Dietrich\'s Team', 'kessler-weissnat-and-kuvalis', 1, '2026-05-18 16:12:54', '2026-05-18 16:12:54', NULL),
(45, 'Kessler, Hills and Tillman', 'kessler-hills-and-tillman', 0, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(46, 'Winifred Franecki\'s Team', 'jenkins-wiegand', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(47, 'Darryl Ziemann\'s Team', 'satterfield-cronin-and-collier', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(48, 'Effertz Ltd', 'effertz-ltd', 0, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(49, 'Joan Gulgowski\'s Team', 'reinger-barton', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(50, 'Watsica-Aufderhar', 'watsica-aufderhar', 0, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(51, 'Norbert Wyman\'s Team', 'romaguera-bernhard', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(52, 'Dasia Hills\'s Team', 'volkman-schmitt-and-bernhard', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(53, 'Goldner Group', 'goldner-group', 0, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(54, 'Junius Rowe DVM\'s Team', 'mcclure-ortiz-and-goyette', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(55, 'Damon O\'Connell\'s Team', 'toy-kovacek-and-muller', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(56, 'Bogan-Dickens', 'bogan-dickens', 0, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(57, 'Ulices Olson\'s Team', 'reilly-klocko-and-toy', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(58, 'Jackeline Schaefer\'s Team', 'macejkovic-haley', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(59, 'Dr. Jed Emard\'s Team', 'kulas-wisoky-and-bauch', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(60, 'Heller, Krajcik and Cummings', 'heller-krajcik-and-cummings', 0, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(61, 'Isabel Thiel\'s Team', 'schoen-and-sons', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(62, 'Mr. Antwan Schamberger MD\'s Team', 'kuhlman-group', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(63, 'Dr. Nicholas Hessel\'s Team', 'bashirian-ltd', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(64, 'Bogisich-Hammes', 'bogisich-hammes', 0, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(65, 'Sedrick Steuber\'s Team', 'mcclure-group', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(66, 'Alf Lind\'s Team', 'moore-kuphal', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(67, 'Cremin and Sons', 'cremin-and-sons', 0, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(68, 'Rosalyn Price\'s Team', 'koepp-daugherty', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(69, 'Helen Stanton\'s Team', 'bartoletti-inc', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(70, 'Elisha Grady Sr.\'s Team', 'kunze-beier', 1, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(71, 'Hoppe PLC', 'hoppe-plc', 0, '2026-05-18 16:12:55', '2026-05-18 16:12:55', NULL),
(72, 'Emmett Kihn\'s Team', 'herman-dickens-and-wolf', 1, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(73, 'Bechtelar LLC', 'bechtelar-llc', 0, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(74, 'Felicita Durgan\'s Team', 'huel-group', 1, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(75, 'Carmela Parisian Jr.\'s Team', 'simonis-skiles', 1, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(76, 'Weber-Trantow', 'weber-trantow', 0, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(77, 'Mrs. Molly Hane\'s Team', 'koelpin-dooley-and-reynolds', 1, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(78, 'Elliott Torphy\'s Team', 'von-ltd', 1, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(79, 'Corkery PLC', 'corkery-plc', 0, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(80, 'Linnea Murphy PhD\'s Team', 'klocko-and-sons', 1, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(81, 'Mellie Hirthe\'s Team', 'little-inc', 1, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(82, 'Antoinette Kuhlman\'s Team', 'glover-robel-and-schimmel', 1, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(83, 'Acme', 'acme', 0, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(84, 'Acme One', 'acme-1', 0, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(85, 'Acme Ten', 'acme-10', 0, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(86, 'Monroe Schneider\'s Team', 'cartwright-kiehn-and-damore', 1, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(87, 'Ebert-Schultz', 'ebert-schultz', 0, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(88, 'Prof. Camron Ryan Sr.\'s Team', 'yost-rippin', 1, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(89, 'Original Name', 'schaden-denesik', 0, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(90, 'Dr. Kelton Pfeffer\'s Team', 'beer-mcdermott-and-corwin', 1, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(91, 'Dr. Mike Hettinger II\'s Team', 'kiehn-fadel-and-wolf', 1, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(92, 'Wisozk-Schuppe', 'wisozk-schuppe', 0, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(93, 'Mrs. Joanie Smith III\'s Team', 'bednar-wolf', 1, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(94, 'Dibbert-Kemmer', 'dibbert-kemmer', 0, '2026-05-18 16:12:56', '2026-05-18 16:12:56', NULL),
(95, 'Prof. Elias Raynor\'s Team', 'mraz-bernhard-and-hamill', 1, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(96, 'Price, Ritchie and Satterfield', 'price-ritchie-and-satterfield', 0, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(97, 'Mike\'s Team', 'rath-larson-and-dicki', 1, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(98, 'Zulu Team', 'beier-cremin-and-reichert', 0, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(99, 'Alpha Team', 'oconner-mclaughlin', 0, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(100, 'Beta Team', 'murphy-legros', 0, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(101, 'Misty Kuphal\'s Team', 'lemke-jast-and-glover', 1, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(102, 'Zulu Team', 'friesen-llc', 0, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(103, 'Luigi Waelchi\'s Team', 'roberts-ltd', 1, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(104, 'DuBuque, Ferry and McClure', 'dubuque-ferry-and-mcclure', 0, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(105, 'Scotty Huel\'s Team', 'gibson-okeefe-and-schulist', 1, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(106, 'Rene Littel\'s Team', 'paucek-olson-and-marvin', 1, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(107, 'Mayer Inc', 'mayer-inc', 0, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(108, 'Korey Reichert\'s Team', 'reinger-denesik', 1, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(109, 'Sierra Heaney\'s Team', 'okon-hand', 1, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(110, 'Rubie Mosciski\'s Team', 'green-jones-and-abbott', 1, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(111, 'Cartwright-McClure', 'cartwright-mcclure', 0, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(112, 'Ms. Pinkie Trantow\'s Team', 'zemlak-welch', 1, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(113, 'Heidenreich-Orn', 'heidenreich-orn', 0, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(114, 'Lonzo Gutkowski\'s Team', 'emmerich-and-sons', 1, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL),
(115, 'Wiza, Bogisich and Schmidt', 'wiza-bogisich-and-schmidt', 0, '2026-05-18 16:12:57', '2026-05-18 16:12:57', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `team_invitations`
--

DROP TABLE IF EXISTS `team_invitations`;
CREATE TABLE IF NOT EXISTS `team_invitations` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `code` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `team_id` bigint UNSIGNED NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invited_by` bigint UNSIGNED NOT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `accepted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `team_invitations_code_unique` (`code`),
  KEY `team_invitations_team_id_foreign` (`team_id`),
  KEY `team_invitations_invited_by_foreign` (`invited_by`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `team_invitations`
--

INSERT INTO `team_invitations` (`id`, `code`, `team_id`, `email`, `role`, `invited_by`, `expires_at`, `accepted_at`, `created_at`, `updated_at`) VALUES
(1, 'B0YaNVeQ8CV7UZRmv0SSGjIcVZqpjW0ThbkBbwCuVaaIx7lUHjgFKqxRYz67TG8Q', 45, 'invited@example.com', 'member', 41, NULL, NULL, '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(2, 'LMEEyUvheIo49iy9hnIvEreaDDYMDbOpitUBJgk2gxvrqrw8sAXWAfHEtSNBYiPk', 50, 'shansen@example.com', 'member', 44, NULL, NULL, '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(3, 'Ftd1KZvh7A37pjM5HhhS4uDWebczNXnz0qQWvJW1lGwGFQDMMx8vVgPLG2OMo75Q', 53, 'invited@example.com', 'member', 45, NULL, NULL, '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(4, 'k2VOZWRkeHDS1jfleGMizSmYCG6rQtTxWpF1r3roXm053GxJuc4I2GkvBNwjFA6n', 56, 'invited@example.com', 'member', 47, NULL, NULL, '2026-05-18 16:12:55', '2026-05-18 16:12:55');

-- --------------------------------------------------------

--
-- Table structure for table `team_members`
--

DROP TABLE IF EXISTS `team_members`;
CREATE TABLE IF NOT EXISTS `team_members` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `team_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `role` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `team_members_team_id_user_id_unique` (`team_id`,`user_id`),
  KEY `team_members_user_id_foreign` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `team_members`
--

INSERT INTO `team_members` (`id`, `team_id`, `user_id`, `role`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 'owner', '2026-05-18 16:12:38', '2026-05-18 16:12:38'),
(2, 2, 2, 'owner', '2026-05-18 16:12:38', '2026-05-18 16:12:38'),
(3, 3, 3, 'owner', '2026-05-18 16:12:38', '2026-05-18 16:12:38'),
(4, 4, 4, 'owner', '2026-05-18 16:12:38', '2026-05-18 16:12:38'),
(5, 5, 5, 'owner', '2026-05-18 16:12:40', '2026-05-18 16:12:40'),
(6, 6, 6, 'owner', '2026-05-18 16:12:40', '2026-05-18 16:12:40'),
(7, 7, 7, 'owner', '2026-05-18 16:12:40', '2026-05-18 16:12:40'),
(8, 8, 8, 'owner', '2026-05-18 16:12:42', '2026-05-18 16:12:42'),
(9, 9, 9, 'owner', '2026-05-18 16:12:42', '2026-05-18 16:12:42'),
(10, 10, 10, 'owner', '2026-05-18 16:12:44', '2026-05-18 16:12:44'),
(11, 11, 11, 'owner', '2026-05-18 16:12:44', '2026-05-18 16:12:44'),
(12, 12, 12, 'owner', '2026-05-18 16:12:44', '2026-05-18 16:12:44'),
(13, 13, 13, 'owner', '2026-05-18 16:12:44', '2026-05-18 16:12:44'),
(14, 14, 14, 'owner', '2026-05-18 16:12:44', '2026-05-18 16:12:44'),
(15, 15, 15, 'owner', '2026-05-18 16:12:46', '2026-05-18 16:12:46'),
(16, 16, 16, 'owner', '2026-05-18 16:12:46', '2026-05-18 16:12:46'),
(17, 17, 17, 'owner', '2026-05-18 16:12:46', '2026-05-18 16:12:46'),
(18, 18, 18, 'owner', '2026-05-18 16:12:46', '2026-05-18 16:12:46'),
(19, 19, 19, 'owner', '2026-05-18 16:12:46', '2026-05-18 16:12:46'),
(20, 20, 20, 'owner', '2026-05-18 16:12:49', '2026-05-18 16:12:49'),
(21, 21, 21, 'owner', '2026-05-18 16:12:51', '2026-05-18 16:12:51'),
(22, 22, 22, 'owner', '2026-05-18 16:12:51', '2026-05-18 16:12:51'),
(23, 23, 23, 'owner', '2026-05-18 16:12:51', '2026-05-18 16:12:51'),
(24, 24, 24, 'owner', '2026-05-18 16:12:52', '2026-05-18 16:12:52'),
(25, 25, 25, 'owner', '2026-05-18 16:12:52', '2026-05-18 16:12:52'),
(26, 26, 26, 'owner', '2026-05-18 16:12:53', '2026-05-18 16:12:53'),
(27, 27, 27, 'owner', '2026-05-18 16:12:53', '2026-05-18 16:12:53'),
(28, 28, 28, 'owner', '2026-05-18 16:12:53', '2026-05-18 16:12:53'),
(29, 29, 29, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(30, 30, 30, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(31, 31, 31, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(32, 32, 32, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(33, 33, 33, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(34, 34, 34, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(35, 35, 35, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(36, 36, 36, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(37, 37, 36, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(38, 38, 37, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(39, 39, 38, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(40, 40, 37, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(41, 40, 38, 'admin', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(42, 41, 39, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(43, 42, 40, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(44, 43, 39, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(45, 43, 40, 'member', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(46, 44, 41, 'owner', '2026-05-18 16:12:54', '2026-05-18 16:12:54'),
(47, 45, 41, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(48, 46, 42, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(49, 47, 43, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(50, 48, 42, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(51, 48, 43, 'member', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(52, 49, 44, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(53, 50, 44, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(54, 51, 45, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(55, 52, 46, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(56, 53, 45, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(57, 54, 47, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(58, 55, 48, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(59, 56, 47, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(60, 57, 49, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(61, 58, 50, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(62, 59, 51, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(63, 60, 50, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(64, 60, 51, 'member', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(65, 61, 52, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(66, 62, 53, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(67, 63, 54, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(68, 64, 52, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(69, 64, 53, 'admin', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(70, 64, 54, 'member', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(71, 65, 55, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(72, 66, 56, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(73, 67, 55, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(74, 67, 56, 'member', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(75, 68, 57, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(76, 69, 58, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(77, 70, 59, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(78, 71, 57, 'owner', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(79, 71, 58, 'admin', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(80, 71, 59, 'member', '2026-05-18 16:12:55', '2026-05-18 16:12:55'),
(81, 72, 60, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(82, 73, 60, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(83, 74, 61, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(84, 75, 62, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(85, 76, 61, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(86, 76, 62, 'member', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(87, 77, 63, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(88, 78, 64, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(89, 79, 63, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(90, 79, 64, 'member', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(91, 80, 65, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(92, 81, 66, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(93, 82, 67, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(94, 86, 68, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(95, 87, 68, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(96, 88, 69, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(97, 89, 69, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(98, 90, 70, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(99, 91, 71, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(100, 92, 70, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(101, 92, 71, 'member', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(102, 93, 72, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(103, 94, 72, 'owner', '2026-05-18 16:12:56', '2026-05-18 16:12:56'),
(104, 95, 73, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(105, 96, 73, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(106, 97, 74, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(107, 98, 74, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(108, 99, 74, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(109, 100, 74, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(110, 101, 75, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(111, 102, 75, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(112, 103, 76, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(113, 104, 76, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(114, 105, 77, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(115, 106, 78, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(116, 107, 77, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(117, 107, 78, 'member', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(118, 108, 79, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(119, 109, 80, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(120, 110, 81, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(121, 111, 80, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(122, 111, 81, 'member', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(123, 112, 82, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(124, 113, 82, 'member', '2026-05-18 16:12:57', '2026-05-18 16:12:57'),
(125, 114, 83, 'owner', '2026-05-18 16:12:57', '2026-05-18 16:12:57');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT,
  `branch_id` bigint UNSIGNED DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `designation` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `current_team_id` bigint UNSIGNED DEFAULT NULL,
  `two_factor_secret` text COLLATE utf8mb4_unicode_ci,
  `two_factor_recovery_codes` text COLLATE utf8mb4_unicode_ci,
  `two_factor_confirmed_at` timestamp NULL DEFAULT NULL,
  `role` enum('super_admin','top_management','transport_admin','branch_user') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'branch_user',
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  UNIQUE KEY `users_username_unique` (`username`),
  KEY `users_branch_id_foreign` (`branch_id`),
  KEY `users_current_team_id_foreign` (`current_team_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `branch_id`, `name`, `designation`, `email`, `username`, `email_verified_at`, `password`, `current_team_id`, `two_factor_secret`, `two_factor_recovery_codes`, `two_factor_confirmed_at`, `role`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 1, 'Super Admin', NULL, 'superadmin@gov.lk', 'superadmin', NULL, '$2y$12$GzuDOskJARXa29qLbIyWVOFJKqITWmP7zbIKG818F9lwhLQRdChJW', NULL, NULL, NULL, NULL, 'super_admin', NULL, '2026-05-18 16:54:28', '2026-05-18 16:54:28'),
(2, NULL, 'ayomi', NULL, 'ayomi@gmail.com', 'ayomi', NULL, '$2y$12$gQCNRJBOsoyPfb6fHCW2IuKFHsVWm8YUSXM6.dEQQ91Q9xCoj1riO', NULL, NULL, NULL, NULL, 'transport_admin', NULL, '2026-05-18 17:01:43', '2026-05-18 17:01:43'),
(3, NULL, 'niluka', NULL, 'niluka@gmail.com', 'niluka', NULL, '$2y$12$N0Z9JbyiLOGrAc980vNqgO68gI1HkccDvzwMetEWvnd4iIUK2yrO.', NULL, NULL, NULL, NULL, 'top_management', NULL, '2026-05-18 17:03:23', '2026-05-18 17:03:23'),
(4, 2, 'anushka', NULL, 'kankanamgeanushka87@gmail.com', 'anushka', NULL, '$2y$12$301GKQhdSPqOjcjSvtp4zOdzhNnkyhXVOrch.GhX42MMJj5B4.bgi', NULL, NULL, NULL, NULL, 'branch_user', NULL, '2026-05-18 17:04:34', '2026-05-18 17:04:34'),
(5, 5, 'chamara', NULL, 'krishanchamara@gmail.com', 'chamara', NULL, '$2y$12$ghWUFXO769twPJom7CyChOi6/iYzRXBU3/VWHfQEarZ9bDzD/A9DO', NULL, NULL, NULL, NULL, 'branch_user', NULL, '2026-05-18 17:08:34', '2026-05-18 17:08:34'),
(6, 4, 'kumuduni', NULL, 'kapkumuduni@gmail.com', 'kumuduni', NULL, '$2y$12$fpE0q3ZPtbKzX8QjjBjp6ONMk/5Xm3mGTyGk1VnoSw9nf0iN1bzP2', NULL, NULL, NULL, NULL, 'branch_user', NULL, '2026-05-18 18:14:57', '2026-05-18 18:14:57'),
(7, 3, 'manjula', NULL, 'ridmalkavindu90@gmail.com', 'manjula', NULL, '$2y$12$z.GKzCTo5KI7f.9uW9/d6.hbIoa186AK2gT2TNN/FLV1FyT9MGBW2', NULL, NULL, NULL, NULL, 'branch_user', NULL, '2026-05-18 18:15:56', '2026-05-18 18:15:56'),
(8, 8, 'nishantha', NULL, 'nishanthavpso@gmail.com', 'nishantha', NULL, '$2y$12$x7uZ.n4vYfkJ.xS3ICLE1eilWrvwU8YDqbt8J8HkI/lfYkMzUZR.O', NULL, NULL, NULL, NULL, 'branch_user', NULL, '2026-05-18 18:16:59', '2026-05-18 18:16:59'),
(9, 10, 'pemarathna', NULL, 'pemarathnawpk@gmail.com', 'pemarathna', NULL, '$2y$12$8fSEuxj940qJykIWSrxmlORK7UGw8Gy070RkLpUuBUjQkreTaG10m', NULL, NULL, NULL, NULL, 'branch_user', NULL, '2026-05-18 18:18:02', '2026-05-18 18:18:02'),
(10, 6, 'ganga', NULL, 'gangagalappaththi4@gmail.com', 'ganga', NULL, '$2y$12$xuOmaFXJU910nBhp1Xzk4uywgkmDNCACWG342QQhtFcBPg7rRTIjm', NULL, NULL, NULL, NULL, 'branch_user', NULL, '2026-05-18 18:19:00', '2026-05-18 18:19:00'),
(11, 7, 'wasantha', NULL, 'epakumara@gmail.com', 'wasantha', NULL, '$2y$12$wOt6OunbppNDUFYO7m4Ae.aR79PjK3wZYL3ekKENwkFC9SwmUuK2e', NULL, NULL, NULL, NULL, 'branch_user', NULL, '2026-05-18 18:19:43', '2026-05-18 18:19:43'),
(12, 9, 'kapila', NULL, 'kapilaanthony81@gmail.com', 'kapila', NULL, '$2y$12$587esKOZdqZgppQrkGMoB.aSQZ9zNPnmKdtEwPjAE9rAbdNpQzu6e', NULL, NULL, NULL, NULL, 'branch_user', NULL, '2026-05-18 18:20:34', '2026-05-18 18:20:34'),
(13, 11, 'kanthi', NULL, 'maithriekumararathna@gmail.com', 'kanthi', NULL, '$2y$12$OP5YmfIjeHXYQRGDpLSESOHX3.dRd1svWwBl44mx8UFsw4CnC09.a', NULL, NULL, NULL, NULL, 'branch_user', NULL, '2026-05-18 18:21:51', '2026-05-18 18:21:51');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
