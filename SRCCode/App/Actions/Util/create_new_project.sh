printf 'Creating new directory layout and scaffold for new Project: '$_CONFIG_ACTIONPARAM;
mkdir -p 'Data/'$_CONFIG_ACTIONPARAM'/CSV';
mkdir -p 'Data/'$_CONFIG_ACTIONPARAM'/SQL';
mkdir -p 'Output/'$_CONFIG_ACTIONPARAM;
mkdir -p 'runFiles/'$_CONFIG_ACTIONPARAM;
mkdir -p 'SRCCode/'$_CONFIG_ACTIONPARAM;

cp 'runFiles/App/project_default_template.sh' 'runFiles/'$_CONFIG_ACTIONPARAM'/default.sh';

mkdir -p 'SRCCode/'$_CONFIG_ACTIONPARAM'/Actions/Util';
cp 'SRCCode/App/Actions/Util/run_python_script.sh' 'SRCCode/'$_CONFIG_ACTIONPARAM'/Actions/Util';
cp 'SRCCode/App/Actions/Util/run_shell_script.sh' 'SRCCode/'$_CONFIG_ACTIONPARAM'/Actions/Util';
cp 'SRCCode/App/Actions/Util/run_sql_query.sh' 'SRCCode/'$_CONFIG_ACTIONPARAM'/Actions/Util';

cp 'SRCCode/App/Actions/Util/create_db_sql_folders.sh' 'SRCCode/'$_CONFIG_ACTIONPARAM'/Actions/Util';


mkdir -p 'SRCCode/'$_CONFIG_ACTIONPARAM'/Actions/DB';
mkdir -p 'SRCCode/'$_CONFIG_ACTIONPARAM'/PYScripts';
mkdir -p 'SRCCode/'$_CONFIG_ACTIONPARAM'/SHScripts';
cp -R 'SRCCode/App/SHScripts/Generic' 'SRCCode/'$_CONFIG_ACTIONPARAM'/SHScripts';
mkdir -p 'SRCCode/'$_CONFIG_ACTIONPARAM'/SQLScripts/Management';
mkdir -p 'SRCCode/'$_CONFIG_ACTIONPARAM'/SQLScripts/Procedures';
mkdir -p 'SRCCode/'$_CONFIG_ACTIONPARAM'/SQLScripts/Queries';
mkdir -p 'SRCCode/'$_CONFIG_ACTIONPARAM'/SQLScripts/Schemas';
