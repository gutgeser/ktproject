SOURCE="${BASH_SOURCE[0]}"
extract_local_context $SOURCE

file=$_SERVER_PROJECT_ROOT_DIR'/SRCCode/'$localcontextname'/SHScripts/'$_CONFIG_ACTIONPARAM
if [[ -f $file ]]; then
  if ! [[ $_CONFIG_ACTIONPARAM == 'Generic/run_shell.sh' ]]; then
    source 'SRCCode/'$localcontextname'/SHScripts/'$_CONFIG_ACTIONPARAM
  else
    echo 'Cannot call this invocation script in a circle !!'
  fi
else
  echo 'No script at '$_SERVER_PROJECT_ROOT_DIR'/SRCCode/'$localcontextname'/SHScripts/'$_CONFIG_ACTIONPARAM' found'
fi
