source 'SRCCode/App/SHScripts/recreate_db.sh'
source 'SRCCode/App/SHScripts/load_database.sh'

load_project_schema_files "${PROJECT_CODE_SQL_SCHEMA_FILES[@]}"

configure_mysql_server_for_csv_loading
load_csv_files "${PROJECT_DATA_CSV_FILES[@]}"
configure_mysql_server_standard

load_project_procedure_files "${PROJECT_CODE_SQL_PROCEDURE_FILES[@]}"
call_project_management_sql_script 'callProcs.sql'
call_project_management_sql_script 'postLoad.sql'
