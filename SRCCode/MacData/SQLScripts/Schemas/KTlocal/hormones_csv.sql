DROP TABLE IF EXISTS `hormones_csv`;
CREATE TABLE `hormones_csv` (
  `sample` varchar(50) DEFAULT NULL,
  `RFMA` varchar(50) DEFAULT NULL,
  `Sex` enum('F','M') DEFAULT NULL,
  `Cort` double DEFAULT NULL,
  `Test` double DEFAULT NULL,
  `Estradiol` double DEFAULT NULL,
  `Prog` double DEFAULT NULL,
  `T3` double DEFAULT NULL,
  `notes` VARCHAR(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
