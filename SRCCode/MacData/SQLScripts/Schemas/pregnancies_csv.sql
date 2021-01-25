DROP TABLE IF EXISTS `pregnancies_csv`;
CREATE TABLE `pregnancies_csv` (
  `id` varchar(50) DEFAULT NULL,
  `pregnant` enum('n','y') DEFAULT NULL,
  `blastocyst` VARCHAR(11) DEFAULT NULL,
  `scar` VARCHAR(11) DEFAULT NULL,
  `fetus` VARCHAR(11) DEFAULT NULL,
  `implant` VARCHAR(11) DEFAULT NULL,
  `notes` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
