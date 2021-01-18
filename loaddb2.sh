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
SERVERSELECTION=$1
PROJECTSELECTION=$2
source Vault/Passwords.sh
source Data/file_selector.sh
echo $SERVERSELECTION
echo '   '
echo $PROJECTSELECTION
echo $USER
echo $HOST
echo $INITFILE

#mysql -u $USER --password=$PW < init_users_and_databases.sql # Create Users (run inside vagrant box)
echo 'Now reloading '$DATABASE' database...'
mysql -u $USER -h $HOST --password=$PW < $INITFILE # Create KTlocal database
#mysql -u $USER -h $HOST --password=$PW $DATABASE < $STRUCTUREFILE_3 # Create KTlocal database
#mysqlimport --ignore-lines=1 --fields-terminated-by=, --verbose -u $USER -h $HOST --password=$PW $DATABASE /vagrant/Data/CSV_data/pregnancies_csv.csv # Load the data from actual csv file
echo 'Finished.'