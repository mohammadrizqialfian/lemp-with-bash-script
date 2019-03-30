#!/bin/sh
#reset warna
color_off='\033[0m'

#beri warna
red='\033[0;31m'

#menambahkan directory www di home directory user
read -p "Input nama directory baru untuk menyimpan website: " directory
echo -e "$red \n\tmenambahkan directory www/$directory di home directory user $color_off"
mkdir -p ~/www/"$directory"

#membuat directory conf.d
echo -e "$red \n\tmenambahkan directory conf.d di home directory user $color_off"
mkdir -p ~/conf.d

#menyalin file default
echo -e "$red \n\tmenyalin file default ke directory conf.d yang ada di home directory user $color_off"
read -p "masukkan nama file (.conf): " file
cp /etc/nginx/sites-available/default ~/conf.d/"$file"
 
#menambahkan nama domain
read -p "masukkan nama domain/ip server : " domain_new
echo -e "$red \n\tmenambahkan domain di file ~/conf.d/$file.. $color_off"
sed -i "0,/server_name .*/s//server_name $domain_new;/" ~/conf.d/"$file"

#menghapus default server
echo -e "$red \n\tmenghapus default_server di file ~/conf.d/$file.. $color_off"
sed -i "0,/listen 80 default_server;/s//listen 80 ;/" ~/conf.d/"$file"
sed -i "0,/listen \[::\]:80 default_server;/s//listen \[::\]:80 ;/" ~/conf.d/situs2.conf 

#menambahkan include di nginx.conf
echo -e "$red \n\tmenambahkan include conf.d di file nginx.conf.. $color_off"
read -p "masukkan home directory user kalian(/home/fossil): " directoryku
sudo sed -i "63 ainclude $directoryku\/conf.d\/*.conf;" /etc/nginx/nginx.conf
sudo sed -i "0,/include \/home/s//\\tinclude \/home/" /etc/nginx/nginx.conf

#menambahkan root directory di conf.d
echo -e "$red \n\tmenambahkan root directory di conf.d.. $color_off"
sed -i "0,/root \/var\/www\/html;/s//#root \/var\/www\/html;/" ~/conf.d/"$file"
sed -i "41 aroot $directoryku\/www\/$directory;" ~/conf.d/"$file"
sed -i "0,/root \/home/s//\\troot \/home/" ~/conf.d/"$file"

#reload nginx
echo -e "$red \n\treload nginx.. $color_off"
sudo systemctl reload nginx

