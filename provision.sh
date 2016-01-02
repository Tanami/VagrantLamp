#!/bin/bash
PROJECT=$1;
apache_vhost_file="/etc/apache2/sites-available/$PROJECT.conf"
apache_server_name="www.$PROJECT.com"

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
	sudo apt-get -y install apache2 > /dev/null

	sudo cat << EOF > ${apache_vhost_file}
<VirtualHost *:80>
        ServerName ${apache_server_name}

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

	sudo a2dissite 000-default > /dev/null
	sudo a2ensite $PROJECT > /dev/null
	sudo a2enmod rewrite > /dev/null
	sudo service apache2 restart > /dev/null
}

php(){
    echo Installing PHP
	sudo apt-get -y install php5 php5-curl php5-mysql > /dev/null
}


mysql(){
    echo Installing Mysql
	echo "mysql-server mysql-server/root_password password root" | debconf-set-selections > /dev/null
	echo "mysql-server mysql-server/root_password_again password root" | debconf-set-selections > /dev/null
	sudo apt-get -y install mysql-client mysql-server > /dev/null

	sudo service mysql restart > /dev/null
}
main
exit 0
