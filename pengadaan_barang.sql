-- phpMyAdmin SQL Dump
-- version 4.9.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 14, 2020 at 04:42 AM
-- Server version: 10.4.8-MariaDB
-- PHP Version: 7.3.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pengadaan_barang`
--

-- --------------------------------------------------------

--
-- Table structure for table `acount`
--

CREATE TABLE `acount` (
  `acount_id` char(12) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `transaction_id` char(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `acounting_transaction`
--

CREATE TABLE `acounting_transaction` (
  `transaction_id` char(12) NOT NULL,
  `transaction_date` datetime DEFAULT NULL,
  `acount_id` char(12) NOT NULL,
  `total` decimal(12,0) NOT NULL,
  `IV_status` varchar(30) NOT NULL,
  `GR_status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `goods`
--

CREATE TABLE `goods` (
  `goods_id` char(10) NOT NULL,
  `Reqdet_id` char(12) NOT NULL,
  `name_description` varchar(30) DEFAULT NULL,
  `price` decimal(12,0) DEFAULT NULL,
  `current_stock` char(7) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `good_receipts`
--

CREATE TABLE `good_receipts` (
  `GR_status` varchar(30) NOT NULL,
  `Storage_id` char(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `good_receipts_detail`
--

CREATE TABLE `good_receipts_detail` (
  `Grdet_id` char(12) NOT NULL,
  `amount` varchar(30) DEFAULT NULL,
  `GR_status` varchar(30) DEFAULT NULL,
  `IV_status` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_verification`
--

CREATE TABLE `invoice_verification` (
  `IV_status` varchar(30) NOT NULL,
  `IV_amount` varchar(30) DEFAULT NULL,
  `description` varchar(30) DEFAULT NULL,
  `total` decimal(9,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `payment`
--

CREATE TABLE `payment` (
  `total` decimal(12,0) NOT NULL,
  `IV_status` varchar(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order`
--

CREATE TABLE `purchase_order` (
  `PO_id` char(12) NOT NULL,
  `PO_date` timestamp NULL DEFAULT NULL,
  `PO_status` varchar(30) DEFAULT NULL,
  `Delivery_date` datetime DEFAULT NULL,
  `Payment_item` decimal(9,0) NOT NULL,
  `suplier_id` char(7) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `purchase_order_detail`
--

CREATE TABLE `purchase_order_detail` (
  `PODET_id` char(12) NOT NULL,
  `PO_status` varchar(30) NOT NULL,
  `price` decimal(9,0) DEFAULT NULL,
  `PO_id` char(12) DEFAULT NULL,
  `Grdet_id` char(12) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `requirements`
--

CREATE TABLE `requirements` (
  `Req_id` char(12) NOT NULL,
  `date` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `requirement_details`
--

CREATE TABLE `requirement_details` (
  `Reqdet_id` char(12) NOT NULL,
  `Reqdet_status` datetime NOT NULL,
  `amount` varchar(30) NOT NULL,
  `Req_id` char(12) NOT NULL,
  `PODET_id` char(12) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `storage_location`
--

CREATE TABLE `storage_location` (
  `storage_id` char(12) NOT NULL,
  `location` varchar(5) DEFAULT NULL,
  `contact` decimal(12,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Table structure for table `suplier`
--

CREATE TABLE `suplier` (
  `suplier_id` char(7) NOT NULL,
  `suplier_name` varchar(30) DEFAULT NULL,
  `company_name` varchar(30) DEFAULT NULL,
  `contact` char(13) DEFAULT NULL,
  `addres` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `acount`
--
ALTER TABLE `acount`
  ADD PRIMARY KEY (`acount_id`);

--
-- Indexes for table `acounting_transaction`
--
ALTER TABLE `acounting_transaction`
  ADD PRIMARY KEY (`transaction_id`),
  ADD KEY `acount_id` (`acount_id`),
  ADD KEY `IV_status` (`IV_status`),
  ADD KEY `GR_status` (`GR_status`),
  ADD KEY `total` (`total`);

--
-- Indexes for table `goods`
--
ALTER TABLE `goods`
  ADD PRIMARY KEY (`goods_id`),
  ADD KEY `Requirements_detail` (`Reqdet_id`);

--
-- Indexes for table `good_receipts`
--
ALTER TABLE `good_receipts`
  ADD PRIMARY KEY (`GR_status`),
  ADD KEY `Storage_Location` (`Storage_id`);

--
-- Indexes for table `good_receipts_detail`
--
ALTER TABLE `good_receipts_detail`
  ADD PRIMARY KEY (`Grdet_id`),
  ADD KEY `Good_receipts` (`GR_status`),
  ADD KEY `Invoice_verification` (`IV_status`);

--
-- Indexes for table `invoice_verification`
--
ALTER TABLE `invoice_verification`
  ADD PRIMARY KEY (`IV_status`);

--
-- Indexes for table `payment`
--
ALTER TABLE `payment`
  ADD PRIMARY KEY (`total`),
  ADD KEY `IV_status` (`IV_status`);

--
-- Indexes for table `purchase_order`
--
ALTER TABLE `purchase_order`
  ADD PRIMARY KEY (`PO_id`),
  ADD UNIQUE KEY `PO_status` (`PO_status`),
  ADD KEY `PO_id` (`PO_status`),
  ADD KEY `Supliers` (`suplier_id`);

--
-- Indexes for table `purchase_order_detail`
--
ALTER TABLE `purchase_order_detail`
  ADD PRIMARY KEY (`PODET_id`),
  ADD KEY `PO_id` (`PO_id`),
  ADD KEY `PO_id_2` (`PO_id`),
  ADD KEY `Grdet_id` (`Grdet_id`),
  ADD KEY `PO_id_3` (`PO_id`),
  ADD KEY `purchase_order_detail_ibfk_1` (`PO_status`);

--
-- Indexes for table `requirements`
--
ALTER TABLE `requirements`
  ADD PRIMARY KEY (`Req_id`);

--
-- Indexes for table `requirement_details`
--
ALTER TABLE `requirement_details`
  ADD PRIMARY KEY (`Reqdet_id`),
  ADD KEY `Requirements` (`Req_id`),
  ADD KEY `Purchase_order_detail` (`PODET_id`);

--
-- Indexes for table `storage_location`
--
ALTER TABLE `storage_location`
  ADD PRIMARY KEY (`storage_id`);

--
-- Indexes for table `suplier`
--
ALTER TABLE `suplier`
  ADD PRIMARY KEY (`suplier_id`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `acounting_transaction`
--
ALTER TABLE `acounting_transaction`
  ADD CONSTRAINT `acounting_transaction_ibfk_1` FOREIGN KEY (`acount_id`) REFERENCES `acount` (`acount_id`),
  ADD CONSTRAINT `acounting_transaction_ibfk_2` FOREIGN KEY (`IV_status`) REFERENCES `invoice_verification` (`IV_status`),
  ADD CONSTRAINT `acounting_transaction_ibfk_3` FOREIGN KEY (`GR_status`) REFERENCES `good_receipts` (`GR_status`),
  ADD CONSTRAINT `acounting_transaction_ibfk_4` FOREIGN KEY (`total`) REFERENCES `payment` (`total`);

--
-- Constraints for table `goods`
--
ALTER TABLE `goods`
  ADD CONSTRAINT `goods_ibfk_1` FOREIGN KEY (`Reqdet_id`) REFERENCES `requirement_details` (`Reqdet_id`);

--
-- Constraints for table `good_receipts`
--
ALTER TABLE `good_receipts`
  ADD CONSTRAINT `good_receipts_ibfk_1` FOREIGN KEY (`Storage_id`) REFERENCES `storage_location` (`storage_id`);

--
-- Constraints for table `good_receipts_detail`
--
ALTER TABLE `good_receipts_detail`
  ADD CONSTRAINT `good_receipts_detail_ibfk_1` FOREIGN KEY (`IV_status`) REFERENCES `invoice_verification` (`IV_status`);

--
-- Constraints for table `payment`
--
ALTER TABLE `payment`
  ADD CONSTRAINT `payment_ibfk_1` FOREIGN KEY (`IV_status`) REFERENCES `invoice_verification` (`IV_status`);

--
-- Constraints for table `purchase_order`
--
ALTER TABLE `purchase_order`
  ADD CONSTRAINT `purchase_order_ibfk_1` FOREIGN KEY (`suplier_id`) REFERENCES `suplier` (`suplier_id`);

--
-- Constraints for table `purchase_order_detail`
--
ALTER TABLE `purchase_order_detail`
  ADD CONSTRAINT `purchase_order_detail_ibfk_1` FOREIGN KEY (`Grdet_id`) REFERENCES `good_receipts_detail` (`Grdet_id`);

--
-- Constraints for table `requirement_details`
--
ALTER TABLE `requirement_details`
  ADD CONSTRAINT `requirement_details_ibfk_1` FOREIGN KEY (`Req_id`) REFERENCES `requirements` (`Req_id`),
  ADD CONSTRAINT `requirement_details_ibfk_2` FOREIGN KEY (`PODET_id`) REFERENCES `purchase_order_detail` (`PODET_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
