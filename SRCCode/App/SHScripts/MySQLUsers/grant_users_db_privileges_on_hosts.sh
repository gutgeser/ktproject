######################################################################################################
# ABSDIR_CONFIG="$( cd "$( dirname "$0" )" && pwd )"
######################################################################################################
######################################################################################################
for i in ${!_ALTER_MYSQL_USERS[@]}; do
ERROR_MESSAGE=$(mysql -u root --password=${_MYSQL_ROOT_PASSWORD} ${_CONFIG_DATABASE} \
  -e "SET @ALTER_MYSQL_USER = '${_ALTER_MYSQL_USERS[${i}]}'; SET @ALTER_MYSQL_USER_GRANTS = '${_ALTER_MYSQL_USER_GRANTS[${i}]}'; SET @ALTER_MYSQL_USER_HOST = '${_ALTER_MYSQL_USER_HOSTS[${i}]}'; \
   SET @DB_NAME = '${_CONFIG_DATABASE}'; \
   source SRCCode/App/SQLScripts/Management/Users/grant_user_db_privileges_on_host.sql;" 2>&1)
  if [ ${#ERROR_MESSAGE} -ge 1 ]; then
    echo ${ERROR_MESSAGE};
  else
    echo 'Grant User Privileges: '${_ALTER_MYSQL_USERS[${i}]}'  Host: '${_ALTER_MYSQL_USER_HOSTS[${i}]}' Grants: '${_ALTER_MYSQL_USER_GRANTS[${i}]}' on DB: '${_CONFIG_DATABASE}
  fi
done
