#!/bin/bash
# Color Validation
RED='\033[0;31m'                                                                                          
GREEN='\033[0;32m'                                                                                        
ORANGE='\033[0;33m'
BLUE='\033[0;34m'                                                                                         
PURPLE='\033[0;35m'
CYAN='\033[0;36m'                                                                                         
NC='\033[0;37m'
LIGHT='\033[0;37m'

# // Getiing
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | awk '{print $4}' | grep $MYIP )
if [[ $MYIP = $IZIN ]]; then
echo -e "${GREEN}Permission Accepted...${NC}"
else
echo -e "${RED}Permission Denied!${NC}";
echo -e "${LIGHT}Please Contact Admin!!"
rm -f m-sshvpn
exit 0
fi
clear

# Running

chck_pid(){
        PID=`ps -ef |grep -v grep | grep dropbear |awk '{print $2}'`
}
menu_sts(){
        if dpkg -s dropbear > /dev/null 2>&1; then
               chck_pid
        if [[ ! -z "${PID}" ]]; then
               echo -e "\033[0;37mCurrent Status:\033[m ${GREEN}SSH INSTALLED${NC} & ${GREEN}RUNNING${NC}"
        else
               echo -e "\033[0;37mCurrent Status:\033[m ${GREEN}SSH INSTALLED${NC} but ${RED}NOT RUNNING${NC}"
        fi
        else
        echo -e "\033[0;37mCurrent Status:\033[m ${RED}SSH NOT INSTALLED${NC}"
        fi
}


clear
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[m"
echo -e "\033[30;5;47m                 ⇱ SSH & OVPN MENU ⇲              \033[m"
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\033[37m"
echo -e ""
echo -e " [${CYAN}•1${NC}] Create SSH & OpenVPN Account "
echo -e " [${CYAN}•2${NC}] Trial Account SSH & OpenVPN "
echo -e " [${CYAN}•3${NC}] Renew SSH & OpenVPN Account "
echo -e " [${CYAN}•4${NC}] Delete SSH & OpenVPN Account "
echo -e " [${CYAN}•5${NC}] Check User Login SSH & OpenVPN "
echo -e " [${CYAN}•6${NC}] List Member SSH & OpenVPN "
echo -e " [${CYAN}•7${NC}] Delete User Expired SSH & OpenVPN "
echo -e " [${CYAN}•8${NC}] Set up Autokill SSH "
echo -e " [${CYAN}•9${NC}] Cek Users Who Do Multi Login SSH "
echo -e ""
echo -e " [${RED}•x${NC}] ${RED}MENU${NC}"
echo -e ""
echo -e "\033[5;34m━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\e[37m"
echo -e ""
read -p " Select menu :  "  opt
echo -e ""
case $opt in
1) clear ; addssh ; exit ;;
2) clear ; trial ; exit ;;
3) clear ; renew ; exit ;;
4) clear ; hapus ; exit ;;
5) clear ; cek ; exit ;;
6) clear ; member ; exit ;;
7) clear ; delete ; exit ;;
8) clear ; autokill ; exit ;;
9) clear ; ceklim ; exit ;;
x) clear ; menu ; exit ;;
*) echo "Boh salah tekan" ; sleep 1 ; m-sshovpn ;;
esac
