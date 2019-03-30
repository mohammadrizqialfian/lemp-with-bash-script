#!/bin/sh
#reset warna
color_off='\033[0m'

#beri warna
red='\033[0;31m'

#install nginx
echo -e "$red \n\tinstall nginx.. $color_off"
sudo apt install nginx -y

#menambahkan nama domain
read -p "masukkan nama domain/ip server : " domain_new
echo -e "$red \n\tmenambahkan domain di file default.. $color_off"
sudo sed -i "0,/server_name .*/s//server_name $domain_new;/" /etc/nginx/sites-available/default

