SOURCE="${BASH_SOURCE[0]}"
extract_local_context $SOURCE
# we now have 'App' in $localcontextname, which makes it easier to copy this file to another project

# RUN the .py scripts, output in terminal (the $_MYSQL_ connection parameters come from the Vault and the database from the ConfigList.txt):
python3 'SRCCode/'$localcontextname'/PYScripts/zscores3.py' $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE
python3 'SRCCode/'$localcontextname'/PYScripts/zscores4.py' $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE # temporary second file to do PACs, will back to one once paramaterized
python3 'SRCCode/'$localcontextname'/PYScripts/p_vs_np_PACs_metals.py' $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE # temporary second file to do PACs, will back to one once paramaterized

# Example: Call any shell function here (This example lists all available functions):
info_list_functions

# Example: RUN the testme.py script, output to a new file (if exists, will be overwritten):
python3 'SRCCode/'$localcontextname'/PYScripts/testme.py' $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE > 'Output/'$localcontextname'/my_python_single_run_results.txt'

# Example: RUN the testme.py script, append output to an existing file (will be created if does not exist yet):
python3 'SRCCode/'$localcontextname'/PYScripts/testme.py' $_MYSQL_USER $_MYSQL_USER_PASSWORD $_MYSQL_HOST_IP $_CONFIG_DATABASE >> 'Output/'$localcontextname'/my_python_appended_run_results.txt'

# Example: Call any other shell script:
source 'SRCCode/'$localcontextname'/SHScripts/Generic/example.sh'
