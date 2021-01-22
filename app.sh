#######################################################################################################################
# invoke this script with 1 argument (the arbitrary name of the configuration to use for this invocation)
# ./app.sh myselectedconfig
#######################################################################################################################
CONFIGURATION=$1
_CONFIG_FILE=('Config/ConfigList1.txt') # The file that lists your configurations and will be used now for this run
#######################################################################################################################
source 'SRCCode/App/SHScripts/configfuncs.sh'
parse_config_list ${CONFIGURATION}
_SERVER_PROJECT_ROOT_DIR=$(pwd)
#######################################################################################################################
printf '\n'
printf 'Invoking: [ '$_CONFIG_ACTION' ] for Project: [ '$_CONFIG_PROJECT'('$_CONFIG_PROJECT_TYPE') ] and Database: [ '$_CONFIG_DATABASE' ] on Host: [ '$_CONFIG_HOST'('$_CONFIG_HOST_TYPE') ]'
printf '\n'
printf 'NOTE: [ '$_CONFIG_NOTE' ]'
printf '\n'
source 'Vault/Servers/'$_CONFIG_HOST'/'$_CONFIG_HOST_TYPE'.sh'
printf 'Connecting to Host: [ '$_MYSQL_HOST_IP' ] as User: [ '$_MYSQL_USER' ] with Password: [ '$_MYSQL_USER_PASSWORD' ]'
printf '\n'
#######################################################################################################################
source 'Config/App/'$_CONFIG_PROJECT_TYPE'.sh'
if [[ !($_CONFIG_PROJECT == 'App') ]]; then
  source 'Config/'$_CONFIG_PROJECT'/'$_CONFIG_PROJECT_TYPE'.sh'
fi
source 'SRCCode/'$_CONFIG_PROJECT'/SHScripts/'$_CONFIG_ACTION'.sh'
printf '\n'
exit
