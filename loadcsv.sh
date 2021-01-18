#######################################################################################################################
## loaddb.sh : This is the main control script
## invoke at command prompt in this directory by typing: ./loaddb.sh
#######################################################################################################################
# sudo launchctl limit maxfiles 10000 5000000
###
# NOTE: set /usr/local/etc/my.cnf:
# [server]
# local-infile=1
# open_files_limit = 9999
###
# brew services restart mariadb
### Check in mysql console:
# SHOW VARIABLES LIKE 'open_files_limit';
#######################################################################################################################
PW='rootpassword' # your db password
USER='root' # user to perform all db commands under, usually root
HOST='localhost'

#mysql -u $USER --password=$PW < init_users_and_databases.sql # Create Users (run inside vagrant box)
echo 'Now importing csv data into KTlocal database...'
mysql -u $USER -h $HOST --password=$PW KTlocal < create_mock_users_table.sql # Create a mock user table for csv demo loading in next step
mysqlimport --ignore-lines=1 --fields-terminated-by=, --verbose -u $USER -h $HOST --password=$PW KTlocal /vagrant/users.csv # Load the data from actual csv file
echo 'Finished csv import'