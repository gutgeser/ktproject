######################################################################################################
# ABSDIR_CONFIG="$( cd "$( dirname "$0" )" && pwd )"
######################################################################################################
######################################################################################################
for i in ${!_ALTER_MYSQL_USER_GRANTS_USER[@]}; do
ERROR_MESSAGE=$(mysql -u root --password=${_MYSQL_ROOT_PASSWORD} ${_CONFIG_DATABASE} \
  -e "SET @ALTER_MYSQL_USER = '${_ALTER_MYSQL_USER_GRANTS_USER[${i}]}'; SET @ALTER_MYSQL_USER_HOST = '${_ALTER_MYSQL_USER_GRANTS_HOST[${i}]}'; \
   SET @DB_NAME = '${_CONFIG_DATABASE}'; \
   source SRCCode/App/SQLScripts/Management/Users/revoke_user_db_all_privileges_on_host.sql;" 2>&1)
   if [ ${#ERROR_MESSAGE} -ge 1 ]; then
     echo ${ERROR_MESSAGE};
   else
     echo 'Revoked All Users Privileges: '${_ALTER_MYSQL_USER_GRANTS_USER[${i}]}'  Host: '${_ALTER_MYSQL_USER_GRANTS_HOST[${i}]} 'on DB: '${_CONFIG_DATABASE}
   fi
done
