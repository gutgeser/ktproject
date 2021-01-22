######################################################################################################
# ABSDIR_CONFIG="$( cd "$( dirname "$0" )" && pwd )"
######################################################################################################
######################################################################################################
for i in ${!_ALTER_MYSQL_USERS[@]}; do
  ERROR_MESSAGE=$(mysql -u root --password=${_MYSQL_ROOT_PASSWORD} 'mysql' \
  -e "SET @ALTER_MYSQL_USER = '${_ALTER_MYSQL_USERS[${i}]}'; SET @ALTER_MYSQL_USER_PASSWORD = '${_ALTER_MYSQL_USER_PASSWORDS[${i}]}'; \
  SET @ALTER_MYSQL_USER_HOST = '${_ALTER_MYSQL_USER_HOSTS[${i}]}'; \
  source SRCCode/App/SQLScripts/Management/Users/update_user_password_on_host.sql;" 2>&1)
  if [ ${#ERROR_MESSAGE} -ge 1 ]; then
   echo ${ERROR_MESSAGE};
  else
   echo 'Updated User Password: '${_ALTER_MYSQL_USERS[${i}]}'  Host: '${_ALTER_MYSQL_USER_HOSTS[${i}]}' Password: '${_ALTER_MYSQL_USER_PASSWORDS[${i}]}
  fi
done
