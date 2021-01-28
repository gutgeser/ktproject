SET FOREIGN_KEY_CHECKS=0;

# Subsequent tables are MacDATA specific

DROP TABLE IF EXISTS `pregnancies`;

CREATE TABLE `pregnancies` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(11) unsigned NOT NULL,
  `pregnant` enum('y','n','N/A') DEFAULT 'N/A',
  `blastocyst` int(11) DEFAULT NULL,
  `scar` int(11) DEFAULT NULL,
  `fetus` int(11) DEFAULT NULL,
  `implant` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
              constraint UNIQ_10
                        unique (id),
  constraint FK_10
                foreign key (sample_id) references  samples (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `fecal_hormones`;

CREATE TABLE `fecal_hormones` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(11) unsigned NOT NULL,
  `Cortisol` double DEFAULT NULL, #all measurements are ng/g feces
  `Testosterone` double DEFAULT NULL,
  `Estradiol` double DEFAULT NULL,
  `Progesterone` double DEFAULT NULL,
  `T3` double DEFAULT NULL,
  PRIMARY KEY (`id`),
              constraint UNIQ_11
                        unique (id),
  constraint FK_11
                foreign key (sample_id) references  samples (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


SET FOREIGN_KEY_CHECKS=1;