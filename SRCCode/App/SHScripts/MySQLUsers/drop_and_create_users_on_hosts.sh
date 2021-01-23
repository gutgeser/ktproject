######################################################################################################
# ABSDIR_CONFIG="$( cd "$( dirname "$0" )" && pwd )"
######################################################################################################
for i in ${!_NEW_MYSQL_USERS[@]}; do
  ERROR_MESSAGE=$(mysql -u root --password=${_MYSQL_ROOT_PASSWORD} 'mysql' \
  -e "SET @NEW_MYSQL_USER = '${_NEW_MYSQL_USERS[${i}]}'; \
  SET @NEW_MYSQL_USER_PASSWORD = '${_NEW_MYSQL_USER_PASSWORDS[${i}]}'; \
  SET @NEW_MYSQL_USER_HOST = '${_NEW_MYSQL_USER_HOSTS[${i}]}'; \
  source SRCCode/App/SQLScripts/Management/Users/drop_and_create_user_on_host.sql;" 2>&1)
  if [ ${#ERROR_MESSAGE} -ge 1 ]; then
     echo ${ERROR_MESSAGE};
  else
    echo 'Created User: '${_NEW_MYSQL_USERS[${i}]}'  Host: '${_NEW_MYSQL_USER_HOSTS[${i}]}' Password: '${_NEW_MYSQL_USER_PASSWORDS[${i}]}
  fi
done
