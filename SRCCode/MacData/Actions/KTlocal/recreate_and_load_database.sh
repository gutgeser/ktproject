source 'SRCCode/App/SHScripts/MySQLDb/recreate_db.sh'
load_app_schema_files "${APP_CODE_SQL_SCHEMA_FILES[@]}"
load_app_procedure_files "${APP_CODE_SQL_PROCEDURE_FILES[@]}"
load_app_data_sql_files "${APP_DATA_SQL_FILES[@]}"
call_app_query_sql_script 'KTlocal/callProcs.sql'
call_app_query_sql_script 'KTlocal/postLoad.sql'

load_project_schema_files "${PROJECT_CODE_SQL_SCHEMA_FILES[@]}"
load_project_procedure_files "${PROJECT_CODE_SQL_PROCEDURE_FILES[@]}"
