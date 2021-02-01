#######################################################################################################################
# invoke this script with 1 argument (the arbitrary name of the configuration to use for this invocation)
# ./run.sh myselectedconfig
#######################################################################################################################
CONFIGURATION=$1
_CONFIG_FILE='runFiles/runlist_1.txt' # Default runlist used if no second argument is passed at invocation
echo $2; # Optional second argument at invocation can be the number of the alternate list , ie: 2
#######################################################################################################################
#######################################################################################################################
if [[ ${#2} > 0 ]]; then
  altfile='runFiles/runlist_'$2'.txt';
  echo $altfile;
  if [ -f "$altfile" ]; then
    _CONFIG_FILE=$altfile # The file that lists your configurations and will be used now for this run
  else
    echo 'No runlist with name runlist_'$2'.txt exists'
    exit
  fi
fi
#######################################################################################################################
source 'SRCCode/BASIC_SHELL_FUNCTIONS.sh'
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
source 'runFiles/App/'$_CONFIG_PROJECT_TYPE'.sh'
if [[ !($_CONFIG_PROJECT == 'App') ]]; then
  source 'runFiles/'$_CONFIG_PROJECT'/'$_CONFIG_PROJECT_TYPE'.sh'
fi
source 'SRCCode/'$_CONFIG_PROJECT'/Actions/'$_CONFIG_ACTION'.sh'
printf '\n'
exit
