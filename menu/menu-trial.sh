#!/bin/bash
# // Menu trial
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
rm -f menu-v2ray 
exit 0
fi

clear
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[m"
echo -e "\033[30;5;47m                   ⇱ MENU TRIAL ⇲                 \033[m"
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[37m"
echo -e""
echo -e "[${CYAN}•1${NC}] Create TRial XRay VMess Accounts "                     
echo -e "[${CYAN}•2${NC}] Create TRial XRay VLess Accounts "                    
echo -e "[${CYAN}•3${NC}] Create TRial XRay Trojan Accounts "                    
echo -e "[${CYAN}•4${NC}] Create TRial XRay Shadowsock Accounts "                          
echo -e "[${CYAN}•5${NC}] Create TRial XRay Xray All Accounts "                          
echo -e "[${CYAN}•6${NC}] Create TRial Ssh & Vpn "                          
echo -e""
echo -e "[${RED}•x${NC}] ${RED} Menu${NC}"
echo -e""
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[m"
echo -e""
read -p "  silahkan masukkan nomor [1-13 or x] :  "  menu
case $menu in 
1) clear ; trialvmess ; exit ;;
2) clear ; trialvless ; exit ;;
3) clear ; trialtrojan ; exit ;; 
4) clear ; trialss ; exit ;;
5) clear ; trialxtls ; exit ;; 
6) clear ; trial ; exit ;; 
x) clear ; menu ;;
*) echo -e "" ; echo "Boh salah tekan " ; sleep 1 ; trial-menu ;;
esac

