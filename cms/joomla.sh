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
echo -e "$red \n\tmasukkan inputan dengan benar.. $color_off"
read -p "Input home directory user kalian (/home/fossil): " directory
read -p "Input nama file .conf kalian(situs2.conf): " file
read -p "Input nama directory penyimpanan joomla(www/situs2): " situs2

#hapus index yang tidak relevan/digunakan
echo -e "$red \n\tmenghapus index yang tidak digunakan.. $color_off"
sudo sed -i "0,/index.htm index.nginx-debian.html;/s//;/" "$directory"/conf.d/"$file"

#menambahkan settingan
echo -e "$red \n\tmenambah script di file default.. $color_off"
sudo sed -i "0,/ =404;/s// \/index.php\$args;/"  "$directory"/conf.d/"$file"

#reload nginx
echo -e "$red \n\treload nginx.. $color_off"
sudo systemctl reload nginx

#memasang wget
echo -e "$red \n\tmemasang wget.. $color_off"
sudo apt install wget -y

#download joomla menggunakan wget
echo -e "$red \n\tmendownload joomla.. $color_off"
sudo wget -P "$directory"/"$situs2" https://github.com/joomla/joomla-cms/releases/download/3.8.2/Joomla_3.8.2-Stable-Full_Package.tar.gz

#mengextract joomla
echo -e "$red \n\tmengextract joomla.. $color_off"
sudo tar zxvf "$directory"/"$situs2"/Joomla_3.8.2-Stable-Full_Package.tar.gz -C "$directory"/"$situs2"

#merubah kepemilikan directory wordpress
echo -e "$red \n\tmerubah kepemilikan directory joomla.. $color_off"
sudo chown -R www-data:www-data "$directory"/"$situs2"

#merestart nginx
echo -e "$red \n\tmereload nginx.. $color_off"
sudo systemctl reload nginx
