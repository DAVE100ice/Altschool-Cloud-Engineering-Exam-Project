#!/bin/bash


# UPDATING & UPGRADING THE SERVER

###########################################################

sudo apt update && sudo apt upgrade -y < /dev/null

#############################################################




############################################################

# INSTALLATION OF LAMP STACK

###########################################################
sudo apt-get install apache2 -y < /dev/null

sudo apt-get install mysql-server -y  < /dev/null

sudo add-apt-repository -y ppa:ondrej/php < /dev/null

sudo apt-get update < /dev/null

sudo apt-get install libapache2-mod-php php-common php-xml php-mysql php-gd php-mbstring php-tokenizer php-json php-bcmath php-curl php-zip unzip-y  

sudo sed -i 's/cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/8.2/apache2/php.ini

sudo systemctl restart apache2 < /dev/null

#########################################################


#########################################################

# INSTALL COMPOSE

########################################################

sudo apt install curl -y 

curl -sS https://getcomposer.org/installer | php

sudo mv composer.phar /usr/local/bin/composer

composer --version < /dev/null

##########################################################

##########################################################

# Configuration for Apache2 Server
  
##########################################################
cat <<EOF > /etc/apache2/sites-available/laravel.conf
<VirtualHost *:80>
    ServerAdmin davidubi079@gmail.com
    ServerName "192.168.33.35"
    DocumnetRoot /var/www/html/laravel/public

    <Directory /var/www/html/laravel>
    Options Indexes Multiviews FollowSymLinks
    AllowOverride All
    Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error.log
    CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
EOF

sudo a2enmod rewrite

sudo a2ensite laravel.conf 

sudo systemctl restart apache2 

#################################################


#################################################

# CLONE LARAVEl APPLICATION 

#################################################

 mkdir /var/www/html/laravel && cd /var/www/html/laravel

 cd /var/www/html && git clone https://github.com/laravel/laravel

 cd /var/www/html/laravel && composer install --no-dev < /dev/null

 sudo chmod -R  www-data:www-data /var/www/html/laravel/.env

 sudo chmod -R 755 /var/www/html/laravel

 sudo chmod -R 755 /var/www/html/laravel/storage 

 sudo chmod -R 755 /var/www/html/laravel/bootstrap/cache 

 cd /var/www/html/laravel && sudo cp .env.example .env

 php artisan key: generate 


##################################################



##################################################

# CONFIGURING MYSQL: CREATING USER AND PASSWORD

#################################################


echo "Creating MYSQL user and database"
PASS=$2
if [ -z "$2"]; then
   Pass=`openssl rand -base64 8`

mysql -u root <<MYSQL_SCRIPT
Create DATABASE $1;
Create USER '$1'@'localhost'  IDENTIFIED BY '$PASS';
GRANT ALL PRIVILEGES ON $1.* TO '$1'@'localhost';
FLUSH PRIVILEGES;
MYSQL_SCRIPT

echo "MYSQL user and database created."
echo "username: $1"
echo "Database: $1"
echo "Password: $PASS"

######################################################
 



#####################################################

# EXECUTE KEY GENERATE AND MIGRATE COMMAND FOR PHP

######################################################

sudo sed -i 's/DB_DATABASE=laravel/DB_DATABASE=Davidubi1/' /var/www/html/laravel/.env

sudo sed -i 's/DB_USERNAME=root/DB_USERNAME=Davidubi1/' /var/www/html/laravel/.env

sudo sed -i 's/DB_PASSWORD=/DB_PASSWORD=Davidubi1/'  /var/www/html/laravel/.env

php artisan config:cache

cd /var/www/html/laravel && php artisan migrate

#################################################### 