#!/bin/bash
# // CF
RED='\e[1;31m'
GREEN='\e[0;32m'
NC='\e[0m'

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
echo -e "${LIGHT}Please Contact Admin!!"
rm -f cf.sh
exit 0
fi
clear

IP=$(wget -qO- ipinfo.io/ip);
date=$(date +"%Y-%m-%d");
Green_font_prefix="\033[32m" && Red_font_prefix="\033[31m" && Green_background_prefix="\033[42;37m" && Red_background_prefix="\033[41;37m" && Font_color_suffix="\033[0m"
Info="${Green_font_prefix}[ON]${Font_color_suffix}"
Error="${Red_font_prefix}[OFF]${Font_color_suffix}"
SUB_DOMAIN=$(cat /etc/mon/xray/domain)
cek=$(grep -c -E "^# $SUB_DOMAIN" /etc/mon/xray/dns.txt)

# // Status Cf
if [[ "$cek" = "1" ]]; then
sts="${Info}"
else
sts="${Error}"
fi

function start() {
rm -f /etc/mon/xray/dns.txt
DOMAIN=manternet.online
SUB_DOMAIN=$(cat /etc/mon/xray/domain)
CF_ID=anjang614@gmail.com
CF_KEY=e943ae250caa5917be31337288655b3d9794f
set -euo pipefail
IP=$(wget -qO- ipinfo.io/ip);

echo " [Info] TURN ON DNS for ${SUB_DOMAIN}..."
echo " Please Wait"
sleep 1
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"proxied":true}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":true}')
WILD_DOMAIN="*.$SUB_DOMAIN"
set -euo pipefail
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${WILD_DOMAIN}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"proxied":true}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${WILD_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":true}')

echo "# $SUB_DOMAIN" >> /etc/mon/xray/dns.txt
echo " UPDATE SUCSES"
sleep 1
read -n 1 -s -r -p "Press any key to back on menu"
m-system
exit 0
}

function stop() {
echo " Please Wait"
sleep 1
DOMAIN=manternet.online
SUB_DOMAIN=$(cat /etc/mon/xray/domain)
CF_ID=anjang614@gmail.com
CF_KEY=e943ae250caa5917be31337288655b3d9794f
set -euo pipefail
IP=$(wget -qO- ipinfo.io/ip);

echo " [Info] TURN OF DNS for ${SUB_DOMAIN}..."
echo " Please Wait"
sleep 1
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${SUB_DOMAIN}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${SUB_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
WILD_DOMAIN="*.$SUB_DOMAIN"
set -euo pipefail
ZONE=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones?name=${DOMAIN}&status=active" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
RECORD=$(curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records?name=${WILD_DOMAIN}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" | jq -r .result[0].id)
if [[ "${#RECORD}" -le 10 ]]; then
RECORD=$(curl -sLX POST "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"proxied":false}' | jq -r .result.id)
fi
RESULT=$(curl -sLX PUT "https://api.cloudflare.com/client/v4/zones/${ZONE}/dns_records/${RECORD}" \
-H "X-Auth-Email: ${CF_ID}" \
-H "X-Auth-Key: ${CF_KEY}" \
-H "Content-Type: application/json" \
--data '{"type":"A","name":"'${WILD_DOMAIN}'","content":"'${IP}'","ttl":120,"proxied":false}')
rm -f /etc/mon/xray/dns.txt 
echo " UPDATE SUCSES"
sleep 1
read -n 1 -s -r -p "Press any key to back on system menu"
m-system
exit 0
}

clear
echo -e "==============================\e[37m"
echo -e "   Menu Dns Cloudflare $sts"
echo -e "==============================\e[37m"
echo -e "  [•1] On  Dns CloudFlare"
echo -e "  [•2] Off Dns CloudFlare"
echo -e ""
echo -e "  [•x] ${RED}Back To Menu${NC}"
echo -e ""
echo -e "==============================\e[37m"
read -rp " Please Enter The Correct Number : " -e num
if [[ "$num" = "1" ]]; then
start
elif [[ "$num" = "2" ]]; then
stop
elif [[ "$num" = "x" ]]; then
menu
else
clear
echo " Boh Salah Number"
menu-cf
fi
