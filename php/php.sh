#!/bin/sh
#reset warna
color_off='\033[0m'

#beri warna
red='\033[0;31m'

#install php-fpm php-mysql
echo -e "$red \n\tinstall php-fpm.. $color_off"
sudo apt install php-fpm php-mysql -y

#install menambahkan index.php di file default
echo -e "$red \n\tinstall php-fpm.. $color_off"
sudo sed -i "0,/index index.html/s//index index.php index.html/" /etc/nginx/sites-available/default

#mengaktifkan php di file default
echo -e "$red \n\tmengaktifkan php di file default.. $color_off"
sudo sed -i "0,/#location ~/s//location ~/" /etc/nginx/sites-available/default
sudo sed -i "0,/#\\tinclude snippets\/fastcgi-php.conf/s//\\tinclude snippets\/fastcgi-php.conf/" /etc/nginx/sites-available/default
sudo sed -i "0,/#\\tfastcgi_pass unix:\/var\/run\/php\/php7.0-fpm.sock;/s//\\tfastcgi_pass unix:\/var\/run\/php\/php7.0-fpm.sock;/" /etc/nginx/sites-available/default
sudo sed -i "0,/#}/s//}/" /etc/nginx/sites-available/default

#mereload nginx
echo -e "$red \n\tmereload nginx.. $color_off"
sudo systemctl reload nginx
