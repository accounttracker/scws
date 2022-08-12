#!/bin/bash
# My Telegram : https://t.me/Manternet
# ==========================================
# Color
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0;37m'
LIGHT='\033[0;37m'

# ==========================================
# Getting
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
########################
MYIP=$(curl -sS ipv4.icanhazip.com)
echo "Checking VPS"                                                                                                               
IZIN=$(curl -sS https://raw.githubusercontent.com/manternet/ipvps/main/ip | awk '{print $4}' | grep $MYIP )                       
if [[ $MYIP = $IZIN ]]; then                                                                                                      
echo -e "${NC}${GREEN}Permission Accepted...${NC}"                                                                                
else                                                                                                                              
echo -e "${NC}${RED}Permission Denied!${NC}";                                                                                     
echo -e "${NC}${LIGHT}Please Contact Admin!!"                                                                                     
rm -f changeport.sh                                                                                                                    
exit 0                                                                                                                            
fi                                                                                                                                                                                                                                                  
clear

echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[m"
echo -e "\033[30;5;47m                   ⇱ PORT CHANGER ⇲               \033[m"
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[37m"
echo -e ""
echo -e "[${CYAN}•1${NC}] Change Port Stunnel4"
echo -e "[${CYAN}•2${NC}] Change Port OpenVPN"
echo -e "[${CYAN}•3${NC}] Change Port Squid"
echo -e "[${CYAN}•4${NC}] Change Port Xray"
echo -e "[${CYAN}•5${NC}] Change Port Xray Ws-None"
echo -e ""
echo -e "[${RED}•x${NC}] ${RED}Back To Menu${NC}"
echo -e ""
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[37m"
read -p "  silahkan masukkan nomor [1-14 or x] :  "  port
case $port in
1) clear ; port-ssl ; exit ;;
2) clear ; port-ovpn ; exit ;;
3) clear ; port-squid ; exit ;; 
4) clear ; port-xray ; exit ;; 
5) clear ; port-xrayn ; exit ;; 
x) clear ; menu ;;
*) echo -e "" ; echo "Boh salah tekan " ; sleep 1 ; port-change ;;
esac
