# This is an alternative to mysqlimport. Needs to run as root (mysql) user.
# Easier for one-off imports or checking for different field terminations etc.
# Everything is hard coded here.
# You must call the shell function 'configure_mysql_server_for_csv_loading' immediately prior to this
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE KTlocal.test_me_csv;
LOAD DATA LOCAL INFILE '/vagrant/consoleapps/ktproject/Data/App/CSV/test_me_csv.csv' INTO TABLE KTlocal.test_me_csv
#CHARACTER SET latin1
FIELDS TERMINATED BY ','
#ENCLOSED BY '"'
#LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;
#(type, question, created_at, updated_at);
SELECT * FROM KTlocal.test_me_csv;
SET FOREIGN_KEY_CHECKS = 1;
