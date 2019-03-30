#!/bin/sh
#reset warna
color_off='\033[0m'

#beri warna
red='\033[0;31m'

#install dependensi php tambahan
echo -e "$red \n\tmemasang dependensi php yang belum terinstall.. $color_off"
sudo apt install php-curl php-gd php-intl php-mbstring php-soap php-xml php-xmlrpc php-zip -y

#restart php-fpm
echo -e "$red \n\tmerestart php-fpm.. $color_off"
sudo systemctl restart php7.0-fpm

#hapus index yang tidak relevan/digunakan
echo -e "$red \n\tmenghapus index yang tidak digunakan.. $color_off"
sudo sed -i "0,/index.htm index.nginx-debian.html;/s//;/" /etc/nginx/sites-available/default

#menambahkan settingan
echo -e "$red \n\tmenambah script di file default.. $color_off"
sudo sed -i "0,/ =404;/s// \/index.php\$is_args\$args;/" /etc/nginx/sites-available/default

#reload nginx
echo -e "$red \n\treload nginx.. $color_off"
sudo systemctl reload nginx

#memasang wget
echo -e "$red \n\tmemasang wget.. $color_off"
sudo apt install wget -y

#download wordpress menggunakan wget
echo -e "$red \n\tmendownload wordpress.. $color_off"
sudo wget -P /var/www/html https://wordpress.org/latest.tar.gz

#mengextract wordpress
echo -e "$red \n\tmengextract wordpress.. $color_off"
sudo tar zxvf /var/www/html/latest.tar.gz -C /var/www/html/

#menyalin wp-config
echo -e "$red \n\tmenyalin wp-config.php $color_off"
sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

#menambahkan nama database
echo -e "$red \n\tmenambahkan nama database.. $color_off"
read -p "Input nama database yang sudah dibuat untuk wp: " db_baru
sudo sed -i "0,/'DB_NAME', .*/s//'DB_NAME', '"$db_baru"');/" /var/www/html/wordpress/wp-config.php
read -p "Input username database yang sudah dibuat untuk wp: " user_db_baru
sudo sed -i "0,/'DB_USER', .*/s//'DB_USER', '"$user_db_baru"');/" /var/www/html/wordpress/wp-config.php
read -p "Input password untuk user database yang dibuat untuk wp: " password_db_baru
sudo sed -i "0,/'DB_PASSWORD', .*/s//'DB_PASSWORD', '"$password_db_baru"');/" /var/www/html/wordpress/wp-config.php

#merubah kepemilikan directory wordpress
echo -e "$red \n\tmerubah kepemilikan directory wordpress.. $color_off"
sudo chown -R www-data:www-data /var/www/html/wordpress

#merubah root directory web server
echo -e "$red \n\tmerubah root directory web server.. $color_off"
sed -i "0,/root \/var\/www\/html;/s//root \/var\/www\/html\/wordpress;/" /etc/nginx/site-available/default

#merestart nginx
echo -e "$red \n\tmereload nginx.. $color_off"
sudo systemctl reload nginx
