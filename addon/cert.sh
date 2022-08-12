#!/bin/bash
# Cert
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'

# // Date
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`

# // Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
IZIN=$(curl -sS https://raw.githubusercontent.com/anzclan/permission/main/access | awk '{print $4}' | grep $MYIP )
if [[ $MYIP = $IZIN ]]; then
echo -e "${GREEN}Permission Accepted...${NC}"
else
echo -e "${RED}Permission Denied!${NC}";
echo -e "${LIGHT}Please Contact Admin!!${NC}"
rm -f cert.sh
exit 0
fi
clear

# // INSTALL ACME
domain=$(cat /etc/mon/xray/domain)

systemctl stop nginx 
systemctl stop xray 
systemctl stop xray.service

/root/.acme.sh/acme.sh  --upgrade  --auto-upgrade
/root/.acme.sh/acme.sh --set-default-ca --server letsencrypt
/root/.acme.sh/acme.sh --issue -d ${domain} --standalone -k ec-256 --server letsencrypt --force >> /etc/mon/tls/$domain.log
~/.acme.sh/acme.sh --installcert -d ${domain} --fullchainpath /etc/mon/tls/xray.crt --keypath /etc/mon/tls/xray.key --ecc
cat /etc/mon/tls/$domain.log

systemctl daemon-reload 
systemctl restart nginx
systemctl restart xray
systemctl restart xray.service

sleep 1
clear 
rm -f /root/cert.sh 
rm -f cert.sh
