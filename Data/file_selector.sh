if [[ "$PROJECTSELECTION" == 'KT' ]];
then
DATABASE='KTlocal'
INITFILE='create_KTlocal.sql'
DATAFILE_1='KTdata_locations_MDLs_refvals.sql'#this is the data from Jasons database
DATAFILE_2='KTdata_metals_pacs_rods.sql'#this is the new data from Phil
STRUCTUREFILE_1='KTlocal_structure.sql'
STRUCTUREFILE_2='KTlocal_2020-11-11_structure.sql'
fi

if [[ "$PROJECTSELECTION" == 'MacDATA' ]];
then
DATABASE='MacDATA'
INITFILE='/vagrant/Projects/MacDATA_scripts/create_MacDATA.sql'
DATAFILE_3='Data/CSV_data/reproductive_csv.csv'
STRUCTUREFILE_3='Projects/MacDATA_scripts/MacDATA_temp_structure.sql'
#STRUCTUREFILE_4=
fi

#if [[ "$SERVERSELECTION" == 'remote' ]];
#then
#DATABASE='rob_ktproject'
#3INITFILE='create_KTremote.sql'
#fi

