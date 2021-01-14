-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Jan 14, 2021 at 09:07 AM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `reres-db`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL,
  `booking_description` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `booking_date` date NOT NULL,
  `booking_duration` int(11) NOT NULL,
  `booking_start_time` time NOT NULL,
  `booking_end_time` time NOT NULL,
  `booking_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `booking_quantity` int(11) NOT NULL,
  `booking_price` double NOT NULL,
  `booking_date_created` datetime NOT NULL DEFAULT current_timestamp(),
  `fk_userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `booking`
--

INSERT INTO `booking` (`booking_id`, `booking_description`, `booking_date`, `booking_duration`, `booking_start_time`, `booking_end_time`, `booking_status`, `booking_quantity`, `booking_price`, `booking_date_created`, `fk_userID`) VALUES
(1, 'birthday party', '2021-01-05', 3, '12:10:49', '15:10:49', 'success', 10, 120.21, '2021-01-13 08:03:08', 1),
(2, 'test2', '2021-01-22', 2, '12:00:00', '14:00:00', 'success', 20, 300.5, '2021-01-14 15:37:41', 1);

-- --------------------------------------------------------

--
-- Table structure for table `food`
--

CREATE TABLE `food` (
  `food_id` int(11) NOT NULL,
  `food_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `food_price` double NOT NULL DEFAULT 0,
  `food_description` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `food_photo` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'food-photo-default.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `food`
--

INSERT INTO `food` (`food_id`, `food_name`, `food_price`, `food_description`, `food_photo`) VALUES
(1, 'Nasi Kandar', 10, 'Nasi Kandar Penang Special', 'food-photo-default.png'),
(2, 'Nasi Kerabu', 5.5, 'Nasi Kerabu Special', 'food-photo-default.png');

-- --------------------------------------------------------

--
-- Table structure for table `membership`
--

CREATE TABLE `membership` (
  `member_id` int(11) NOT NULL,
  `member_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `voucher_redeem` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `member_status` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fk_userID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `orderitem`
--

CREATE TABLE `orderitem` (
  `order_item_id` int(11) NOT NULL,
  `item_quantity` int(11) NOT NULL,
  `total_price` double NOT NULL,
  `fk_bookingID` int(11) NOT NULL,
  `fk_foodID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orderitem`
--

INSERT INTO `orderitem` (`order_item_id`, `item_quantity`, `total_price`, `fk_bookingID`, `fk_foodID`) VALUES
(1, 12, 66, 1, 2),
(2, 12, 120, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `payment_id` int(11) NOT NULL,
  `payment_status` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `payment_method` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'none',
  `total_payment` double NOT NULL DEFAULT 0,
  `date_paid` date NOT NULL DEFAULT current_timestamp(),
  `fk_bookingID` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `payment`
--

INSERT INTO `payment` (`payment_id`, `payment_status`, `payment_method`, `total_payment`, `date_paid`, `fk_bookingID`) VALUES
(2, 'done', 'visa', 300.5, '2021-01-14', 2),
(3, 'done', 'visa', 306.21, '2021-01-14', 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `user_id` int(11) NOT NULL,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_type` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `age` int(11) NOT NULL,
  `birth_date` date NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `gender` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone_number` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `profile_photo` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'profile-photo-default.png'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`user_id`, `username`, `password`, `user_type`, `name`, `age`, `birth_date`, `email`, `address`, `gender`, `phone_number`, `profile_photo`) VALUES
(1, 'azman123', 'azman@123', 'customer', 'Mohd Nor Azman bin Hussain', 22, '1999-01-01', 'azman.nor123@gmail.com', 'Rumah Petugas Ladang Felda Krau 01\r\nPos Lurah Bilit\r\n28800\r\nBentong\r\nPahang\r\nMalaysia', 'male', '01122772634', 'profile-photo-default.png'),
(2, 'sitizaleh', 'siti@123', 'staff', 'Siti Nur Zaleha binti Sulaiman', 21, '1999-03-11', 'siti.zaleha@gmail.com', 'No 3, Lot 9\r\nJalan Gemilang 3 Kg Bendahara\r\n28392 \r\nSelayang\r\nSelangor\r\nMalaysia', 'female', '0138261782', 'profile-photo-default.png');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `fk_userIDBooking` (`fk_userID`);

--
-- Indexes for table `food`
--
ALTER TABLE `food`
  ADD PRIMARY KEY (`food_id`);

--
-- Indexes for table `membership`
--
ALTER TABLE `membership`
  ADD PRIMARY KEY (`member_id`),
  ADD KEY `fk_userIDMembership` (`fk_userID`);

--
-- Indexes for table `orderitem`
--
ALTER TABLE `orderitem`
  ADD PRIMARY KEY (`order_item_id`),
  ADD KEY `fk_bookingIDOrderItem` (`fk_bookingID`),
  ADD KEY `fk_foodIDOrderItem` (`fk_foodID`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`payment_id`),
  ADD UNIQUE KEY `fk_bookingIDPayment` (`fk_bookingID`) USING BTREE;

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `food`
--
ALTER TABLE `food`
  MODIFY `food_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `membership`
--
ALTER TABLE `membership`
  MODIFY `member_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `orderitem`
--
ALTER TABLE `orderitem`
  MODIFY `order_item_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `payment`
--
ALTER TABLE `payment`
  MODIFY `payment_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `fk_userIDBooking` FOREIGN KEY (`fk_userID`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `membership`
--
ALTER TABLE `membership`
  ADD CONSTRAINT `fk_userIDMembership` FOREIGN KEY (`fk_userID`) REFERENCES `user` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `orderitem`
--
ALTER TABLE `orderitem`
  ADD CONSTRAINT `fk_bookingIDOrderItem` FOREIGN KEY (`fk_bookingID`) REFERENCES `booking` (`booking_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_foodIDOrderItem` FOREIGN KEY (`fk_foodID`) REFERENCES `food` (`food_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `fk_bookingIDPayment` FOREIGN KEY (`fk_bookingID`) REFERENCES `booking` (`booking_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
