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

case $choice in
        1)
                clear
                system/./system.sh
                read -p "apakah ingin membuat virtualhost lagi(y/n): " pilihan
                while [ "$pilihan" == "y" ]
                do
                        clear
                        system/./system.sh
                        read -p "apakah ingin membuat virtualhost lagi(y/n): " pilihan
                done

		nginx/./nginx.sh
		php/./php.sh
		php/./php-createphpfile.sh
		nginx/./nginx-config.sh
		mariadb/./mariadb.sh
		mariadb/./mariadb-createdb.sh
		read -p "apakah ingin membuat database lagi(y/n): " pilihan2
                while [ "$pilihan2" == "y" ]
                do
                        clear
                        mariadb/./mariadb-createdb.sh
                        read -p "apakah ingin membuat database lagi(y/n): " pilihan2
                done
		cms/./wordpress.sh
		cms/./joomla.sh
		clear
		echo -e "$red \n\tproses telah selesai semua$color_off"
		;;
	2)
		clear
		read -p "yakin ingin memasang secara manual(y/n): " manual
		while [ "$manual" == "y" ]
                do
                        clear
                        echo "========================================"
			echo "1. Add VirtualHost and Update Upgrade System"
			echo "2. Install nginx"
			echo "3. Install php"
			echo "4. Membuat fil PHP di directory default(/var/www/html)"
			echo "5. Membuat directory root dan config nginx di home directory user"
			echo "6. Install mariadb"
			echo "7. menambahkan database"
			echo "8. memasang wordpress di directory default"
			echo "9. memasang joomla di di directory home directory user"
			echo "10. keluar"
			echo "========================================"
                        read -p "Masukkan angka: " pilih

			case $pilih in
				1)
					clear
					system/./system.sh
					read -p "apakah ingin membuat virtualhost lagi(y/n): " pilihan3
					while [ "$pilihan3" == "y" ]
					do
						clear
						system/./system.sh
						read -p "apakah ingin membuat virtualhost lagi(y/n): " pilihan3 
					done
					read -p "apakah ingin kembali ke menu memasang secara manual(y/n): " manual
					;;
				2)
					clear
					nginx/./nginx.sh
					read -p "apakah ingin kembali ke menu memasang secara manual(y/n): " manual
					;;
				3)
					clear
					php/./php.sh
					read -p "apakah ingin kembali ke menu memasang secara manual(y/n): " manual
					;;
				4)
					clear
					php/./php-createphpfile.sh
					read -p "apakah ingin kembali ke menu memasang secara manual(y/n): " manual
					;;
                                5)
                                        clear
					nginx/./nginx-config.sh
                                        read -p "apakah ingin kembali ke menu memasang secara manual(y/n): " manual
					;;
                                6)
                                        clear
					mariadb/./mariadb.sh
                                        read -p "apakah ingin kembali ke menu memasang secara manual(y/n): " manual
					;;
                                7)
                                        clear
					mariadb/./mariadb-createdb.sh
                			read -p "apakah ingin membuat database lagi(y/n): " pilihan4
					while [ "$pilihan4" == "y" ]
					do
						clear
						mariadb/./mariadb-createdb.sh
						read -p "apakah ingin membuat database lagi(y/n): " pilihan4
					done
                                        read -p "apakah ingin kembali ke menu memasang secara manual(y/n): " manual
					;;
                                8)
                                        clear
					cms/./wordpress.sh
                                        read -p "apakah ingin kembali ke menu memasang secara manual(y/n): " manual
					;;
                                9)
                                        clear
					cms/./joomla.sh
                                        read -p "apakah ingin kembali ke menu memasang secara manual(y/n): " manual
					;;
				10)
					exit
					;;
			esac
                done
		;;
	3)
		echo "keluar"
		exit
		;;
	*)
		exit
		;;
esac
