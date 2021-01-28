mysql -u 'root' --password=${_MYSQL_ROOT_PASSWORD} 'mysql' \
  -e "SET @DB_NAME = '${_CONFIG_DATABASE}'; \
   source SRCCode/App/SQLScripts/Management/dropDB.sql;"
mysql -u 'root' --password=${_MYSQL_ROOT_PASSWORD} 'mysql' \
  -e "source SRCCode/App/SQLScripts/Management/flushPrivileges.sql;"
