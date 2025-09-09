-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 08, 2020 at 08:07 PM
-- Server version: 10.1.41-MariaDB-0+deb9u1
-- PHP Version: 7.2.27-1+0~20200123.34+debian9~1.gbp63c0bc

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ges_film`
--

-- --------------------------------------------------------

--
-- Table structure for table `AUDIT_TABLE`
--

CREATE TABLE IF NOT EXISTS `AUDIT_TABLE` (
  `LOG_ID` bigint(20) NOT NULL COMMENT 'Clé primaire auto increment',
  `LOG_DATE` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `ACTION` varchar(50) NOT NULL COMMENT 'Aura les valeurs UPDATE, CREATE ou DELETE',
  `TABLE_NAME` varchar(50) NOT NULL COMMENT 'Nom de la table concernée par l''audit',
  `TEMPS_ID` int(4) DEFAULT NULL,
  `MODELE_ID` int(4) DEFAULT NULL,
  `CON_ID` int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='Table d''audit';

--
-- Indexes for dumped tables
--

--
-- Indexes for table `AUDIT_TABLE`
--
ALTER TABLE `AUDIT_TABLE`
  ADD PRIMARY KEY (`LOG_ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `AUDIT_TABLE`
--
ALTER TABLE `AUDIT_TABLE`
  MODIFY `LOG_ID` bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'Clé primaire auto increment';
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
