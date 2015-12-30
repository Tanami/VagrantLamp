#!/bin/bash
PROJECT=$1;
apache_vhost_file="/etc/apache2/sites-available/$PROJECT.conf"

main() {
    echo Provisioning vagrant instance
    update
    apache
    php
    mysql
}

update() {
    echo Making sure everything is up to date
	sudo apt-get update > /dev/null
	sudo apt-get -y upgrade > /dev/null
}

apache() {
    echo Installing and Setting up Apache2
	sudo apt-get -y install apache2

	sudo cat << EOF > ${apache_vhost_file}
<VirtualHost *:80>
        ServerName www.adamhalldev.com
        ServerAlias adamhalldev.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/$PROJECT

        <Directory /var/www/$PROJECT>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                allow from all
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

	sudo a2dissite 000-default
	sudo a2ensite $PROJECT
	sudo a2enmod rewrite
	sudo service apache2 restart
}

php(){
    echo Installing PHP
	sudo apt-get -y install php5 php5-curl php5-mysql
}


mysql(){
    echo Installing Mysql
	echo "mysql-server mysql-server/root_password password root" | debconf-set-selections
	echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections
	sudo apt-get -y install mysql-client mysql-server

	sudo service mysql restart
}
main
exit 0