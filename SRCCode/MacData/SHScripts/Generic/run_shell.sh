file=$_SERVER_PROJECT_ROOT_DIR'/SRCCode/MacData/SHScripts/'$_CONFIG_ACTIONPARAM
if [[ -f $file ]]; then
  if ! [[ $_CONFIG_ACTIONPARAM == 'Generic/run_shell.sh' ]]; then
    source 'SRCCode/MacData/SHScripts/'$_CONFIG_ACTIONPARAM
  else
    echo 'Cannot call this invocation script in a circle !!'
  fi
else
  echo 'No script at '$_SERVER_PROJECT_ROOT_DIR'/SRCCode/MacData/SHScripts/'$_CONFIG_ACTIONPARAM' found'
fi
