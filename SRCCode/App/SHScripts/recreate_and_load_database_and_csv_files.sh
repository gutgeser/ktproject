source 'SRCCode/App/SHScripts/recreate_db.sh'
source 'SRCCode/App/SHScripts/load_csv_files.sh'
source 'SRCCode/App/SHScripts/load_database.sh'
call_app_management_sql_script 'callUpdateProcs.sql'