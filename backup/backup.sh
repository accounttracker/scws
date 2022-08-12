#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
LIGHT='\033[0;37m'
CYAN='\033[0;36m'

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
    echo -e "${NC}${LIGHT}Please Contact Admin!!"
    exit 0
fi
}
IZIN=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | awk '{print $4}' | grep $MYIP)
if [ $MYIP = $IZIN ]; then
echo -e "${NC}${GREEN}Permission Accepted...${NC}"
CEKEXPIRED
else
echo -e "${NC}${RED}Permission Denied!${NC}";
echo -e "${NC}${LIGHT}Please Contact Admin!!\e[37m"
exit 0
fi
clear

IP=$(curl -sS ipv4.icanhazip.com);
date=$(date +"%Y-%m-%d")
NameUser=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | grep $MYIP | awk '{print $2}')
echo -e "==================================\e[37m"
echo -e "         BACKUP DATA VPS       "
echo -e "=================================="
echo -e ""
echo -e "[${CYAN}INFO${NC}] Create password for database"
echo -e ""
read -rp " Enter password : " -e InputPass
echo -e ""
sleep 1
if [[ -z $InputPass ]]; then
exit 0
fi
echo -e "[ ${CYAN}INFO${NC} ] Processing... "
mkdir -p /root/backup
sleep 1

#cp -r /root/.acme.sh /root/acme &> /dev/null
#cp -r /root/acme/ /root//backup/ &> /dev/null
cp -r /root/.acme.sh /root/backup/ &> /dev/null
cp /etc/passwd /root/backup/ &> /dev/null
cp /etc/group /root/backup/ &> /dev/null
cp /etc/shadow /root/backup/ &> /dev/null
cp /etc/gshadow /root/backup/ &> /dev/null
cp -r /etc/wireguard /root/backup/wireguard &> /dev/null
cp /etc/shadowsocks-libev/akun.conf /root/backup/ss.conf &> /dev/null
cp -r /var/lib/anzclan/ /root/backup/manpokr &> /dev/null
cp -r /etc/mon /root/backup/mon &> /dev/null
cp -r /usr/local/etc /root/backup/xray &> /dev/null
cp -r /usr/local/bin /root/backup/bin &> /dev/null
cp -r /usr/local/shadowsocksr/ /root/backup/shadowsocksr &> /dev/null
cp -r /home/vps/public_html /root/backup/public_html &> /dev/null
cp -r /usr/share/nginx/html /root/backup/html
cp -r /etc/cron.d /root/backup/cron.d &> /dev/null
cp /etc/crontab /root/backup/crontab &> /dev/null
cd /root
zip -rP $InputPass $NameUser.zip backup > /dev/null 2>&1

##############++++++++++++++++++++++++#############
LLatest=`date`
Get_Data () {
git clone https://github.com/anzclan/backup_ws.git /root/user-backup/ &> /dev/null
}

Mkdir_Data () {
mkdir -p /root/user-backup/$NameUser
}

Input_Data_Append () {
if [ ! -f "/root/user-backup/$NameUser/$NameUser-last-backup" ]; then
touch /root/user-backup/$NameUser/$NameUser-last-backup
fi
echo -e "User         : $NameUser
last-backup : $LLatest
" >> /root/user-backup/$NameUser/$NameUser-last-backup
mv /root/$NameUser.zip /root/user-backup/$NameUser/
}

Save_And_Exit () {
    cd /root/user-backup
    git config --global user.email "Manpokr7@gmail.com" &> /dev/null
    git config --global user.name "Manpokr7" &> /dev/null
    rm -rf .git &> /dev/null
    git init &> /dev/null
    git add . &> /dev/null
    git commit -m m &> /dev/null
    git branch -M main &> /dev/null
    git remote add origin https://github.com/anzclan/backup_ws.git
    git push -f https://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@github.com/anzclan/backup_ws.git &> /dev/null
}

if [ ! -d "/root/user-backup/" ]; then
sleep 1
echo -e "[ ${CYAN}INFO${NC} ] Getting database... "
Get_Data
Mkdir_Data
sleep 1
echo -e "[ ${CYAN}INFO${NC} ] Getting info server... "
Input_Data_Append
sleep 1
echo -e "[ ${CYAN}INFO${NC} ] Processing updating server...... "
Save_And_Exit
fi
link="https://raw.githubusercontent.com/anzclan/backup_ws/main/$NameUser/$NameUser.zip"
sleep 1
echo -e "[ ${CYAN}INFO${NC} ] Backup done "
sleep 1
echo -e "[ ${CYAN}INFO${NC} ] Generete Link Backup "
echo
sleep 2
rm /root/linkbackup &> /dev/null
echo -e "$link" >> /root/linkbackup
hostname=$(hostname)
echo -e "The following is a link to your vps data backup file.
====================================
Hostname      = $hostname
IP VPS        = $IP
Link Backup   = $link
====================================
       save the link pliss!
  Thank You For Using Our Services"
echo -e ""
echo -e "Link location /root/linkbackup"
rm -rf /root/backup &> /dev/null
rm -rf /root/user-backup &> /dev/null
rm -f /root/$NameUser.zip &> /dev/null
echo -e "==================================="
