SOURCE="${BASH_SOURCE[0]}"
extract_local_context $SOURCE

file=$_SERVER_PROJECT_ROOT_DIR'/SRCCode/'$localcontextname'/SQLScripts/Queries/'$_CONFIG_DATABASE'/'$_CONFIG_ACTIONPARAM
if [[ -f $file ]]; then
  call_app_query_sql_script $_CONFIG_DATABASE'/'$_CONFIG_ACTIONPARAM
else
  echo 'No script at '$_SERVER_PROJECT_ROOT_DIR'/SRCCode/'$localcontextname'/SQLScripts/Queries/'$_CONFIG_DATABASE'/'$_CONFIG_ACTIONPARAM' found'
fi
