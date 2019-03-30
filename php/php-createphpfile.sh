#!/bin/sh
#reset warna
color_off='\033[0m'

#beri warna
red='\033[0;31m'

#membuat file untuk cek php di directory default nginx
echo -e "$red \n\tmasukkan nama file(bebas) yang berfungsi menyimpan code phpinfo"
read -p "masukkan nama file(.php) : " file_new
echo -e "$red \n\tmembuat file .. $color_off"
sudo touch /var/www/html/"$file_new"
sudo bash -c "echo '<?php' >> /var/www/html/$file_new"
sudo bash -c "echo -e '\tphpinfo();' >> /var/www/html/$file_new"
sudo bash -c "echo '?>' >> /var/www/html/$file_new"
