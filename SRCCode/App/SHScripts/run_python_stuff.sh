# RUN the testme.py script, output in terminal (the $_MYSQL_ connection parameters come from the Vault and the database from the ConfigList.txt):
python3 'SRCCode/App/PYScripts/testme.py' $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE

# RUN the testme.py script, output to a new file (if exists, will be overwritten):
# python3 'SRCCode/App/PYScripts/testme.py' $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE > 'Output/App/my_python_single_run_results.txt'

# RUN the testme.py script, append output to an exsiting file (will be created if does not exist yet):
# python3 'SRCCode/App/PYScripts/testme.py' $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE >> 'Output/App/my_python_appended_run_results.txt'
