#!/bin/sh
#reset warna
color_off='\033[0m'

#beri warna
red='\033[0;31m'

#masukkan password baru
echo -e "$red \n\t masukkan password root database anda.. $color_off"
read -p "Input pasword root database : " password_root

#menambahkan database baru
echo -e "$red \n\t menambahkan database baru.. $color_off"
read -p "Input database baru : " database_new
sudo mysql -u root -p"$password_root" -e "create database $database_new;"

#menambahkan user untuk database tersebut
echo -e "$red \n\t menambahkan user baru untuk database tersebut.. $color_off"
read -p "Input user baru : " user_new
read -p "Input password baru : " password_new
sudo mysql -u root -p"$password_root" -e "grant all on $database_new.* to $user_new identified by '"$password_new"'; flush privileges;"

