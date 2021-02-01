load_app_schema_files "${APP_CODE_SQL_SCHEMA_FILES[@]}"
load_app_procedure_files "${APP_CODE_SQL_PROCEDURE_FILES[@]}"
load_app_data_sql_files "${APP_DATA_SQL_FILES[@]}"
call_app_management_sql_script 'callProcs.sql'
#call_app_management_sql_script 'postLoad.sql'
