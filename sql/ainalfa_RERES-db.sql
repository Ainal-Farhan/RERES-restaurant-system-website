-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Dec 22, 2020 at 09:49 AM
-- Server version: 5.7.31
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+08:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ainalfa_RERES-db`
--

-- --------------------------------------------------------

--
-- Table structure for table `Booking`
--

CREATE TABLE `Booking` (
  `booking_id` int(10) UNSIGNED NOT NULL,
  `booking_description` varchar(1000) COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_date` date NOT NULL,
  `booking_duration` int(11) NOT NULL,
  `booking_start_time` time NOT NULL,
  `booking_end_time` time NOT NULL,
  `booking_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fk_customerID` int(10) UNSIGNED DEFAULT NULL,
  `fk_paymentID` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Booking`
--

INSERT INTO `Booking` (`booking_id`, `booking_description`, `booking_date`, `booking_duration`, `booking_start_time`, `booking_end_time`, `booking_status`, `fk_customerID`, `fk_paymentID`) VALUES
(1, 'none', '2020-10-10', 2, '19:00:00', '21:00:00', 'none', 1, 1),
(2, 'none', '2020-10-10', 2, '19:00:00', '21:00:00', 'success', 1, 2),
(3, 'none', '2020-10-10', 2, '19:00:00', '21:00:00', 'failed', 1, 3),
(4, 'none', '2020-10-10', 2, '19:00:00', '21:00:00', 'cancaled', 1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `Customer`
--

CREATE TABLE `Customer` (
  `customer_id` int(10) UNSIGNED NOT NULL,
  `customer_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_birth_date` date NOT NULL,
  `customer_age` int(11) NOT NULL,
  `customer_email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_phone_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_profile_picture_path` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'default.png',
  `customer_gender` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'male'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Customer`
--

INSERT INTO `Customer` (`customer_id`, `customer_name`, `customer_birth_date`, `customer_age`, `customer_email`, `customer_address`, `customer_phone_number`, `customer_profile_picture_path`, `customer_gender`) VALUES
(1, 'customer 1', '1999-01-01', 21, 'customer1@gmail.com', 'No 3 Blok 4 Jalan Customer 1, Lurah Bilut, 28800 Bentong, Pahang, Malaysia', '01111888735', 'default.png', 'male');

-- --------------------------------------------------------

--
-- Table structure for table `Payment`
--

CREATE TABLE `Payment` (
  `payment_id` int(10) UNSIGNED NOT NULL,
  `payment_status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_method` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `total_payment` decimal(10,2) DEFAULT '0.00'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Payment`
--

INSERT INTO `Payment` (`payment_id`, `payment_status`, `payment_method`, `total_payment`) VALUES
(1, 'No Payment', 'Visa', 23.21),
(2, 'Success', 'MasterCard', 43.21),
(3, 'Rejected', 'Visa', 21.21),
(4, 'Canceled', 'MasterCard', 123.32);

-- --------------------------------------------------------

--
-- Table structure for table `Staff`
--

CREATE TABLE `Staff` (
  `staff_id` int(10) UNSIGNED NOT NULL,
  `staff_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `staff_birth_date` date NOT NULL,
  `staff_age` int(11) NOT NULL,
  `staff_email` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `staff_address` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `staff_phone_number` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `staff_profile_picture_path` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'default.png',
  `staff_gender` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'male'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `Staff`
--

INSERT INTO `Staff` (`staff_id`, `staff_name`, `staff_birth_date`, `staff_age`, `staff_email`, `staff_address`, `staff_phone_number`, `staff_profile_picture_path`, `staff_gender`) VALUES
(1, 'staff 1', '1999-01-01', 21, 'staff1@gmail.com', 'Lot 2-3 Rumah Ladang Felda Krau 04 Taman Merbau, 67329 Selayang, Selangor, Malaysia ', '0139283332', 'default.png', 'male');

-- --------------------------------------------------------

--
-- Table structure for table `User`
--

CREATE TABLE `User` (
  `user_id` int(10) UNSIGNED NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fk_customerID` int(10) UNSIGNED DEFAULT NULL,
  `fk_staffID` int(10) UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `User`
--

INSERT INTO `User` (`user_id`, `username`, `password`, `user_type`, `fk_customerID`, `fk_staffID`) VALUES
(1, 'staff1', 'staff1@123', 'staff', NULL, 1),
(2, 'customer1', 'customer1@123', 'customer', 1, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Booking`
--
ALTER TABLE `Booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `fk_customerID` (`fk_customerID`),
  ADD KEY `fk_paymentID` (`fk_paymentID`);

--
-- Indexes for table `Customer`
--
ALTER TABLE `Customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- Indexes for table `Payment`
--
ALTER TABLE `Payment`
  ADD PRIMARY KEY (`payment_id`);

--
-- Indexes for table `Staff`
--
ALTER TABLE `Staff`
  ADD PRIMARY KEY (`staff_id`);

--
-- Indexes for table `User`
--
ALTER TABLE `User`
  ADD PRIMARY KEY (`user_id`),
  ADD KEY `fk_customerID` (`fk_customerID`),
  ADD KEY `fk_staffID` (`fk_staffID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Booking`
--
ALTER TABLE `Booking`
  MODIFY `booking_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Customer`
--
ALTER TABLE `Customer`
  MODIFY `customer_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Payment`
--
ALTER TABLE `Payment`
  MODIFY `payment_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `Staff`
--
ALTER TABLE `Staff`
  MODIFY `staff_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `User`
--
ALTER TABLE `User`
  MODIFY `user_id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Booking`
--
ALTER TABLE `Booking`
  ADD CONSTRAINT `Booking_ibfk_1` FOREIGN KEY (`fk_customerID`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `Booking_ibfk_2` FOREIGN KEY (`fk_paymentID`) REFERENCES `Payment` (`payment_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `User`
--
ALTER TABLE `User`
  ADD CONSTRAINT `User_ibfk_1` FOREIGN KEY (`fk_customerID`) REFERENCES `Customer` (`customer_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `User_ibfk_2` FOREIGN KEY (`fk_staffID`) REFERENCES `Staff` (`staff_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
