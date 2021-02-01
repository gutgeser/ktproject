SOURCE="${BASH_SOURCE[0]}"
extract_local_context $SOURCE
mkdir -p 'SRCCode/'$localcontextname'/SQLScripts/Management/'$_CONFIG_DATABASE
mkdir -p 'SRCCode/'$localcontextname'/SQLScripts/Procedures/'$_CONFIG_DATABASE
mkdir -p 'SRCCode/'$localcontextname'/SQLScripts/Schemas/'$_CONFIG_DATABASE
mkdir -p 'SRCCode/'$localcontextname'/SQLScripts/Queries/'$_CONFIG_DATABASE
