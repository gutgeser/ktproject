parse_config_list() {
    OLDIFS=$IFS
    IFS=' '
    if [ -f "$_CONFIG_FILE" ]; then
      while read -r confname host hostconfigtype project projectconfigtype database action note
      do
        if [[ $1 == ${confname} ]]; then
          _CONFIG_NAME="${confname}"
          _CONFIG_HOST="${host}"
          _CONFIG_HOST_TYPE="${hostconfigtype}"
          _CONFIG_PROJECT="${project}"
          _CONFIG_PROJECT_TYPE="${projectconfigtype}"
          _CONFIG_DATABASE="${database}"
          _CONFIG_ACTION="${action}"
          _CONFIG_NOTE="${note}"
        fi
      done < ${_CONFIG_FILE}
    fi
    IFS=$OLDIFS
}

load_app_schema_files() {
  arr=("$@")
  for i in "${arr[@]}"; do
    echo ${i}
    mysql -u $_MYSQL_USER -h $_MYSQL_HOST_IP --password=$_MYSQL_USER_PASSWORD $_CONFIG_DATABASE < 'SRCCode/App/SQLScripts/Schemas/'${i}
  done
}

load_app_procedure_files() {
  arr=("$@")
  for i in "${arr[@]}"; do
    echo ${i}
    mysql -u $_MYSQL_USER -h $_MYSQL_HOST_IP --password=$_MYSQL_USER_PASSWORD $_CONFIG_DATABASE < 'SRCCode/App/SQLScripts/Procedures/'${i}
  done
}

load_app_data_sql_files() {
  arr=("$@")
  for i in "${arr[@]}"; do
    echo ${i}
    mysql -u $_MYSQL_USER -h $_MYSQL_HOST_IP --password=$_MYSQL_USER_PASSWORD $_CONFIG_DATABASE < 'Data/App/SQL/'${i}
  done
}

call_app_management_sql_script() {
  mysql -u $_MYSQL_USER -h $_MYSQL_HOST_IP --password=$_MYSQL_USER_PASSWORD $_CONFIG_DATABASE < 'SRCCode/App/SQLScripts/Management/'${1}
}

call_app_query_sql_script() {
  mysql -u $_MYSQL_USER -h $_MYSQL_HOST_IP --password=$_MYSQL_USER_PASSWORD $_CONFIG_DATABASE < 'SRCCode/App/SQLScripts/Queries/'${1}
}



load_project_schema_files() {
  arr=("$@")
  for i in "${arr[@]}"; do
    echo ${i}
    mysql -u $_MYSQL_USER -h $_MYSQL_HOST_IP --password=$_MYSQL_USER_PASSWORD $_CONFIG_DATABASE < 'SRCCode/'$_CONFIG_PROJECT'/SQLScripts/Schemas/'${i}
  done
}

load_project_procedure_files() {
  arr=("$@")
  for i in "${arr[@]}"; do
    echo ${i}
    mysql -u $_MYSQL_USER -h $_MYSQL_HOST_IP --password=$_MYSQL_USER_PASSWORD $_CONFIG_DATABASE < 'SRCCode/'$_CONFIG_PROJECT'/SQLScripts/Procedures/'${i}
  done
}

load_project_data_sql_files() {
  arr=("$@")
  for i in "${arr[@]}"; do
    echo ${i}
    mysql -u $_MYSQL_USER -h $_MYSQL_HOST_IP --password=$_MYSQL_USER_PASSWORD $_CONFIG_DATABASE < 'Data/'$_CONFIG_PROJECT'/SQL/'${i}
  done
}

call_project_management_sql_script() {
  mysql -u $_MYSQL_USER -h $_MYSQL_HOST_IP --password=$_MYSQL_USER_PASSWORD $_CONFIG_DATABASE < 'SRCCode/'$_CONFIG_PROJECT'/SQLScripts/Management/'${1}
}

call_project_query_sql_script() {
  mysql -u $_MYSQL_USER -h $_MYSQL_HOST_IP --password=$_MYSQL_USER_PASSWORD $_CONFIG_DATABASE < 'SRCCode/'$_CONFIG_PROJECT'/SQLScripts/Queries/'${1}
}


configure_mysql_server_for_csv_loading() {
  sudo cp 'Vault/Servers/'$_CONFIG_HOST'/SERVERCONFIG_CSV/etc/my.cnf.d/mariadb-server.cnf' '/etc/my.cnf.d'
  sudo service mariadb stop
  sudo service mariadb start
}

configure_mysql_server_standard() {
  sudo cp 'Vault/Servers/'$_CONFIG_HOST'/SERVERCONFIG_STANDARD/etc/my.cnf.d/mariadb-server.cnf' '/etc/my.cnf.d'
  sudo service mariadb stop
  sudo service mariadb start
}

load_csv_files() {
  arr=("$@")
  for i in "${arr[@]}"; do
    tablename=$(echo "$i" | cut -f 1 -d '.')
    load_csv_file_into_new_temporary_table ${tablename}
  done
}

load_csv_file_into_new_temporary_table() {
  tablename=$1;
  echo $tablename;
  mysql -u 'root' -h 'localhost' --password=$_MYSQL_ROOT_PASSWORD $_CONFIG_DATABASE < 'SRCCode/'$_CONFIG_PROJECT'/SQLScripts/Schemas/'$tablename'.sql'
  mysqlimport --ignore-lines=1 --fields-terminated-by=, --verbose -u 'root' -h 'localhost' --password=$_MYSQL_ROOT_PASSWORD $_CONFIG_DATABASE $_SERVER_PROJECT_ROOT_DIR'/Data/'$_CONFIG_PROJECT'/CSV/'$tablename'.csv'
}


load_csv_file_into_existing_temporary_table() {
  tablename=$1;
  echo $tablename;
  mysqlimport --ignore-lines=1 --fields-terminated-by=, --verbose -u 'root' -h 'localhost' --password=$_MYSQL_ROOT_PASSWORD $_CONFIG_DATABASE $_SERVER_PROJECT_ROOT_DIR'/Data/'$_CONFIG_PROJECT'/CSV/'$tablename'.csv'
}


dump_table_data_to_csv_file() {
  tablename=$1;
  echo $tablename;
  sudo mysqldump -u 'root' -h 'localhost' --password=$_MYSQL_ROOT_PASSWORD -t -T'/'$_SERVER_PROJECT_ROOT_DIR'/Output/DATADUMPS' $_CONFIG_DATABASE $tablename --fields-terminated-by=,
}

dump_database_schema_to_sql_file() {
  sudo mysqldump -u 'root' -h 'localhost' --password=$_MYSQL_ROOT_PASSWORD --no-data $_CONFIG_DATABASE > $_SERVER_PROJECT_ROOT_DIR'/Output/DATADUMPS/'$_CONFIG_DATABASE'_schema.sql'
}

dump_table_data_to_tab_file(){
  tablename=$1;
  ERROR_MESSAGE=$(mysql -u ${_MYSQL_USER} --password=${_MYSQL_USER_PASSWORD} ${_CONFIG_DATABASE} \
  -e "SET @TABLENAME = '${tablename}'; \
  source SRCCode/App/SQLScripts/Queries/select_all_data_from_table.sql;" 2>&1 > $_SERVER_PROJECT_ROOT_DIR'/Output/DATADUMPS/'${tablename}'_data.txt')
  if [ ${#ERROR_MESSAGE} -ge 1 ]; then
   echo ${ERROR_MESSAGE};
  else
   echo 'Downloaded Table Data for: '${tablename}' to Output/DATADUMPS'
  fi
}


load_mysql_user_files() {
  OLDIFS=$IFS
  IFS=' '
  if [ -f "$_NEW_MYSQL_USER_INPUT_FILE" ]; then
  while read -r user host password grants
  do
    if [[ ${#user} > 0 ]]; then
      _NEW_MYSQL_USERS+=("${user}")
      _NEW_MYSQL_USER_HOSTS+=("${host}")
      _NEW_MYSQL_USER_PASSWORDS+=("${password}")
      _NEW_MYSQL_USER_GRANTS+=("$grants")
    fi
  done < "${_NEW_MYSQL_USER_INPUT_FILE}"
  fi

  if [ -f "$_ALTER_MYSQL_USER_INPUT_FILE" ]; then
  while read -r user host password grants
  do
    if [[ ${#user} > 0 ]]; then
      _ALTER_MYSQL_USERS+=("${user}")
      _ALTER_MYSQL_USER_HOSTS+=("${host}")
      _ALTER_MYSQL_USER_PASSWORDS+=("${password}")
      _ALTER_MYSQL_USER_GRANTS+=("$grants")
    fi
  done < ${_ALTER_MYSQL_USER_INPUT_FILE}
  fi

  if [ -f "$_DELETE_MYSQL_USER_INPUT_FILE" ]; then
  while read -r user host
  do
    if [[ ${#user} > 0 ]]; then
      _DELETE_MYSQL_USERS+=("${user}")
      _DELETE_MYSQL_USER_HOSTS+=("${host}")
    fi
  done < ${_DELETE_MYSQL_USER_INPUT_FILE}
  fi
  IFS=$OLDIFS
}


