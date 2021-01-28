## TO UPDATE THE SERVER:
# dnf -y update
# dnf -y install mariadb
# dnf -y install mariadb-server

## TO INITIALLY INSTALL MARIADB (Run from inside vagrant box):
# mysql_secure_installation

## TO INSTALL THE PYTHON MYSQL CONNECTOR:
# sudo dnf install python3
# sudo pip3 install mysql-connector-python
# sudo pip3 install numpy
# sudo pip3 install pandas
# sudo pip3 install sqlalchemy
# sudo pip3 install PyMySQL

## IN CASE VIRTUALBOX VERSION DOES NOT MATCH THE GUEST ADDITIONS
# sudo dnf install "kernel-devel-uname-r == $(uname -r)"
# sudo dnf install -y gcc perl kernel-headers kernel-devel
# sudo /opt/VBoxGuestAdditions-6.1.16/uninstall.sh

## THEN RUN THIS ON THE HOST (macBook):
# vagrant plugin install vagrant-vbguest
# vagrant vbguest --do install
# vagrant halt
# vagrant up

# CREATE A WORLD WRITABLE DATAOUTPUT DIR:
# mkdir /vagrant/Output/DATADUMPS
# sudo chmod 777 /vagrant/Output/DATADUMPS
