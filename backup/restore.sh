#!/bin/bash
RED='\033[0;31m' 
NC='\033[0m' 
GREEN='\033[0;32m' 
ORANGE='\033[0;33m' 
BLUE='\033[0;34m' 
PURPLE='\033[0;35m' 
CYAN='\033[0;36m' 
LIGHT='\033[0;37m'

green() { echo -e "\\033[32;1m${*}\\033[0m"; }
red() { echo -e "\\033[31;1m${*}\\033[0m"; }

# // CREATED XTLS
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //') 
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################

# // Getting
MYIP=$(wget -qO- ifconfig.me/ip); 
echo "Checking VPS" 
IZIN=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | awk '{print $4}' | grep $MYIP ) 
if [[ $MYIP = $IZIN ]]; then 
echo -e "${GREEN}Permission Accepted...${NC}" 
else 
echo -e "${RED}Permission Denied!${NC}"; 
echo -e "${LIGHT}Please Contact Admin!!!\e[37m" 
rm -f restore
exit 0
fi
clear

cd
NameUser=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | grep $MYIP | awk '{print $2}')
cekdata=$(curl -sS https://raw.githubusercontent.com/anzclan/backup_ws/main/$NameUser/$NameUser.zip | grep 404 | awk '{print $1}' | cut -d: -f1)
[[ "$cekdata" = "404" ]] && {
red "Data not found / you never backup"
exit 0
} || {
echo -e "Data found for username ${GREEN}$NameUser${NC}"
}

echo -e "[ ${CYAN}INFO${NC} ] • Restore Data..."
read -rp "Password File: " -e InputPass
echo -e "[ ${CYAN}INFO${NC} ] • Downloading data.."
mkdir /root/backup
wget -q -O /root/backup/backup.zip "https://raw.githubusercontent.com/anzclan/backup_ws/main/$NameUser/$NameUser.zip" &> /dev/null
echo -e "[ ${CYAN}INFO${NC} ] • Getting your data..."
unzip -P $InputPass /root/backup/backup.zip &> /dev/null
echo -e "[ ${CYAN}INFO${NC} ] • Starting to restore data..."
rm -f /root/backup/backup.zip &> /dev/null
sleep 1
cd /root/backup
echo -e "[ ${CYAN}INFO${NC} ] • Restoring passwd data..."
sleep 1
cp /root/backup/passwd /etc/ &> /dev/null
echo -e "[ ${CYAN}INFO${NC} ] • Restoring group data..."
sleep 1
cp /root/backup/group /etc/ &> /dev/null
echo -e "[ ${CYAN}INFO${NC} ] • Restoring shadow data..."
sleep 1
cp /root/backup/shadow /etc/ &> /dev/null
echo -e "[ ${CYAN}INFO${NC} ] • Restoring gshadow data..."
sleep 1
cp /root/backup/gshadow /etc/ &> /dev/null
#echo -e "[ ${CYAN}INFO${NC} ] • Restoring chap-secrets data..."
#sleep 1
#cp /root/backup/chap-secrets /etc/ppp/ &> /dev/null
#echo -e "[ ${CYAN}INFO${NC} ] • Restoring passwd1 data..."
#sleep 1
#cp /root/backup/passwd1 /etc/ipsec.d/passwd &> /dev/null
echo -e "[ ${CYAN}INFO${NC} ] • Restoring ss.conf data..."
sleep 1
cp /root/backup/ss.conf /etc/shadowsocks-libev/akun.conf &> /dev/null
echo -e "[ ${CYAN}INFO${NC} ] • Restoring admin data..."
sleep 1
cp -r /root/backup/manpokr /var/lib/ &> /dev/null
cp -r /root/backup/wireguard /etc/ &> /dev/null
cp -r /root/backup/.acme.sh /root/ &> /dev/null
cp -r /root/backup/bin /usr/local/bin/ &> /dev/null
cp -r /root/backup/xray /usr/local/etc/xray/ &> /dev/null
cp -r /root/backup/mon /etc/ &> /dev/null
cp -r /root/backup/shadowsocksr /usr/local/ &> /dev/null
cp -r /root/backup/html /usr/share/nginx/ &> /dev/null
cp /root/backup/crontab /etc/ &> /dev/null
cp -r /root/backup/cron.d /etc/ &> /dev/null
rm -rf /root/backup &> /dev/null
echo -e "[ ${CYAN}INFO${NC} ] • Done..."
sleep 1
rm -f /root/backup/backup.zip &> /dev/null

