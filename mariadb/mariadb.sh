#!/bin/sh
#reset warna
color_off='\033[0m'

#beri warna
red='\033[0;31m'
#install mariadb
echo -e "$red \n\tinstall mariadb.. $color_off"
sudo apt install mariadb-server -y
#masukkan password baru
echo -e "$red \n\t masukkan password baru untuk user root database.. $color_off"
read -p "Input pasword baru : " password_new

#mengubah password root
echo -e "$red \n\t change password root.. $color_off"
sudo mysql -u root -p'$password_new' -e "UPDATE mysql.user SET password = PASSWORD('$password_new') WHERE User = 'root' AND Host = 'localhost'; flush privileges;"

#menghapus anonymous user
echo -e "$red \n\t remove anonymous user.. $color_off"
sudo mysql -u root -p'$password_new' -e "delete from mysql.user where user=''; flush privileges;"

#disallow root login remotely
echo -e "$red \n\t dissalow root login remotely.. $color_off"
sudo mysql -u root -p'$password_new' -e "DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1'); flush privileges;"

#menghapus database test sekaligus aksesnya
echo -e "$red \n\t delete database test sekaligus aksesnya.. $color_off"
sudo mysql -u root -p'$password_new' -e "DELETE FROM mysql.db WHERE db IN('test', 'test\_%');"

#disable plugin(login with any password)
echo -e "$red \n\t disable plugin.. $color_off"
sudo mysql -u root -p'$password_new' -e "update mysql.user set plugin='' where user='root'; flush privileges;"

