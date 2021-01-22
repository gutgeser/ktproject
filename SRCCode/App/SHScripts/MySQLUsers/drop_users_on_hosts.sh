######################################################################################################
# ABSDIR_CONFIG="$( cd "$( dirname "$0" )" && pwd )"
######################################################################################################
######################################################################################################
for i in ${!_DELETE_MYSQL_USERS[@]}; do
  ERROR_MESSAGE=$(mysql -u root --password=${_MYSQL_ROOT_PASSWORD} 'mysql' \
  -e "SET @ALTER_MYSQL_USER = '${_DELETE_MYSQL_USERS[${i}]}'; \
  SET @ALTER_MYSQL_USER_HOST = '${_DELETE_MYSQL_USER_HOSTS[${i}]}'; \
  source SRCCode/App/SQLScripts/Management/Users/drop_user_on_host.sql;" 2>&1)
  if [ ${#ERROR_MESSAGE} -ge 1 ]; then
     echo ${ERROR_MESSAGE};
  else
  echo 'Dropped User: '${_DELETE_MYSQL_USERS[${i}]}'  Host: '${_DELETE_MYSQL_USER_HOSTS[${i}]}
  fi
done
