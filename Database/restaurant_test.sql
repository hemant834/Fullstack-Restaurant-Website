-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 01, 2026 at 01:03 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `restaurant_test`
--

-- --------------------------------------------------------

--
-- Table structure for table `cache`
--

CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `cache_locks`
--

CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

CREATE TABLE `menus` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(8,2) NOT NULL,
  `category` varchar(255) NOT NULL,
  `food_type` varchar(255) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `is_available` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `name`, `description`, `price`, `category`, `food_type`, `image`, `is_available`, `created_at`, `updated_at`) VALUES
(1, 'Tomato pizza', 'Hand-tossed crust layered with rich tomato sauce, baked to golden perfection for an authentic Italian taste.', 15.00, 'Main Course', 'veg', 'Tometopizza.png\r\n', 1, '2026-02-03 07:04:47', '2026-02-03 07:04:47'),
(2, 'Pizza', 'Freshly baked cheesy veg pizza with tomato sauce', 120.00, 'Fast Food', 'veg', 'pizza.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(3, 'Veg Burger', 'Crispy veg burger with cheese and fresh veggies', 80.00, 'Starters', 'veg', 'veg_burger.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(4, 'French Fries', 'Golden crispy potato fries with salt', 60.00, 'Starters', 'veg', 'fries.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(5, 'Veg Sandwich', 'Grilled sandwich with vegetables and cheese', 40.00, 'Starters\r\n', 'veg', 'sandwich.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(6, 'Cheese Sandwich', 'Cheesy grilled sandwich with butter', 60.00, 'Starters', 'veg', 'cheese_sandwich.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(7, 'Paneer Roll', 'Soft roll stuffed with spicy paneer filling', 100.00, 'Desserts', 'veg', 'paneer_roll.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(8, 'Veg Momos', 'Steamed dumplings filled with vegetables', 80.00, 'Desserts', 'veg', 'momos.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(9, 'Fried Momos', 'Deep fried crispy vegetable momos', 90.00, 'Desserts', 'veg', 'fried_momos.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(10, 'Chowmein', 'Stir fried noodles with vegetables and sauces', 100.00, 'Main Course', 'veg', 'chowmein.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(11, 'Gravy Manchurian', 'Veg balls tossed in spicy Chinese gravy', 110.00, 'Main Course\r\n', 'veg', 'manchurian.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(12, 'Dry Manchurian', 'Veg balls tossed in spicy Chinese gravy', 100.00, 'Main Course\r\n', 'veg', 'Dry Manchurian.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(13, 'Manchurian Rice', 'Veg balls tossed in spicy Chinese Rice', 100.00, 'Main Course', 'veg', 'manchurian_rice.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(14, 'Spring Roll', 'Crispy rolls stuffed with vegetables', 70.00, 'Starters', 'veg', 'spring_roll.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(15, 'White Sauce Pasta', 'Creamy white sauce pasta with herbs', 80.00, 'Starters', 'veg', 'pasta.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(16, 'Red Sauce Pasta', 'Tangy tomato pasta with spices and herbs', 110.00, 'Starters', 'veg', 'red_pasta.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(17, 'Maggi', 'Tasty masala Maggi noodles', 50.00, 'Desserts\r\n', 'veg', 'maggi.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(18, 'Cheese Maggi', 'Maggi noodles topped with melted cheese', 70.00, 'Desserts\r\n\r\n', 'veg', 'cheese_maggi.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(19, 'Masala Wrap Roll', 'Soft wrap filled with vegetables and sauces', 90.00, 'Starters', 'veg', 'veg_wrap.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(20, 'Paneer Burger', 'Burger stuffed with paneer patty and cheese', 100.00, 'Fast Food', 'veg', 'paneer_burger.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(21, 'Aloo Tikki Burger', 'Spicy aloo tikki burger with chutney', 100.00, 'Main Course', 'veg', 'aloo_burger.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(22, 'Veg Cutlet', 'Crispy vegetable cutlet with spices', 60.00, 'Desserts', 'veg', 'cutlet.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(23, 'Veg Nuggets', 'Crunchy veg nuggets served hot', 90.00, 'Starters\r\n', 'veg', 'veg_nuggets.jpg', 1, '2026-02-17 09:52:30', '2026-02-17 09:52:30'),
(33, 'milkshake', 'A milkshake is a sweet, cold beverage typically made by blending milk, ice cream', 50.00, 'Starters', 'veg', 'milkshake.png\r\n', 1, '2026-02-25 11:50:25', '2026-02-25 11:50:25');

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` int(10) UNSIGNED NOT NULL,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '0001_01_01_000000_create_users_table', 1),
(2, '0001_01_01_000001_create_cache_table', 1),
(3, '0001_01_01_000002_create_jobs_table', 1),
(4, '2026_01_12_000000_create_menus_table', 1),
(5, '2026_02_03_122610_add_food_type_to_menus_table', 1);

-- --------------------------------------------------------

--
-- Table structure for table `password_reset_tokens`
--

CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `sessions`
--

INSERT INTO `sessions` (`id`, `user_id`, `ip_address`, `user_agent`, `payload`, `last_activity`) VALUES
('BTc5qeXIAmswuHt5iuJZf71wUmdTzlMgYUm6H1QX', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoielF3NVI5ZG52ak9OMlhGaERVRk1SNWNPYjlMeERCbnVXS2kzMFR1ZCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6NDA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9tZW51cy9jcmVhdGUiO3M6NToicm91dGUiO3M6MTg6ImFkbWluLm1lbnVzLmNyZWF0ZSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1772101123),
('RUxhr5yNSneDfW5HwYcPokBdqOelx8zUuT05h0lg', NULL, '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'YTozOntzOjY6Il90b2tlbiI7czo0MDoiOGpEbDNTR2dxMlhya3huYnFhbXhCWEUyS1RCVHVNbEdmRHo5eEQ4QiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzM6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9hZG1pbi9tZW51cyI7czo1OiJyb3V0ZSI7czoxNzoiYWRtaW4ubWVudXMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1772343401);

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
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `email_verified_at`, `password`, `remember_token`, `created_at`, `updated_at`) VALUES
(1, 'Test User', 'test@example.com', '2026-02-03 07:04:46', '$2y$12$Tl9DNyfMTJlZUlEfuzaLnORUZSQsyXUMvSoh7qdTsy04F2ifb7XkW', '6ye2xVkqRI', '2026-02-03 07:04:47', '2026-02-03 07:04:47');

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
-- Indexes for table `menus`
--
ALTER TABLE `menus`
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
-- AUTO_INCREMENT for table `menus`
--
ALTER TABLE `menus`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
