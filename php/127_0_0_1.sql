-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 04, 2026 at 01:06 PM
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
-- Database: `adoption_db`
--
CREATE DATABASE IF NOT EXISTS `adoption_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `adoption_db`;

-- --------------------------------------------------------

--
-- Table structure for table `admin_logs`
--

CREATE TABLE `admin_logs` (
  `id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `target_user_id` int(11) NOT NULL,
  `action` varchar(255) NOT NULL,
  `log_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `adoptions`
--

CREATE TABLE `adoptions` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `animal_id` int(11) DEFAULT NULL,
  `adoption_date` datetime DEFAULT current_timestamp(),
  `address` text DEFAULT NULL,
  `contact` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `adoptions`
--

INSERT INTO `adoptions` (`id`, `user_id`, `animal_id`, `adoption_date`, `address`, `contact`) VALUES
(1, 3, 2, '2026-01-23 21:17:15', 'ward 2, Minglanilla, cebu', '09928893583'),
(2, 3, 1, '2026-01-23 21:29:40', 'ward 2, Minglanilla, cebu', '09928893583');

-- --------------------------------------------------------

--
-- Table structure for table `animals`
--

CREATE TABLE `animals` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `species` varchar(50) NOT NULL,
  `age` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(255) DEFAULT 'default.jpg',
  `status` enum('Available','Adopted') DEFAULT 'Available'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `animals`
--

INSERT INTO `animals` (`id`, `name`, `species`, `age`, `description`, `image`, `status`) VALUES
(1, 'corn snake', 'snake', 3, NULL, 'corn snake.jpg', 'Adopted'),
(2, 'mike', 'dog', 5, NULL, 'golden.jpg', 'Available'),
(0, 'harold', 'horn frog', 12, NULL, 'imgres.JPG', 'Available'),
(0, 'mel', 'dragon', 2147483647, NULL, 'dragon.jpg', 'Available');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `id` int(11) NOT NULL,
  `adoption_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `animal_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `reference_number` varchar(100) DEFAULT NULL,
  `payment_status` enum('Pending','Paid','Failed','Refunded') DEFAULT 'Pending',
  `notes` text DEFAULT NULL,
  `paymongo_reference_id` varchar(255) DEFAULT NULL,
  `payment_date` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('admin','client') DEFAULT 'client'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `role`) VALUES
(1, 'admin', '$2y$10$8.uQ/L5.uQ/L5.uQ/L5.uQ/L5.uQ/L5.uQ/L5.uQ/L5.uQ/L5.uQ', 'admin'),
(2, 'jush', '$2y$10$Qv/c.HGluuOQ4jpF94P9XOp4VqgHBa8lzcLQTQECYMBW6fiWbjKPi', 'admin'),
(3, 'mike', '$2y$10$PRytgrI8sMtnEiwNCYPbAOlf9qJN5pkdpOJAs5HgfpdJNKgzIvzhy', 'client');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin_logs`
--
ALTER TABLE `admin_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `adoption_id` (`adoption_id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_animal_id` (`animal_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin_logs`
--
ALTER TABLE `admin_logs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- Database: `background`
--
CREATE DATABASE IF NOT EXISTS `background` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `background`;

-- --------------------------------------------------------

--
-- Table structure for table `video`
--
-- Error reading structure for table background.video: #1932 - Table &#039;background.video&#039; doesn&#039;t exist in engine
-- Error reading data for table background.video: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `background`.`video`&#039; at line 1
--
-- Database: `computer_parts_store`
--
CREATE DATABASE IF NOT EXISTS `computer_parts_store` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `computer_parts_store`;

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `name`, `description`) VALUES
(1, 'CPU (Processor)', NULL),
(2, 'Motherboard', NULL),
(3, 'RAM (Memory)', NULL),
(4, 'GPU (Graphics Card / Video Card)', NULL),
(5, 'Power Supply (PSU)', NULL),
(6, 'Storage (HDD / SSD / NVMe)', NULL),
(7, 'Cooling Systems (Air & Liquid Coolers)', NULL),
(8, 'Keyboard', NULL),
(9, 'Mouse', NULL),
(10, 'Monitor', NULL),
(11, 'Headset / Microphone', NULL),
(12, 'Webcam', NULL),
(13, 'PC Cases / Chassis', NULL),
(14, 'Case Fans & RGB Lighting', NULL),
(15, 'Cables & Adapters', NULL),
(16, 'Thermal Paste / Heat Sinks', NULL),
(17, 'Routers & Modems', NULL),
(18, 'Network Cards', NULL),
(19, 'USB Hubs & Extensions', NULL),
(20, 'Gaming Controllers', NULL),
(21, 'VR Gear', NULL),
(22, 'Capture Cards / Streaming Equipment', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `inventory`
--

CREATE TABLE `inventory` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity_change` int(11) NOT NULL,
  `reason` enum('restock','sale','adjustment') NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `payment_method` varchar(50) NOT NULL,
  `status` varchar(30) NOT NULL DEFAULT 'Paid',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `delivery_street` varchar(255) DEFAULT NULL,
  `delivery_city` varchar(100) DEFAULT NULL,
  `delivery_province` varchar(100) DEFAULT NULL,
  `delivery_zip` varchar(20) DEFAULT NULL,
  `distance_km` int(11) DEFAULT NULL,
  `delivery_minutes` int(11) DEFAULT NULL,
  `expected_delivery_datetime` datetime DEFAULT NULL,
  `quantity` int(11) NOT NULL DEFAULT 1,
  `staff_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `product_id`, `price`, `payment_method`, `status`, `created_at`, `delivery_street`, `delivery_city`, `delivery_province`, `delivery_zip`, `distance_km`, `delivery_minutes`, `expected_delivery_datetime`, `quantity`, `staff_id`) VALUES
(40, 6, 8, 80.00, 'PayPal', 'Paid', '2026-02-27 06:12:28', 'Ward IV', 'Minglanilla', 'Cebu', '6046', 0, 0, '2026-03-01 07:12:28', 3, NULL),
(41, 6, 8, 80.00, 'PayPal', 'Paid', '2026-02-27 06:14:29', 'Ward IV', 'Minglanilla', 'Cebu', '6046', 0, 0, '2026-03-01 07:14:29', 1, NULL),
(42, 6, 12, 100.00, 'paypal', 'Paid', '2026-02-27 06:18:22', NULL, NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category_id` int(11) NOT NULL,
  `description` text DEFAULT NULL,
  `price` decimal(10,2) NOT NULL,
  `stock_quantity` int(11) NOT NULL DEFAULT 0,
  `image_url` varchar(255) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `category` varchar(100) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `category_id`, `description`, `price`, `stock_quantity`, `image_url`, `created_at`, `category`) VALUES
(1, 'Intel Core Ultra 9 285K CPU', 1, 'Elevate your PC with the Intel Core Ultra 9 285K, the pinnacle of desktop processing. Crush demanding workloads and achieve elite gaming performance with its 24-core architecture and a stunning 5.7 GHz max turbo frequency. This CPU introduces a powerful 3-part AI engine, including the dedicated Intel AI Boost NPU, to accelerate creative and AI tasks with remarkable efficiency. With support for blazing-fast DDR5 6400 memory, PCIe 5.0, and integrated graphics driving multiple 8K displays, the Core Ultra 9 285K is the ultimate engine for your high-end build\r\n\r\n', 320.00, 50, 'uploads/1770638416_1770099905_images.png', '2026-02-09 12:00:16', ''),
(2, 'HP Gaming Headphones', 11, '•Ergonomic design & lightweight material for all-day comfort with self-adjusting padding headband & all-cover ear cups\r\n•LED lighting design that brings cool lights when plugged in, highlighting game atmosphere\r\n•Adjustable microphone reproduces voice with proper volume and clarity with 50mm speaker drivers\r\n•Stereo bass sound effect with 50mm audio drivers and advanced technology for intense gaming experiences\r\n•Multi-platform compatibility including PS4, Xbox, Nintendo Switch, PC, laptop, mobile phone, and more\r\n•Plug and play functionality for easy setup and use', 20.00, 25, 'uploads/1770639193_6606ad51fb8aaa2f3d48f98e-hp-gaming-headphones-with-microphone.jpg', '2026-02-09 12:13:13', ''),
(3, 'LOGITECH G502 LIGHTSPEED WIRELESS RGB GAMING MOUSE', 9, 'G502 HERO features an advanced optical sensor for maximum tracking accuracy, customizable RGB lighting, custom game profiles, from 100 up to 25,600 DPI, and repositionable weights. HERO achieves competition-level precision and the most consistent responsiveness ever.', 95.00, 10, 'uploads/1770639664_mouse.jpg', '2026-02-09 12:21:04', ''),
(5, 'ASUS ROG Swift 32” 4K OLED Gaming Monitor (PG32UCDM) - UHD (3840 x 2160), QD-OLED, 240Hz, 0.03ms, G-', 10, 'BrandASUSScreen Size32 InchesResolution4K UHD 2160pAspect Ratio16:9Screen Surface DescriptionMatte\r\n\r\nAbout this item\r\n\r\n32-inch 4K (3840 x 2160) QD-OLED gaming monitor with 240 Hz refresh rate and 0.03 ms (GTG) response time for immersive gaming\r\n\r\nHighly efficient custom heatsink, advanced airflow design, and graphene film for better heat management to reduce the risk of burn-in\r\n\r\nVESA DisplayHDR 400 True Black compliance, 99% DCI-P3 gamut, true 10-bit, and Delta E < 2 color difference for astonishing HDR performance\r\n\r\nOptional uniform brightness setting ensures consistent luminance levels\r\n\r\nDisplayWidget Center allows users to access OLED Care functions, as well as adjust monitor settings with a mouse\r\n\r\nPeak brightness may vary due to color pre-calibration', 2200.00, 15, 'uploads/1770640089_1704811349_1692603178869_1.jpg', '2026-02-09 12:28:09', ''),
(6, 'Keyboard', 8, 'hjdgasjkbhkdhndasfjklsagbfjkasbcljkashdfouawhnklsanfcjklasbcgjksahdjlaslbhfvjlsanda', 200.00, 15, 'uploads/1770973572_sleek-mechanical-pc-keyboard-with-led-lighting_946696-2901.png', '2026-02-13 09:06:12', ''),
(7, 'Laptop Fan', 14, '6 Fans Laptop Cooling Pad Adjustable Height Foldable Laptop Cooler Pad 9\"-17\" Led Light Height\r\n', 60.00, 20, 'uploads/1770974734_8-amazing-cooling-pad-for-gaming-laptop-for-2023-1701759472.jpg', '2026-02-13 09:25:34', ''),
(8, 'MSI B75MA-P45', 2, 'MSI released details about its upcoming value socket LGA1155 motherboard, the B75MA-P45. MSI finds the B75 PCH a worthy option over the current-generation H61 PCH, and could hence price its B75-based motherboards competitively, to capture the entry-level LGA1155 market. The B75MA-P45 comes with out of the box support for 22 nm \"Ivy Bridge\" Core processors, apart from current-generation \"Sandy Bridge\" ones. The B75MA-P45 packs a simple 5-phase VRM to power the LGA1155 CPU. The CPU is wired to four DDR3 DIMM slots, supporting dual-channel DDR3-1600 MHz memory.\r\n\r\nExpansion slots include one PCI-Express 3.0 x16, one PCI-Express 2.0 x1, and a legacy PCI. The legacy PCI logic is reintegrated with the PCH, and so the board doesn\'t use any bridge chips, further, since USB 3.0 and SATA 6 Gb/s are integrated with the PCH, MSI didn\'t add third-party controllers handling the two. SATA connectivity includes one SATA 6 Gb/s, and five SATA 3 Gb/s. The PCH gives out four USB 3.0 ports, two of which are found on the rear panel, two via internal header. Display connectivity includes DVI and D-Sub. 6-channel HD audio, gigabit Ethernet, and legacy PS/2 connectors complete the package. The board is driven by UEFI firmware (5 MB ME 8.0), with a graphical setup program. The B75MA-P45 is said to capture a price-point under US $100.', 80.00, 10, 'uploads/1770977193_OIP (1).png', '2026-02-13 10:06:33', ''),
(9, 'Crucial Intel DDR5 4800 5600 Frequency 8G 16G 24G 32G 48G Notebook Memory 63f', 3, 'Crucial Intel DDR5 4800 5600 Frequency 8G 16G 24G 32G 48G Notebook Memory', 500.00, 20, 'uploads/1772170828_CP2K16G60C36U5B.png', '2026-02-27 05:40:28', ''),
(10, 'AMD Ryzen™ 7 5800X Desktop Processor', 1, 'Can deliver ultra-fast 100 plus FPS performance in the world\'s most popular games, discrete graphics card required\r\n8 Cores and 16 processing threads, based on AMD \"Zen 3\" architecture\r\n4.6 GHz Max Boost, unlocked for overclocking, 36 MB cache, DDR4-3200 support', 250.00, 20, 'uploads/1772171018_2505503-ryzen-7-5800x.avif', '2026-02-27 05:43:38', ''),
(11, 'Graphics Card Gtx 760 2Gb 256Bit Gddr5 Video Para Sa Nvidia Vga Cards Geforce Gtx760', 4, 'sdadsadsafvdaaweeadsahadsaag', 1000.00, 15, 'uploads/1772171119_shopping.webp', '2026-02-27 05:45:19', ''),
(12, 'Acer SA1 Series 23.8” Full HD IPS Monitor, AMD Radeon FreeSync, 1ms VRB, 75Hz Refresh Rate', 10, 'Vibrant Images: Crisp, true-to-life colors come alive in Full HD 1080p resolution. Movies and games appear more real and dramatic, and small details and text are clear with 1920x1080 resolution in a 16:9 aspect ratio.\r\nAdaptive-Sync Support: Get fast refresh rates thanks to the Adaptive-Sync Support product that matches the refresh rate of your monitor with your graphics card. The result is a smooth, tear-free experience in gaming and video playback applications. \r\nZeroFrame Design: With a SA243Y monitor, you’ll want to see as much of the display as possible. Get more monitor real estate with the near bezel-less design, allowing you to see more and do more. The ZeroFrame design lets you place multiple monitors next to each other for a seamless, almost uninterrupted view.\r\nResponsive!!: Fast response time of 1ms enhances the experience. No matter the fast moving action or any dramatic transitions will be all rendered smoothly without the annoying effects of smearing or ghosting. The 120Hz refresh rate speeds up the frames per second to deliver smooth 2D motion scenes.\r\nStunning Images from Every Angle: Thanks to IPS technology, Acer’s SA243Y monitor displays color accurately up to 178 degrees. Share what\'s on your screen with friends and family and colors stay true no matter what angle you\'re viewing from.\r\nBetter for Your Eyes: Acer VisionCare incorporates several technologies to reduce eye strain and provide a more comfortable viewing experience.  Say goodbye to annoying screen flickering and shield your eyes from eye straining blue light.', 100.00, 9, 'uploads/1772171857_6352996169c758316d5f8bdb-acer-23-8-full-hd-1920-x-1080.png', '2026-02-27 05:57:37', ''),
(13, 'Manhattan Wired Computer Keyboard Basic Black Keyboard - with 4.5ft USB-A Cable, 104-keys, Foldable ', 8, 'Product Title: Manhattan Wired Computer Keyboard, Black - with 5ft USB-A Cable, 104-keys, Foldable Stands - Compatible for Windows, PC, Laptop - 179324 Introducing the Manhattan Wired Computer Keyboard, the perfect accessory for all your computing needs. This sleek and stylish keyboard is designed to enhance your typing experience with its comfortable layout and convenient features. With its durable construction and reliable performance, it is the best choice for both home and office use. The Manhattan Wired Computer Keyboard features a 104-key layout, giving you maximum control and convenience.\r\n\r\nIts ergonomic design ensures that your hands and wrists are in a natural position, minimizing discomfort and fatigue. The foldable stands on the back of the keyboard allow you to adjust the angle for a personalized typing experience. Connectivity is made easy with the included 5ft USB-A cable, providing a reliable and stable connection to your Windows PC, laptop, or desktop computer. Whether you\'re writing emails, working on spreadsheets, or gaming, this keyboard delivers a responsive and accurate typing experience. Not only is the Manhattan Wired Computer Keyboard compatible with various operating systems, including Windows, but it is also designed to withstand heavy usage.\r\n\r\nIts durable construction ensures that it can withstand the test of time, making it a long-lasting investment for your computing needs. This keyboard is not just practical but also stylish. Its sleek black design adds a touch of elegance to any workspace, whether it\'s at home or in the office. The numeric keypad provides convenience for data entry and calculations.\r\n\r\nThe multimedia keys allow you to control your music, videos, and other media with ease. Upgrade your typing experience with the Manhattan Wired Computer Keyboard. It is the perfect blend of functionality, durability, and affordability. Don\'t settle for less when it comes to your keyboard - choose Manhattan and enjoy a superior typing experience today.', 350.00, 20, 'uploads/1772171926_71zMsBPu3qL._AC_SL1000__.jpg', '2026-02-27 05:58:46', ''),
(14, 'Sandisk Ultra USB 3.0 Flash Drive 32gb (Black/Red)', 19, 'The SanDisk Ultra USB 3.0 flash drive combines faster data speeds and generous capacity in a compact, stylish package. With transfer speeds of up to 80 MB/s, this USB 3.0 flash drive can move files up to four times faster than USB 2.0 drives. Transfer files up to 10x faster than standard...', 10.00, 20, 'uploads/1772172104_32gb_red_800x (1).webp', '2026-02-27 06:01:44', '');

-- --------------------------------------------------------

--
-- Table structure for table `product_reviews`
--

CREATE TABLE `product_reviews` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` between 1 and 5),
  `review` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `product_reviews`
--

INSERT INTO `product_reviews` (`id`, `product_id`, `user_id`, `rating`, `review`, `created_at`) VALUES
(1, 12, 6, 3, 'average product', '2026-02-27 06:26:22'),
(2, 12, 7, 4, 'chuy og quality', '2026-02-27 06:27:24'),
(3, 12, 14, 5, 'wow', '2026-02-27 06:28:06'),
(4, 14, 6, 5, 'dadadadadada', '2026-02-27 08:31:03'),
(5, 14, 6, 2, 'asd', '2026-02-27 08:31:14');

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `product_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `rating` int(11) NOT NULL CHECK (`rating` between 1 and 5),
  `comment` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

CREATE TABLE `staff` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) DEFAULT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` varchar(50) DEFAULT 'delivery',
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `delivery_area` varchar(100) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`id`, `name`, `email`, `password_hash`, `role`, `phone`, `address`, `delivery_area`, `created_at`) VALUES
(1, 'Sherwin C Torrejas', 'sherwin@gmail.com', '$2y$10$XdcmFGsWHzuwQ6lInzyfU.Tvxt86NoLtqZ/tJHa9mEihsG0TBowxm', 'Inventory', '09224349105', 'Tuyan Minglanilla', '', '2026-02-13 12:21:16'),
(2, 'Keith Clarence Aliporo', 'clarence@gmail.com', '$2y$10$Exbrlp23MY3SBZBM9Mfjk.SP2/Fs94aa8EgcdapbAsi2u4cR1AFoS', 'Support', '09683201419', 'taga ilaha', 'sa iyang gusto', '2026-02-18 12:38:32');

-- --------------------------------------------------------

--
-- Table structure for table `staff_attendance`
--

CREATE TABLE `staff_attendance` (
  `id` int(11) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `time_in` datetime DEFAULT NULL,
  `time_out` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `staff_attendance`
--

INSERT INTO `staff_attendance` (`id`, `staff_id`, `time_in`, `time_out`) VALUES
(1, 2, '2026-02-18 20:39:24', '2026-02-19 18:21:03');

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_name` varchar(100) NOT NULL,
  `issue` text NOT NULL,
  `reply` text DEFAULT NULL,
  `status` varchar(50) DEFAULT 'Pending',
  `assigned_to` int(11) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `support_tickets`
--

INSERT INTO `support_tickets` (`id`, `user_id`, `user_name`, `issue`, `reply`, `status`, `assigned_to`, `created_at`) VALUES
(1, 7, 'harold', 'my order hasn\'t arrived yet, it surpass the expected delivery date', NULL, 'Pending', NULL, '2026-02-19 10:40:09'),
(2, 7, 'harold', 'my order hasn\'t arrived yet, it surpass the expected delivery date', NULL, 'Pending', NULL, '2026-02-19 10:42:20'),
(3, 6, 'kit', 'my orders hasn\'t arrived yet', NULL, 'Pending', NULL, '2026-02-19 10:49:30');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(255) NOT NULL,
  `role` enum('customer','admin') DEFAULT 'customer',
  `street` varchar(255) NOT NULL,
  `city` varchar(100) NOT NULL,
  `province` varchar(100) NOT NULL,
  `zip` varchar(20) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `age` int(11) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `address` varchar(255) DEFAULT NULL,
  `distance_km` int(11) NOT NULL DEFAULT 0,
  `delivery_minutes` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `role`, `street`, `city`, `province`, `zip`, `birthday`, `age`, `created_at`, `address`, `distance_km`, `delivery_minutes`) VALUES
(1, 'admin', 'admin@gmail.com', '$2y$10$KpnYr7b.otSD2THcddSUd.L6rZECMAqtqTkShcUhp77M3aC95ZpH2', 'admin', '', '', '', NULL, NULL, 0, '2026-02-09 10:42:05', NULL, 0, 0),
(4, 'asd', 'dad@gmail.com', '$2y$10$WbpMBvoN8jLLox0prfpwIuhGJV4MZ9cZSHtZDxiLp0kQLQkH7d.I.', '', '', '', '', NULL, NULL, 0, '2026-02-11 09:26:48', NULL, 0, 0),
(5, 'andre', 'andre@gmail.com', '$2y$10$ywqKIUcFxg40l74/o8nfGOHZEGAU0clDA2rtI8EfM5MIDavGmEeHa', '', 'Poblacion Ward IV', 'Minglanilla', 'Cebu', '6046', '2006-08-25', 19, '2026-02-11 12:37:16', NULL, 0, 0),
(6, 'kit', 'kit@gmail.com', '$2y$10$cIutyxFJOgR4woMDKhvRQeHXY2/cYoCbX4FdlamnNuDaVEEnLqC1G', '', 'Ward IV', 'Minglanilla', 'Cebu', '6046', '2026-08-25', 0, '2026-02-12 09:42:18', NULL, 0, 0),
(7, 'harold', 'harold@gmail.com', '$2y$10$oiY3IGWCbwejM2SDvOtFkexKiiGUm1tXOrLE/mkZiTmapUAdJFWX2', '', 'Tulay', 'Cebu City', 'Cebu', '41490', '2004-02-11', 22, '2026-02-12 11:55:04', NULL, 0, 0),
(8, 'Sherwin', 'sherwin@gmail.com', '$2y$10$OCy3aedGaN2W.D6wOP/2GulNoclu2xB9l2v0KzefdZcl0mGoC.p0G', 'customer', 'Pob Ward IV', 'Minglanilla', 'Cebu', '6046', '2026-02-13', 0, '2026-02-13 06:39:55', NULL, 0, 0),
(9, 'das', 'das@gmail.com', '$2y$10$/oC2cQlU3TClX716/TUl2evhjjXfUtm37uXdZ8B8WlrL.wmCPivyi', 'customer', 'Damian Brown', 'Danao', 'Bohol', '41490', '2026-02-09', 0, '2026-02-13 07:01:06', NULL, 75, 113),
(10, 'jackdaniel', 'jackdaniel@gmail.com', '$2y$10$7TRTJ2ZwA2Czh7kfOM8FPuhZY5bWc1XSbmC/I7ylc8J.jg/DUmZua', 'customer', 'Calajoan', 'Minglanilla', 'Cebu', '4046', '2026-02-13', 0, '2026-02-13 09:01:55', NULL, 0, 0),
(11, 'olinar', 'olinar@gmail.com', '$2y$10$VHtYKAFUp5mRUetREZFgPe5E4crjUJA73Sxdmw9jloX2BAfr7.eA.', 'customer', 'tulay', 'Danao', 'Bohol', '4046', '2026-02-13', 0, '2026-02-13 09:46:07', NULL, 75, 113),
(12, 'jamero', 'jamero@gmail.com', '$2y$10$1iBrp6uzz./AKQSns2VMYeBqij2vjfYzeBUyl17yz2JH5J/tHzG1.', 'customer', 'cadulawant', 'Minglanilla', 'Cebu', '6046', '2004-07-06', 21, '2026-02-16 09:58:38', NULL, 0, 0),
(13, 'grace tutor', 'grace@gmail.com', '$2y$10$68QiCwWR/0MrP5k0FQucH.2A4vajJ05rI5814ayk5MC9jdrN.Ol0m', 'customer', 'casa mira ', 'Minglanilla', 'Cebu', '41490', '1992-07-04', 33, '2026-02-16 10:34:14', NULL, 0, 0),
(14, 'wakomoney', 'karuizawakei083@gmail.com', '$2y$10$5vzN6C3Rtne0GI7ztFjisuxkMNIno9twDWa7ARBcxA4tnsrIEgMZm', 'customer', 'Tulay', 'Minglanilla', 'Cebu', '6046', '2006-08-25', 19, '2026-02-24 07:35:54', NULL, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `inventory`
--
ALTER TABLE `inventory`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`),
  ADD KEY `category_id` (`category_id`);

--
-- Indexes for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `product_id` (`product_id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `staff`
--
ALTER TABLE `staff`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `staff_attendance`
--
ALTER TABLE `staff_attendance`
  ADD PRIMARY KEY (`id`),
  ADD KEY `staff_id` (`staff_id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `inventory`
--
ALTER TABLE `inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `product_reviews`
--
ALTER TABLE `product_reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `staff`
--
ALTER TABLE `staff`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `staff_attendance`
--
ALTER TABLE `staff_attendance`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `inventory`
--
ALTER TABLE `inventory`
  ADD CONSTRAINT `inventory_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`);

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `product_reviews`
--
ALTER TABLE `product_reviews`
  ADD CONSTRAINT `product_reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`),
  ADD CONSTRAINT `product_reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `reviews`
--
ALTER TABLE `reviews`
  ADD CONSTRAINT `reviews_ibfk_1` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `reviews_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `staff_attendance`
--
ALTER TABLE `staff_attendance`
  ADD CONSTRAINT `staff_attendance_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`id`) ON DELETE CASCADE;
--
-- Database: `databasesample`
--
CREATE DATABASE IF NOT EXISTS `databasesample` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `databasesample`;

-- --------------------------------------------------------

--
-- Table structure for table `salmon1`
--
-- Error reading structure for table databasesample.salmon1: #1932 - Table &#039;databasesample.salmon1&#039; doesn&#039;t exist in engine
-- Error reading data for table databasesample.salmon1: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `databasesample`.`salmon1`&#039; at line 1
--
-- Database: `happytails_db`
--
CREATE DATABASE IF NOT EXISTS `happytails_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `happytails_db`;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `u_id` int(10) NOT NULL,
  `u_fname` varchar(50) DEFAULT NULL,
  `u_lname` varchar(50) DEFAULT NULL,
  `u_username` varchar(50) DEFAULT NULL,
  `u_email` varchar(50) DEFAULT NULL,
  `u_type` varchar(20) DEFAULT NULL,
  `u_password` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`u_id`, `u_fname`, `u_lname`, `u_username`, `u_email`, `u_type`, `u_password`) VALUES
(1, 'mole', 'lester', 'molelester', 'testemail@gmail.com', 'Veterinarian', '123123123'),
(2, 'Peter', 'Griffin', 'PeterGriffin', 'petergriffin@gmail.com', 'Veterinarian', '123peter'),
(3, 'Kilexa', 'Morgan', 'Kilexa', 'kilexadmin@gmail.com', 'Admin', 'Alexa143091725');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`u_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `u_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
--
-- Database: `phpmyadmin`
--
CREATE DATABASE IF NOT EXISTS `phpmyadmin` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
USE `phpmyadmin`;

-- --------------------------------------------------------

--
-- Table structure for table `pma__bookmark`
--
-- Error reading structure for table phpmyadmin.pma__bookmark: #1932 - Table &#039;phpmyadmin.pma__bookmark&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__bookmark: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__bookmark`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__central_columns`
--
-- Error reading structure for table phpmyadmin.pma__central_columns: #1932 - Table &#039;phpmyadmin.pma__central_columns&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__central_columns: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__central_columns`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__column_info`
--
-- Error reading structure for table phpmyadmin.pma__column_info: #1932 - Table &#039;phpmyadmin.pma__column_info&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__column_info: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__column_info`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__designer_settings`
--
-- Error reading structure for table phpmyadmin.pma__designer_settings: #1932 - Table &#039;phpmyadmin.pma__designer_settings&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__designer_settings: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__designer_settings`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__export_templates`
--
-- Error reading structure for table phpmyadmin.pma__export_templates: #1932 - Table &#039;phpmyadmin.pma__export_templates&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__export_templates: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__export_templates`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__favorite`
--
-- Error reading structure for table phpmyadmin.pma__favorite: #1932 - Table &#039;phpmyadmin.pma__favorite&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__favorite: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__favorite`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__history`
--
-- Error reading structure for table phpmyadmin.pma__history: #1932 - Table &#039;phpmyadmin.pma__history&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__history: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__history`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__navigationhiding`
--
-- Error reading structure for table phpmyadmin.pma__navigationhiding: #1932 - Table &#039;phpmyadmin.pma__navigationhiding&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__navigationhiding: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__navigationhiding`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__pdf_pages`
--
-- Error reading structure for table phpmyadmin.pma__pdf_pages: #1932 - Table &#039;phpmyadmin.pma__pdf_pages&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__pdf_pages: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__pdf_pages`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__recent`
--
-- Error reading structure for table phpmyadmin.pma__recent: #1932 - Table &#039;phpmyadmin.pma__recent&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__recent: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__recent`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__relation`
--
-- Error reading structure for table phpmyadmin.pma__relation: #1932 - Table &#039;phpmyadmin.pma__relation&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__relation: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__relation`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__savedsearches`
--
-- Error reading structure for table phpmyadmin.pma__savedsearches: #1932 - Table &#039;phpmyadmin.pma__savedsearches&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__savedsearches: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__savedsearches`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_coords`
--
-- Error reading structure for table phpmyadmin.pma__table_coords: #1932 - Table &#039;phpmyadmin.pma__table_coords&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__table_coords: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__table_coords`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_info`
--
-- Error reading structure for table phpmyadmin.pma__table_info: #1932 - Table &#039;phpmyadmin.pma__table_info&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__table_info: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__table_info`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__table_uiprefs`
--
-- Error reading structure for table phpmyadmin.pma__table_uiprefs: #1932 - Table &#039;phpmyadmin.pma__table_uiprefs&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__table_uiprefs: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__table_uiprefs`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__tracking`
--
-- Error reading structure for table phpmyadmin.pma__tracking: #1932 - Table &#039;phpmyadmin.pma__tracking&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__tracking: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__tracking`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__userconfig`
--
-- Error reading structure for table phpmyadmin.pma__userconfig: #1932 - Table &#039;phpmyadmin.pma__userconfig&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__userconfig: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__userconfig`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__usergroups`
--
-- Error reading structure for table phpmyadmin.pma__usergroups: #1932 - Table &#039;phpmyadmin.pma__usergroups&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__usergroups: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__usergroups`&#039; at line 1

-- --------------------------------------------------------

--
-- Table structure for table `pma__users`
--
-- Error reading structure for table phpmyadmin.pma__users: #1932 - Table &#039;phpmyadmin.pma__users&#039; doesn&#039;t exist in engine
-- Error reading data for table phpmyadmin.pma__users: #1064 - You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near &#039;FROM `phpmyadmin`.`pma__users`&#039; at line 1
--
-- Database: `scholarshipmanagement`
--
CREATE DATABASE IF NOT EXISTS `scholarshipmanagement` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `scholarshipmanagement`;

-- --------------------------------------------------------

--
-- Table structure for table `activations`
--

CREATE TABLE `activations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `token` varchar(200) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `applications`
--

CREATE TABLE `applications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `scholarship_id` int(11) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `details` text DEFAULT NULL,
  `status` enum('submitted','pending','approved','rejected') DEFAULT 'submitted',
  `reviewer_id` int(11) DEFAULT NULL,
  `document` varchar(255) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `awards`
--

CREATE TABLE `awards` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `scholarship_id` int(11) DEFAULT NULL,
  `award_amount` decimal(10,2) DEFAULT NULL,
  `award_date` date DEFAULT NULL,
  `status` enum('pending','approved','disbursed','cancelled') DEFAULT 'pending',
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `disbursements`
--

CREATE TABLE `disbursements` (
  `id` int(11) NOT NULL,
  `award_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `amount` decimal(10,2) NOT NULL,
  `disbursement_date` date DEFAULT NULL,
  `payment_method` varchar(50) DEFAULT NULL,
  `transaction_reference` varchar(255) DEFAULT NULL,
  `status` enum('pending','processed','completed','failed') DEFAULT 'pending',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documents`
--

CREATE TABLE `documents` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL,
  `document_type` varchar(100) DEFAULT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(500) DEFAULT NULL,
  `file_size` int(11) DEFAULT NULL,
  `mime_type` varchar(100) DEFAULT NULL,
  `uploaded_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `eligibility_requirements`
--

CREATE TABLE `eligibility_requirements` (
  `id` int(11) NOT NULL,
  `scholarship_id` int(11) NOT NULL,
  `requirement` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `eligibility_requirements`
--

INSERT INTO `eligibility_requirements` (`id`, `scholarship_id`, `requirement`, `created_at`) VALUES
(1, 1, 'GPA >= 3.5', '2026-02-02 14:48:59'),
(2, 1, 'Enrolled full-time', '2026-02-02 14:48:59'),
(3, 2, 'Pursuing degree in STEM', '2026-02-02 14:48:59');

-- --------------------------------------------------------

--
-- Table structure for table `email_verification_codes`
--

CREATE TABLE `email_verification_codes` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  `code` varchar(10) NOT NULL,
  `type` enum('verification','login','password_reset') DEFAULT 'verification',
  `expires_at` datetime NOT NULL,
  `used` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `email_verification_codes`
--

INSERT INTO `email_verification_codes` (`id`, `user_id`, `email`, `code`, `type`, `expires_at`, `used`, `created_at`) VALUES
(1, 3, 'johnlloydracaza88@gmail.com', '272366', 'verification', '2026-02-02 08:03:59', 0, '2026-02-02 14:48:59'),
(2, 3, 'johnlloydracaza88@gmail.com', '506547', 'password_reset', '2026-02-02 08:07:23', 0, '2026-02-02 14:52:23'),
(3, 3, 'johnlloydracaza88@gmail.com', '017500', 'password_reset', '2026-02-02 08:07:25', 0, '2026-02-02 14:52:25'),
(4, 3, 'johnlloydracaza88@gmail.com', '401438', 'password_reset', '2026-02-02 08:16:34', 0, '2026-02-02 15:01:34'),
(5, 3, 'johnlloydracaza88@gmail.com', '885537', 'password_reset', '2026-02-02 08:24:14', 0, '2026-02-02 15:09:14'),
(6, 3, 'johnlloydracaza88@gmail.com', '485770', 'password_reset', '2026-02-02 08:24:52', 0, '2026-02-02 15:09:52'),
(7, 3, 'johnlloydracaza88@gmail.com', '497583', 'password_reset', '2026-02-02 08:29:34', 0, '2026-02-02 15:14:34');

-- --------------------------------------------------------

--
-- Table structure for table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `message` text DEFAULT NULL,
  `type` enum('info','success','warning','error') DEFAULT 'info',
  `seen` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `token` varchar(200) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE `reviews` (
  `id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `reviewer_id` int(11) DEFAULT NULL,
  `comments` text DEFAULT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `scholarships`
--

CREATE TABLE `scholarships` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `organization` varchar(150) DEFAULT NULL,
  `status` enum('open','closed') DEFAULT 'open',
  `deadline` date DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `scholarships`
--

INSERT INTO `scholarships` (`id`, `title`, `description`, `organization`, `status`, `deadline`, `amount`, `created_at`) VALUES
(1, 'Academic Excellence Scholarship', 'For top performing students with GPA above 3.5', 'University Fund', 'open', NULL, NULL, '2026-02-02 14:48:59'),
(2, 'STEM Innovators Grant', 'Supporting STEM research and innovation', 'Tech Foundation', 'open', NULL, NULL, '2026-02-02 14:48:59');

-- --------------------------------------------------------

--
-- Table structure for table `students`
--

CREATE TABLE `students` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `student_number` varchar(50) DEFAULT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `gpa` decimal(3,2) DEFAULT NULL,
  `enrollment_status` enum('full-time','part-time','graduated') DEFAULT 'full-time',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `first_name` varchar(100) DEFAULT NULL,
  `last_name` varchar(100) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `role` enum('admin','reviewer','student','staff') DEFAULT 'student',
  `active` tinyint(1) DEFAULT 1,
  `email_verified` tinyint(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `secret_question` varchar(255) DEFAULT NULL,
  `secret_answer_hash` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `first_name`, `last_name`, `email`, `phone`, `address`, `role`, `active`, `email_verified`, `created_at`, `secret_question`, `secret_answer_hash`) VALUES
(1, 'admin', '123123', NULL, NULL, 'admin@example.com', NULL, NULL, 'admin', 1, 1, '2026-02-02 14:42:29', NULL, NULL),
(3, 'johnlloyd1', '$2y$10$keJEPsZJ23NT.TSZV7744ODMvaOPCjO5K9rX6aLMJaDxT6Xr/xQku', 'John Lloyd', 'Racaza', 'johnlloydracaza88@gmail.com', '09951954551', 'Lower Tunghaan Minglanilla, Cebu', 'admin', 1, 0, '2026-02-02 14:48:59', NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `activations`
--
ALTER TABLE `activations`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `applications`
--
ALTER TABLE `applications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `scholarship_id` (`scholarship_id`);

--
-- Indexes for table `awards`
--
ALTER TABLE `awards`
  ADD PRIMARY KEY (`id`),
  ADD KEY `application_id` (`application_id`);

--
-- Indexes for table `disbursements`
--
ALTER TABLE `disbursements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `award_id` (`award_id`);

--
-- Indexes for table `documents`
--
ALTER TABLE `documents`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `application_id` (`application_id`);

--
-- Indexes for table `eligibility_requirements`
--
ALTER TABLE `eligibility_requirements`
  ADD PRIMARY KEY (`id`),
  ADD KEY `scholarship_id` (`scholarship_id`);

--
-- Indexes for table `email_verification_codes`
--
ALTER TABLE `email_verification_codes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `idx_code_email` (`code`,`email`),
  ADD KEY `idx_expires` (`expires_at`);

--
-- Indexes for table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `reviews`
--
ALTER TABLE `reviews`
  ADD PRIMARY KEY (`id`),
  ADD KEY `application_id` (`application_id`),
  ADD KEY `reviewer_id` (`reviewer_id`);

--
-- Indexes for table `scholarships`
--
ALTER TABLE `scholarships`
  ADD UNIQUE KEY `unique_scholarship` (`title`,`organization`,`deadline`,`amount`);

--
-- Indexes for table `students`
--
ALTER TABLE `students`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `student_number` (`student_number`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `activations`
--
ALTER TABLE `activations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `applications`
--
ALTER TABLE `applications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `awards`
--
ALTER TABLE `awards`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `disbursements`
--
ALTER TABLE `disbursements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `documents`
--
ALTER TABLE `documents`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `eligibility_requirements`
--
ALTER TABLE `eligibility_requirements`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `email_verification_codes`
--
ALTER TABLE `email_verification_codes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `reviews`
--
ALTER TABLE `reviews`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `students`
--
ALTER TABLE `students`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `activations`
--
ALTER TABLE `activations`
  ADD CONSTRAINT `activations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Database: `teacher_schedules_db`
--
CREATE DATABASE IF NOT EXISTS `teacher_schedules_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `teacher_schedules_db`;

-- --------------------------------------------------------

--
-- Table structure for table `earnings`
--

CREATE TABLE `earnings` (
  `id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schedules`
--

CREATE TABLE `schedules` (
  `id` int(11) NOT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `subject` varchar(100) DEFAULT NULL,
  `day` varchar(20) DEFAULT NULL,
  `time_start` time DEFAULT NULL,
  `time_end` time DEFAULT NULL,
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedules`
--

INSERT INTO `schedules` (`id`, `teacher_id`, `subject`, `day`, `time_start`, `time_end`, `start_time`, `end_time`, `created_at`) VALUES
(1, 1, 'MATH', 'Monday', '10:00:00', '12:00:00', NULL, NULL, '2026-02-27 09:53:50'),
(2, 7, 'Programmer', 'Wednesday', '10:00:00', '12:00:00', NULL, NULL, '2026-02-27 09:56:47');

-- --------------------------------------------------------

--
-- Table structure for table `session_requests`
--

CREATE TABLE `session_requests` (
  `id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `schedule_id` int(11) NOT NULL,
  `status` enum('pending','confirmed','rejected') NOT NULL DEFAULT 'pending',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `session_requests`
--

INSERT INTO `session_requests` (`id`, `student_id`, `schedule_id`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 2, 'pending', '2026-02-27 09:57:06', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(225) NOT NULL,
  `fullname` varchar(225) NOT NULL,
  `email` varchar(225) NOT NULL,
  `password` varchar(225) NOT NULL,
  `role` varchar(225) NOT NULL,
  `status` varchar(225) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `fullname`, `email`, `password`, `role`, `status`, `created_at`) VALUES
(1, 'bryl', 'brylcabanes@gmail.com', '$2y$10$I2jMDO3/1ci6eVrrywj8L.Y2WvKHOvFtQTVIB.x1UejptIbkTzGJq', 'Student', 'Active', '2026-02-27 08:51:12'),
(2, 'gwapo', 'gwapo@scc.com', '$2y$10$ISUjvkEaqC1dwGXgMBhAg..DDLrOf64DXI/jqhl0FAzQ/PB2M5sli', '', '', '2026-02-27 08:51:12'),
(3, 'admin', 'admin@scc.com', '$2y$10$7PBZa1gxyymTz7S770boiuBqUToPQW3TmKaDedpX9ou4stlszj9NK', '', '', '2026-02-27 08:51:12'),
(4, 'admin', 'admin@scc.com', '$2y$10$22qQATUtdj2EluaK3xK.SON7qPGnD8q3un.R5cS1K8vAoUGSjQTHS', '', '', '2026-02-27 08:51:12'),
(5, 'jack', 'jack@scc.com', '$2y$10$Dtrf7MaP/DFqlWvqixTVauQlmWsB.SrsW7LBv5Gn42h8nmyRr3kQS', '', '', '2026-02-27 08:51:12'),
(6, 'me', '1234@gmail.com', '$2y$10$ARoUqqYW3PpAMfPzo/9JVO9uzzIS1lJmAQwQDfPOx0gqQ8cZen5wW', '', '', '2026-02-27 08:51:12'),
(7, 'brylrabadon', 'brylrabadon@scc.com', '$2y$10$8yOIRg2HUJ8qLazENtWBeOIPM4zXs0emQZcHSahGbE7NtOajMz2JC', 'Teacher', 'Active', '2026-02-27 09:55:48');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `earnings`
--
ALTER TABLE `earnings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schedules`
--
ALTER TABLE `schedules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `teacher_id` (`teacher_id`);

--
-- Indexes for table `session_requests`
--
ALTER TABLE `session_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `student_id` (`student_id`),
  ADD KEY `schedule_id` (`schedule_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `earnings`
--
ALTER TABLE `earnings`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedules`
--
ALTER TABLE `schedules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `session_requests`
--
ALTER TABLE `session_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(225) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `schedules`
--
ALTER TABLE `schedules`
  ADD CONSTRAINT `schedules_ibfk_1` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `session_requests`
--
ALTER TABLE `session_requests`
  ADD CONSTRAINT `session_requests_schedule` FOREIGN KEY (`schedule_id`) REFERENCES `schedules` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `session_requests_student` FOREIGN KEY (`student_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
--
-- Database: `test`
--
CREATE DATABASE IF NOT EXISTS `test` DEFAULT CHARACTER SET latin1 COLLATE latin1_swedish_ci;
USE `test`;
--
-- Database: `vehicle`
--
CREATE DATABASE IF NOT EXISTS `vehicle` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `vehicle`;
--
-- Database: `vehicleofficial`
--
CREATE DATABASE IF NOT EXISTS `vehicleofficial` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;
USE `vehicleofficial`;

-- --------------------------------------------------------

--
-- Table structure for table `carbrand`
--

CREATE TABLE `carbrand` (
  `Car_BrandID` int(11) NOT NULL,
  `Car_Brand` varchar(100) NOT NULL,
  `BrandImage` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `carbrand`
--

INSERT INTO `carbrand` (`Car_BrandID`, `Car_Brand`, `BrandImage`) VALUES
(2, 'Lamborghini', 'lamborghini_logo.png'),
(4, 'McLaren', 'mclaren_logo.png'),
(5, 'Ferrari', 'logo_1771494075_FerrariLogo.jpg'),
(6, 'PORSHE', 'logo_1771494187_PorsheLogo.jpg'),
(7, 'ferraro', 'logo_1772531934_danigga.png');

-- --------------------------------------------------------

--
-- Table structure for table `car info`
--

CREATE TABLE `car info` (
  `Car_BrandID` int(11) NOT NULL,
  `Car_Model` varchar(255) NOT NULL,
  `Car_Color` varchar(50) DEFAULT 'Midnight Black',
  `Manu_Year` int(11) NOT NULL,
  `Price` decimal(15,2) NOT NULL,
  `Mileage` int(11) NOT NULL,
  `Top_Speed` int(11) NOT NULL,
  `Transmission` varchar(50) NOT NULL,
  `Fuel_Type` varchar(50) NOT NULL,
  `VIN` varchar(17) NOT NULL,
  `Status` varchar(20) DEFAULT 'Available',
  `Image_Path` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `car info`
--

INSERT INTO `car info` (`Car_BrandID`, `Car_Model`, `Car_Color`, `Manu_Year`, `Price`, `Mileage`, `Top_Speed`, `Transmission`, `Fuel_Type`, `VIN`, `Status`, `Image_Path`) VALUES
(2, 'Veneno LP 750-4', 'Arctic White', 2013, 4500000.00, 150, 355, 'Dual-Clutch', 'Gasoline', 'VEX-LV750-WHI-001', 'Available', '1772186489_white_veneno.png'),
(7, 'harold', 'Midnight Black', 1967, 1.00, 2147483647, 10, 'Dual-Clutch', 'Hybrid', '676767676767', 'Available', '1772531934_weird.png');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `status` enum('Pending','Approved') DEFAULT 'Pending',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `role` varchar(20) DEFAULT 'customer'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `username`, `email`, `password`, `status`, `created_at`, `role`) VALUES
(1, 'Kit Aliporo', 'walli@gmail.com', '$2y$10$dXiWwJKrsRBdjzJYiaTizeloEkO56PKuBpimv52/joMmpau9ANFHK', 'Approved', '2026-03-03 04:49:41', 'customer'),
(2, 'Christian Andre', 'cacr@gmail.com', '$2y$10$HUOsKlq3105Ea9fjb/UH2OrSA8dyz5KeUGofjrfzQ3XriKJDLMHFS', 'Approved', '2026-03-03 09:10:06', 'customer'),
(3, 'Marjon Claro', 'marjonclaro7@gmail.com', '$2y$10$fr6v37J89uhyVZs4LqmcHOslPV97zaexCa2PVpNmzf5RDtVD8lonS', 'Approved', '2026-03-03 09:39:47', 'customer'),
(4, 'harold', 'harold@gmail.com', '$2y$10$rbZJNPRYZXxEQy/tjozscOI.E9SaX.DY7TcbjpybK9CMig2o.t.Du', 'Approved', '2026-03-03 09:55:06', 'customer');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `carbrand`
--
ALTER TABLE `carbrand`
  ADD PRIMARY KEY (`Car_BrandID`);

--
-- Indexes for table `car info`
--
ALTER TABLE `car info`
  ADD PRIMARY KEY (`Car_BrandID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `carbrand`
--
ALTER TABLE `carbrand`
  MODIFY `Car_BrandID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `car info`
--
ALTER TABLE `car info`
  MODIFY `Car_BrandID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
