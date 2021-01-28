configure_mysql_server_for_csv_loading
load_csv_files "${APP_DATA_CSV_FILES[@]}"
configure_mysql_server_standard
load_app_procedure_files "${APP_CODE_SQL_PROCEDURE_FILES[@]}"



