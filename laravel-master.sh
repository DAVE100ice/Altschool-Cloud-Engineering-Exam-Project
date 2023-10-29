#!/bin/bash

set -e 

# 2 - Setup LAMP on master

#First update the server

echo -e "\n\nUpdating Apt Packages and upgrading latest patches\n"

# Update packages
sudo apt update -y && sudo apt upgrade -y

# Then, Install Apache and enable it to launch on start-up
sudo apt install apache2 -y
sudo systemctl enable apache2

#Now install MySQL
sudo apt-get install -y mysql-server
sudo mysql_secure_installation

# And Install PHP and related modules
sudo apt-get install -y php libapache2-mod-php php-mysql

#Restart Apache
sudo systemctl restart apache2


# 3 - Clone Laravel from github
sudo apt install git -y
if ! [ -d "/var/www/html/laravel" ]; then
    sudo git clone https://github.com/laravel/laravel.git /var/www/html/laravel 
fi

#Change ownership of the laravel directory
sudo chown -R www-data:www-data /var/www/html/laravel

#Install composer, dependency manager for php
sudo apt install curl -y
curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer

#install the laravel dependencies using composer
cd /var/www/html/laravel
sudo composer install


#Copy the example environment file and generate an application key for Laravel
cd /var/www/html/laravel
sudo cp .env.example .env
sudo php artisan key:generate

#Create new database for Laravel and set the credentials using $1 and $2 as supplied when calling the script
sudo mysql -e "CREATE DATABASE '$1';"
sudo mysql -e "CREATE USER '$1'@'localhost' IDENTIFIED BY '$2';"
sudo mysql -e "GRANT ALL ON $1.* TO '$1'@'localhost';"
sudo mysql -e "FLUSH PRIVILEGES;"

#Edit the .env file and update the database credentials
sudo sed -i -b 's/DB_DATABASE=laravel/DB_DATABASE=David12345/' /var/www/html/laravel/.env
sudo sed -i -b 's/DB_USERNAME=laravel/DB_USERNAME=David12345/' /var/www/html/laravel/.env
sudo sed -i -b 's/DB_PASSWORD=/DB_PASSWORD=Estherubi/' /var/www/html/laravel/.env

#Run the database migrations to create the necessary tables for Laravel
sudo php artisan migrate

#Set permissions
echo -e "\n\nPermissions for /var/www/html/laravel\n"
sudo chown -R www-data:www-data /var/www/html/laravel
sudo chmod -R 775 /var/www/html/laravel
sudo chmod -R 775 /var/www/html/laravel/storage
sudo chmod -R 775 /var/www/html/laravel/bootstrap/cache


echo -e "\n\n Permissions have been set\n"

#Configure Apache

sudo tee /etc/apache2/sites-available/laravel.conf <<EOF 
<VirtualHost *:80>
    ServerAdmin davidubi079@gmail.com
    ServerName 192.168.33.35
    DocumentRoot /var/www/html/laravel/public

    <Directory /var/www/html/laravel>
    AllowOverride All
    Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>

EOF

#Enable the laravel virtual host and disable the default one
sudo a2ensite laravel.conf
sudo a2dissite 000-default.conf

#Enable the Apache rewrite module to support laravel routes
sudo a2enmod rewrite

#Restart Apache to apply the changes
sudo systemctl restart apache2
