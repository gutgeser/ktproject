file=$_SERVER_PROJECT_ROOT_DIR'/SRCCode/App/PYScripts/'$_CONFIG_ACTIONPARAM
if [[ -f $file ]]; then
  python3 'SRCCode/App/PYScripts/'$_CONFIG_ACTIONPARAM $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE
else
  echo 'No script at '$_SERVER_PROJECT_ROOT_DIR'/SRCCode/App/PYScripts/'$_CONFIG_ACTIONPARAM' found'
fi
# RUN the testme.py script, output to a new file (if exists, will be overwritten):
# python3 'SRCCode/App/PYScripts/testme.py' $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE > 'Output/App/my_python_single_run_results.txt'

# RUN the testme.py script, append output to an exsiting file (will be created if does not exist yet):
# python3 'SRCCode/App/PYScripts/testme.py' $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE >> 'Output/App/my_python_appended_run_results.txt'
