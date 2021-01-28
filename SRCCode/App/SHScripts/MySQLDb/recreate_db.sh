mysql -u ${_MYSQL_USER} --password=${_MYSQL_USER_PASSWORD} ${_CONFIG_DATABASE} \
  -e "SET @DB_NAME = '${_CONFIG_DATABASE}'; \
   source SRCCode/App/SQLScripts/Management/DB/createDB.sql;"
