_MYSQL_USER='vagrant'
_MYSQL_HOST_IP='localhost'
_MYSQL_USER_PASSWORD=''
_MYSQL_ROOT_PASSWORD=''

# Simple text files that contain the username, hostname, password, privileges for users (one line per user/host combination):
_NEW_MYSQL_USER_INPUT_FILE='Vault/Servers/'$_CONFIG_HOST'/MySQLUsers/new_mysql_users.txt'
_ALTER_MYSQL_USER_INPUT_FILE='Vault/Servers/'$_CONFIG_HOST'/MySQLUsers/alter_mysql_users.txt'
_DELETE_MYSQL_USER_INPUT_FILE='Vault/Servers/'$_CONFIG_HOST'/MySQLUsers/delete_mysql_users.txt'
load_mysql_user_files
