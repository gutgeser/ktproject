printf 'Cloning new directory layout and scaffold for new App: '$_CONFIG_ACTIONPARAM;
mkdir -p '../'$_CONFIG_ACTIONPARAM'/Data';
mkdir -p '../'$_CONFIG_ACTIONPARAM'/Output';
mkdir -p '../'$_CONFIG_ACTIONPARAM'/runFiles';
mkdir -p '../'$_CONFIG_ACTIONPARAM'/SRCCode';
