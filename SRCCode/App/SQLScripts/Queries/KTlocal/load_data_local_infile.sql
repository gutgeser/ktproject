###############################################################################################
# This is an alternative to mysqlimport. Needs to run as root (mysql) user.
# Easier for one-off imports or checking for different field terminations etc.
# Everything is hard coded here.
# You must call the shell function 'configure_mysql_server_for_csv_loading' immediately prior to this
###############################################################################################
SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `pacs_update_csv`;
CREATE TABLE `pacs_update_csv` (
  `Sample` varchar(50) DEFAULT NULL,
  `Parent` double DEFAULT NULL,
  `Alk` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

TRUNCATE KTlocal.pacs_update_csv;
LOAD DATA LOCAL INFILE '/vagrant/consoleapps/ktproject/Data/App/CSV/pacs_update_csv.csv' INTO TABLE KTlocal.pacs_update_csv
CHARACTER SET latin1
FIELDS TERMINATED BY ','
#ENCLOSED BY '"'
#LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

###############################################################################################
# PREPARED STATEMENT VERSION IS NOT SUPPORTED YET UNFORTUNATELY !!!
#
# SET @FILEPATH = '/vagrant/consoleapps/ktproject/Data/App/CSV/pacs_update_csv.csv';
# SET @DATABASETABLE = 'KTlocal.pacs_update_csv';
#
# SET @TRUNC = CONCAT
# (
#     ' TRUNCATE ',@DATABASETABLE
# );
# PREPARE TRUNC_STMT FROM @TRUNC;
# EXECUTE TRUNC_STMT;
# DEALLOCATE PREPARE TRUNC_STMT;
#
# SET @LOAD_DATA = CONCAT
# (
#     ' LOAD DATA LOCAL INFILE "',@FILEPATH,'" INTO TABLE ',@DATABASETABLE,
#     ' CHARACTER SET latin1 '
#     ' FIELDS TERMINATED BY "','" '
#     ' IGNORE 1 LINES '
# );
# PREPARE LOAD_DATA_STMT FROM @LOAD_DATA;
# EXECUTE LOAD_DATA_STMT;
# DEALLOCATE PREPARE LOAD_DATA_STMT;
###############################################################################################
SET FOREIGN_KEY_CHECKS = 1;
