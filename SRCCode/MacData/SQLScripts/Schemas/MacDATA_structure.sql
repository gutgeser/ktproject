SET FOREIGN_KEY_CHECKS=0;
DROP TABLE IF EXISTS `zzztest`;

CREATE TABLE `zzztest` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `valueone` varchar(256) DEFAULT NULL,
  `valuetwo` varchar(256) DEFAULT NULL,
  `valuethree` varchar(256) DEFAULT NULL,
  `valuefour` varchar(256) DEFAULT NULL,
    PRIMARY KEY (`id`),
            constraint UNIQ_1
                      unique (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
                             `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
                             `lbl` varchar(128) NOT NULL,
                             `lat` double DEFAULT NULL,
                             `lng` double DEFAULT NULL,
                             PRIMARY KEY (`id`),
                             constraint UNIQ_5
                                 unique (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `samples`;

CREATE TABLE `samples` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` varchar(54) DEFAULT NULL,
  `client_id` varchar(54) DEFAULT NULL,
  `species` enum('Fisher','Marten','Mink','Muskrat','Otter','Walleye','Snails','Lake Whitefish','Pike','River Otter') DEFAULT NULL,
  `sex` enum('Male','Female','Unknown') DEFAULT NULL,
  `loc_id` int(11) unsigned NOT NULL,
  `col_year` int(11) DEFAULT NULL,
  `col_month` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  constraint UNIQ_2
          unique (id),
      constraint FK_100
              foreign key (loc_id) references  locations (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `metals`;

CREATE TABLE `metals` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(11) unsigned DEFAULT NULL,
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
  `Bi` double DEFAULT NULL,
  PRIMARY KEY (`id`),
  constraint UNIQ_3
            unique (id),
  constraint FK_1
            foreign key (sample_id) references  samples (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



DROP TABLE IF EXISTS `diseases`;

CREATE TABLE `diseases` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(11) unsigned NOT NULL,
  `Kidney` enum('x','N/A') DEFAULT 'N/A',
  `Liver` enum('x','N/A') DEFAULT 'N/A',
  `Canine_parainfluenza_virus` enum('-','+') DEFAULT NULL,
  `Canine_adenovirus_2` enum('-','+') DEFAULT NULL,
  `Canine_herpesvirus_1` enum('-','+') DEFAULT NULL,
  `Diotophyme_renale` enum('-','+') DEFAULT NULL,
  `Canine_distemper_virus` enum('-','+','') DEFAULT NULL,
  `Leptospira` enum('-','+') DEFAULT NULL,
  `Toxoplasma` enum('-','+') DEFAULT NULL,
  PRIMARY KEY (`id`),
    constraint UNIQ_4
              unique (id),
    constraint FK_2
              foreign key (sample_id) references  samples (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;



DROP TABLE IF EXISTS `MDLs`;

CREATE TABLE `MDLs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Analyte` text DEFAULT NULL,
  `MDL` float NOT NULL,
  PRIMARY KEY (`id`),
        constraint UNIQ_6
                  unique (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `PACs`;

CREATE TABLE `PACs` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(11) unsigned NOT NULL,
  `sum_parent` float DEFAULT NULL,
  `sum_alk` float DEFAULT NULL,
  `sum_HPAC` float DEFAULT NULL,
  PRIMARY KEY (`id`),
    constraint UNIQ_7
                    unique (id),
    constraint FK_3
                foreign key (sample_id) references  samples (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `reference_values`;

CREATE TABLE `reference_values` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `Analyte` varchar(50) DEFAULT NULL,
  `Marten` float DEFAULT NULL,
  `Mink` float DEFAULT NULL,
  `Fischer` float DEFAULT NULL,
  `Muskrat` float DEFAULT NULL,
  `Otter` float DEFAULT NULL,
  PRIMARY KEY (`id`),
            constraint UNIQ_8
                      unique (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS `rodenticides`;

CREATE TABLE `rodenticides` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `location_id` int(11) unsigned DEFAULT NULL,
  `Location_label` varchar(100) DEFAULT NULL,
  `Pop` int(11) DEFAULT NULL,
  `Exposed` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
              constraint UNIQ_9
                        unique (id),
  constraint FK_4
                foreign key (location_id) references  locations (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

# Subsequent tables are MacDATA specific

DROP TABLE IF EXISTS `pregnancies`;

CREATE TABLE `pregnancies` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pregnant` enum('y','n','N/A') DEFAULT 'N/A',
  `blastocyst` int(11) DEFAULT NULL,
  `scar` int(11) DEFAULT NULL,
  `fetus` int(11) DEFAULT NULL,
  `implant` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
              constraint UNIQ_9
                        unique (id),
  constraint FK_4
                foreign key (location_id) references  locations (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


DROP TABLE IF EXISTS 'fecal_hormones';

CREATE TABLE `fecal_hormones` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `cortisol` double DEFAULT NULL, #all measurements are ng/g feces
  `testosterone` double DEFAULT NULL,
  `estradiol` double DEFAULT NULL,
  `progesterone` double DEFAULT NULL,
  `T3` int(11) double DEFAULT NULL,
  PRIMARY KEY (`id`),
              constraint UNIQ_9
                        unique (id),
  constraint FK_4
                foreign key (location_id) references  locations (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


SET FOREIGN_KEY_CHECKS=1;