#!/bin/bash
# // Warna
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0;37m'
LIGHT='\033[0;37m'

# // Getting                                                                                                                      
MYIP=$(wget -qO- ipinfo.io/ip);                                                                                                   
echo "Checking VPS"                                                                                                               
IZIN=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | awk '{print $4}' | grep $MYIP )                           
if [[ $MYIP = $IZIN ]]; then                                                                                                      
echo -e "${GREEN}Permission Accepted...${NC}"                                                                                     
else                                                                                                                              
echo -e "${RED}Permission Denied!${NC}";                                                                                          
echo -e "${LIGHT}Please Contact Admin!!"                                                                                          
rm -f bw.sh  
rm -f bw                                                                                                                     
exit 0                                                                                                                            
fi                                                                                                                                
clear

# // Menu Bw
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[m"
echo -e "\033[30;5;47m                ⇱ BANDWITH MONITOR ⇲              \033[m"
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[37m"
echo -e ""
echo -e "[${CYAN}•1${NC}]  Lihat Total Bandwith Tersisa"
echo -e "[${CYAN}•2${NC}]  Tabel Penggunaan Setiap 5 Menit"
echo -e "[${CYAN}•3${NC}]  Tabel Penggunaan Setiap Jam"
echo -e "[${CYAN}•4${NC}]  Tabel Penggunaan Setiap Hari"
echo -e "[${CYAN}•5${NC}]  Tabel Penggunaan Setiap Bulan"
echo -e "[${CYAN}•6${NC}]  Tabel Penggunaan Setiap Tahun"
echo -e "[${CYAN}•7${NC}]  Tabel Penggunaan Tertinggi"
echo -e "[${CYAN}•8${NC}]  Statistik Penggunaan Setiap Jam"
echo -e "[${CYAN}•9${NC}]  Lihat Penggunaan Aktif Saat Ini"
echo -e "[${CYAN}10${NC}]  Lihat Trafik Penggunaan Aktif Saat Ini [5s]"
echo -e ""
echo -e "[${RED}•x${NC}] ${RED} Menu${NC}"
echo -e ""
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[m"
echo -e ""
read -p "  silahkan masukkan nomor [1-10 or x] :  "  menu
echo -e ""
clear
case $menu in
1)
clear
echo "---------------------------------------------";
echo "------=[ TOTAL BANDWITH SERVER LEFT  ]=------";
echo "---------------------------------------------";
echo -e ""

vnstat

echo -e ""
echo "---------------------------------------------";
echo -e ""
;;

2)
clear
echo "---------------------------------------------";
echo "-----=[ USE BANDWITH EVERY 5 MINUTES ]=------";
echo "---------------------------------------------";
echo -e ""

vnstat -5

echo -e ""
echo "---------------------------------------------";
echo -e ""
;;

3)
clear
echo "---------------------------------------------";
echo "--------=[ USE BANDWITH EVERY HOUR ]=--------";
echo "---------------------------------------------";
echo -e ""

vnstat -h

echo -e ""
echo "---------------------------------------------";
echo -e ""
;;

4)
clear
echo "---------------------------------------------";
echo "--------=[ USE BANDWITH EVERY DAY ]=---------";
echo "---------------------------------------------";
echo -e ""

vnstat -d

echo -e ""
echo "---------------------------------------------";
echo -e ""
;;

5)
clear
echo "---------------------------------------------";
echo "-------=[ USE BANDWITH EVERY MONTH ]=--------";
echo "---------------------------------------------";
echo -e ""

vnstat -m

echo -e ""
echo "---------------------------------------------";
echo -e ""
;;

6)
clear
echo "---------------------------------------------";
echo "-------=[ USE BANDWITH EVERY YEARS ]=--------";
echo "---------------------------------------------";
echo -e ""

vnstat -y

echo -e ""
echo "---------------------------------------------";
echo -e ""
;;

7)
clear
echo "---------------------------------------------";
echo "---------=[ HIGHEST BANDWITH USE ]=----------";
echo "---------------------------------------------";
echo -e ""

vnstat -t

echo -e ""
echo "---------------------------------------------";
echo -e ""
;;

8)
clear
echo "---------------------------------------------";
echo "---=[ BANDWITH GRAPHICS USED EVERY HOUR ]=---";
echo "---------------------------------------------";
echo -e ""

vnstat -hg

echo -e ""
echo "---------------------------------------------";
echo -e ""
;;

9)
clear
echo "---------------------------------------------";
echo "----=[ LIVE USE OF BANDWITH CURRENTLY ]=-----";
echo "---------------------------------------------";
echo -e ""
echo -e " ${white}CTRL+C Untuk Keluar!${off}"
echo -e ""

vnstat -l

echo -e ""
echo "---------------------------------------------";
echo -e ""
;;

10)
clear
echo "---------------------------------------------";
echo "-------=[ LIVE TRAFFIC USE BANDWITH ]=-------";
echo "---------------------------------------------";
echo -e ""

vnstat -tr

echo -e ""
echo "---------------------------------------------";
echo -e ""
;;

x) clear ; menu ;;
*) echo -e "" ; echo "Boh salah tekan " ; sleep 1 ; menu-bw ;;
esac
