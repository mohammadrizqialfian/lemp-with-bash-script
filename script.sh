#!/bin/sh
#reset warna
color_off='\033[0m'

#beri warna
red='\033[0;31m'

clear
echo "========================================"
echo "1. Install & configure all"
echo "2. Manual"
echo "3. Exit"
echo "========================================"

read -p "Please insert with number: " choice

#update dan upgrade system
#echo -e "$red \n\tupdate dan upgrade system.. $color_off"
#sudo apt update -y && sudo apt upgrade -y

case $choice in 
	1)
		clear
		system/./system.sh
		read -p "apakah ingin membuat virtualhost lagi(y/n): " pilihan
		while ((pilihan = 'y')); do
			clear
			system/./system.sh
			read -p "apakah ingin membuat virtualhost lagi(y/n): " pilihan
		done
		./script.sh
		;;
	2)
		clear
		install_wordpress
		;;
	3) 
		echo "keluar"
		exit
		;;
	*)
		exit
esac
