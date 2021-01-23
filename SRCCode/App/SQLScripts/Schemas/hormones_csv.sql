DROP TABLE IF EXISTS `hormones_csv`;
CREATE TABLE `hormones_csv` (
  `Sample ID` varchar(50) DEFAULT NULL,
  `RFMA` varchar(50) DEFAULT NULL,
  `Sex` enum('F','M') DEFAULT NULL,
  `Cort (ng/g feces)` double DEFAULT NULL,
  `Test (ng/g feces)` double DEFAULT NULL,
  `Estradiol (ng/g feces)` double DEFAULT NULL,
  `Prog (ng/g feces)` double DEFAULT NULL,
  `T3 (ng/g feces)` double DEFAULT NULL,
  `notes` VARCHAR(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
