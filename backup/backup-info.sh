#!/bin/bash
clear
RED='\033[0;31m'                                                                                          
GREEN='\033[0;32m'                                                                                        
ORANGE='\033[0;33m'
BLUE='\033[0;34m'                                                                                         
PURPLE='\033[0;35m'
CYAN='\033[0;36m'                                                                                         
NC='\033[0;37m'
LIGHT='\033[0;37m'

green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

# // Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
CEKEXPIRED () {
    today=$(date -d +1day +%Y-%m-%d)
    Exp1=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | grep $MYIP | awk '{print $3}')
    if [[ $today < $Exp1 ]]; then
    echo -e "${NC}${GREEN}Permission Accepted...${NC}"
    else
    echo -e "${NC}${RED}Permission Denied!${NC}";
    echo -e "${NC}${LIGHT}Please Contact Admin!!${NC}"
    exit 0
fi
}
IZIN=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | awk '{print $4}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
CEKEXPIRED
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Please Contact Admin!!${NC}"
exit 0
fi
clear

cd
NameUser=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | grep $MYIP | awk '{print $2}')
cekdata=$(curl -sS https://raw.githubusercontent.com/anzclan/backup_ws/main/$NameUser/$NameUser-last-backup | grep 404 | awk '{print $1}' | cut -d: -f1)
echo -e "=================================="
echo -e "         BACKUP HISTORY       "
echo -e "=================================="
echo -e ""
[[ "$cekdata" = "404" ]] && {
red "Data not found / you never backup"
echo -e ""
echo -e "=================================="
echo
} || {
echo -e "Data found for username ${GREEN}$NameUser${NC}"
} 
data=$(curl -sS https://raw.githubusercontent.com/anzclan/backup_ws/main/$NameUser/$NameUser-last-backup)
echo
echo -e "[ ${CYAN}INFO${NC} ] • Getting info database backup history..."
sleep 2
echo
echo -e "$data"
echo
echo -e "=================================="
echo
