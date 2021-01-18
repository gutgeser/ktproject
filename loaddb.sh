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

#mysql -u $USER --password=$PW < init_users_and_databases.sql # Create Users (run inside vagrant box)
echo 'Now reloading $DATABASE database...'
mysql -u $USER -h $HOST --password=$PW $DATABASE < $INITFILE # Create KTlocal database
mysql -u $USER -h $HOST --password=$PW $DATABASE < KTlocal_structure.sql # Load the permanent structure
mysql -u $USER -h $HOST --password=$PW $DATABASE < $DATAFILE_1 # Load the permanent data (reference values etc.)
mysql -u $USER -h $HOST --password=$PW $DATABASE < KTlocal_2020-11-11_structure.sql # Load the structure of the temporary tables that correspond to the csv data files
mysql -u $USER -h $HOST --password=$PW $DATABASE < $DATAFILE_2 # Load the data from the csv files that are already in the database (NOTE: the data here is in proper SQL insert form)
mysql -u $USER -h $HOST --password=$PW $DATABASE < locations_procedure.sql # Loads additional locations from spatial PACs procedure into the database
mysql -u $USER -h $HOST --password=$PW $DATABASE < rodenticides_procedure.sql # Loads the rodenticides procedure into the database
mysql -u $USER -h $HOST --password=$PW $DATABASE < samples_procedure.sql # loads samples procedure
mysql -u $USER -h $HOST --password=$PW $DATABASE < metals_procedure.sql # loads metals procedure
mysql -u $USER -h $HOST --password=$PW $DATABASE < PACs_procedure.sql # loads PACs procedure
mysql -u $USER -h $HOST --password=$PW $DATABASE < Diseases_procedure.sql # loads Diseases procedure
mysql -u $USER -h $HOST --password=$PW $DATABASE < all_functions.sql # loads functions file
mysql -u $USER -h $HOST --password=$PW $DATABASE < master_queries.sql # loads queries procedure
mysql -u $USER -h $HOST --password=$PW $DATABASE < run_KTlocal.sql #  Calls the procedures to transfer the data from the temporary csv tables to the permanent tables with validation/transformations as necessary)
mysql -u $USER -h $HOST --password=$PW $DATABASE < cleanup_KTlocal.sql # Removes the temporary tables that hold the csv data
echo 'Finished.'