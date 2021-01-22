parse_config_list() {
    OLDIFS=$IFS
    IFS=' '
    if [ -f "$_CONFIG_FILE" ]; then
      while read confname host hostconfigtype project projectconfigtype database action note
      do
        if [[ $1 == ${confname} ]]; then
          _CONFIG_NAME=${confname}
          _CONFIG_HOST=${host}
          _CONFIG_HOST_TYPE=${hostconfigtype}
          _CONFIG_PROJECT=${project}
          _CONFIG_PROJECT_TYPE=${projectconfigtype}
          _CONFIG_DATABASE=${database}
          _CONFIG_ACTION=${action}
          _CONFIG_NOTE=${note}
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

# Not used yet:
load_csv_file_into_existing_temporary_table() {
  tablename=$1;
  echo $tablename;
  mysqlimport --ignore-lines=1 --fields-terminated-by=, --verbose -u 'root' -h 'localhost' --password=$_MYSQL_ROOT_PASSWORD $_CONFIG_DATABASE $_SERVER_PROJECT_ROOT_DIR'/Data/'$_CONFIG_PROJECT'/CSV/'$tablename'.csv'
}


load_mysql_user_files() {
  OLDIFS=$IFS
  IFS=' '
  if [ -f "$_NEW_MYSQL_USER_INPUT_FILE" ]; then
  while read user host password grants
  do
    _NEW_MYSQL_USERS+=(${user})
    _NEW_MYSQL_USER_HOSTS+=(${host})
    _NEW_MYSQL_USER_PASSWORDS+=(${password})
    _NEW_MYSQL_USER_GRANTS+=("$grants")
  done < ${_NEW_MYSQL_USER_INPUT_FILE}
  fi

  if [ -f "$_ALTER_MYSQL_USER_INPUT_FILE" ]; then
  while read user host password grants
  do
    _ALTER_MYSQL_USERS+=(${user})
    _ALTER_MYSQL_USER_HOSTS+=(${host})
    _ALTER_MYSQL_USER_PASSWORDS+=(${password})
    _ALTER_MYSQL_USER_GRANTS+=("$grants")
  done < ${_ALTER_MYSQL_USER_INPUT_FILE}
  fi

  if [ -f "$_DELETE_MYSQL_USER_INPUT_FILE" ]; then
  while read user host
  do
    _DELETE_MYSQL_USERS+=(${user})
    _DELETE_MYSQL_USER_HOSTS+=(${host})
  done < ${_DELETE_MYSQL_USER_INPUT_FILE}
  fi
  IFS=$OLDIFS
}


