# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: localhost (MySQL 5.5.5-10.5.6-MariaDB)
# Database: KTlocal
# Generation Time: 2020-11-12 00:31:29 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


DROP TABLE IF EXISTS `animals_csv`;

CREATE TABLE `animals_csv` (
  `SampleID` text NOT NULL,
  `ClientID` text NOT NULL,
  `Species` enum('Fisher','Marten','Mink','Muskrat','Otter') NOT NULL,
  `loc_lbl` text NOT NULL,
  `Sex` enum('Male','Female','Unknown') DEFAULT NULL,
  `col_year` int(11) DEFAULT NULL,
  `col_month` int(11) DEFAULT NULL,
  `Hg` double DEFAULT NULL,
  `Li` double DEFAULT NULL,
  `V` double DEFAULT NULL,
  `Mn` double DEFAULT NULL,
  `Fe` double DEFAULT NULL,
  `Co` double DEFAULT NULL,
  `Ni` double DEFAULT NULL,
  `Cu` double DEFAULT NULL,
  `Zn` double DEFAULT NULL,
  `Ga` double DEFAULT NULL,
  `Arsenic` double DEFAULT NULL,
  `Se` double DEFAULT NULL,
  `Rb` double DEFAULT NULL,
  `Sr` double DEFAULT NULL,
  `Mo` double DEFAULT NULL,
  `Ag` double DEFAULT NULL,
  `Cd` double DEFAULT NULL,
  `Sn` double DEFAULT NULL,
  `Sb` double DEFAULT NULL,
  `Ba` double DEFAULT NULL,
  `Tl` double DEFAULT NULL,
  `Pb` double DEFAULT NULL,
  `Bi` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `compiled_mammals_csv`;

CREATE TABLE `compiled_mammals_csv` (
  `SampleID` text DEFAULT NULL,
  `ClientID` text DEFAULT NULL,
  `Species` text DEFAULT NULL,
  `Sex` text DEFAULT NULL,
  `Location` text DEFAULT NULL,
  `Latitude` double DEFAULT NULL,
  `Longitude` double DEFAULT NULL,
  `col_year` int(11) DEFAULT NULL,
  `col_month` int(11) DEFAULT NULL,
  `Hg` double DEFAULT NULL,
  `Li` double DEFAULT NULL,
  `V` double DEFAULT NULL,
  `Mn` double DEFAULT NULL,
  `Fe` double DEFAULT NULL,
  `Co` double DEFAULT NULL,
  `Ni` double DEFAULT NULL,
  `Cu` double DEFAULT NULL,
  `Zn` double DEFAULT NULL,
  `Ga` double DEFAULT NULL,
  `As` double DEFAULT NULL,
  `Se` double DEFAULT NULL,
  `Rb` double DEFAULT NULL,
  `Sr` double DEFAULT NULL,
  `Mo` double DEFAULT NULL,
  `Ag` double DEFAULT NULL,
  `Cd` double DEFAULT NULL,
  `Sn` double DEFAULT NULL,
  `Sb` double DEFAULT NULL,
  `Ba` double DEFAULT NULL,
  `Tl` double DEFAULT NULL,
  `Pb` double DEFAULT NULL,
  `Bi` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `Diseases_csv`;

CREATE TABLE `Diseases_csv` (
  `Number` int(11) NOT NULL,
  `ClientID` varchar(50) NOT NULL DEFAULT '',
  `Location` varchar(50) DEFAULT NULL,
  `Age` varchar(50) NOT NULL,
  `Sex` enum('M','F') DEFAULT NULL,
  `Kidney` enum('x','N/A') DEFAULT 'N/A',
  `Liver` enum('x','N/A') DEFAULT 'N/A',
  `Canine_parainfluenza_virus` enum('-','+') DEFAULT NULL,
  `Canine_adenovirus_2` enum('-','+') DEFAULT NULL,
  `Canine_herpesvirus_1` enum('-','+') DEFAULT NULL,
  `Diotophyme_renale` enum('-','+') DEFAULT NULL,
  `Canine_distemper_virus` enum('-','+','') DEFAULT NULL,
  `Leptospira` enum('-','+') DEFAULT NULL,
  `Toxoplasma` enum('-','+') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



DROP TABLE IF EXISTS `PAC_data_for_KT_Project_csv`;

CREATE TABLE `PAC_data_for_KT_Project_csv` (
  `COGRAD` varchar(50) DEFAULT NULL,
  `SampleID` varchar(50) DEFAULT NULL,
  `Species` text DEFAULT NULL,
  `Type` enum('Fish','Invertebrate','Otter') NOT NULL DEFAULT 'Fish',
  `Site` varchar(50) DEFAULT NULL,
  `Sex` enum('Unknown','Male','Female') DEFAULT 'Unknown',
  `Sum_Parent` float unsigned DEFAULT NULL,
  `Sum_ALK` float unsigned DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `Spatial_PACs_csv`;

CREATE TABLE `Spatial_PACs_csv` (
  `COGRAD` varchar(50) DEFAULT NULL,
  `SampleID` varchar(50) DEFAULT NULL,
  `Species` text DEFAULT NULL,
  `Area` varchar(50) NOT NULL,
  `Site` varchar(50) DEFAULT NULL,
  `Lat` float unsigned DEFAULT NULL,
  `Longitude` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `rodenticides_csv`;

CREATE TABLE `rodenticides_csv` (
  `loc_id` int(11) DEFAULT NULL,
  `Pop` int(11) DEFAULT NULL,
  `Exposed` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
