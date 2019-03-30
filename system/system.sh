#!/bin/sh
#reset warna
color_off='\033[0m'

#beri warna
red='\033[0;31m'

#update dan upgrade system
echo -e "$red \n\tupdate dan upgrade system.. $color_off"
sudo apt update -y && sudo apt upgrade -y

#masukkan domain untuk virtualhost
echo -e "$red \n\tmenambahkan virtualhost.. $color_off"
read -p "Input domain virtualhost baru : " virtual_new
sudo sed -i "2 a127.0.0.1\\t$virtual_new" /etc/hosts


