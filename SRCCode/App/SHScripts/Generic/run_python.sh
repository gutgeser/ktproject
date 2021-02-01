SOURCE="${BASH_SOURCE[0]}"
extract_local_context $SOURCE

file=$_SERVER_PROJECT_ROOT_DIR'/SRCCode/'$localcontextname'/PYScripts/'$_CONFIG_ACTIONPARAM
if [[ -f $file ]]; then
  python3 'SRCCode/'$localcontextname'/PYScripts/'$_CONFIG_ACTIONPARAM $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE
else
  echo 'No script at '$_SERVER_PROJECT_ROOT_DIR'/SRCCode/'$localcontextname'/PYScripts/'$_CONFIG_ACTIONPARAM' found'
fi
# RUN the testme.py script, output to a new file (if exists, will be overwritten):
# python3 'SRCCode/'$localcontextname'/PYScripts/testme.py' $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE > 'Output/'$localcontextname'/my_python_single_run_results.txt'

# RUN the testme.py script, append output to an exsiting file (will be created if does not exist yet):
# python3 'SRCCode/'$localcontextname'/PYScripts/testme.py' $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE >> 'Output/'$localcontextname'/my_python_appended_run_results.txt'
