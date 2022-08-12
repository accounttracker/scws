#!/bin/bash
# My Telegram : https://t.me/manternet
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# // Getting
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
echo -e "${LIGHT}Please Contact Admin !!!${NC}" 
rm -f trialvless
exit 0
fi
clear

# // Dom
source /var/lib/scvpn/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/mon/xray/domain)
else
domain=$IP
fi

none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')"
xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
user=TRIALvless-`</dev/urandom tr -dc X-Z0-9 | head -c4`
exp=1

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "SNI (bug) : " sni
read -p "Subdomain (EXP : manternet.xyz. / Press Enter If Only Using Hosts) : " sub
dom=$sub$domain

hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`

# Websocket
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json

# Grpc
sed -i '/#vless-grpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json

echo -e "### $user $exp" >> /etc/mon/xray/uservless.txt

# Link
vlesslink1="vless://${uuid}@${dom}:$xtls?path=/vless&security=tls&encryption=none&type=ws&sni=$sni#${user}"
vlesslink2="vless://${uuid}@${dom}:$none?path=/vless&encryption=none&type=ws&sni=$sni#${user}"
vlesslink3="vless://${uuid}@${dom}:${xtls}?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=$sni#$user"

systemctl restart xray.service
echo -e "${CYAN}[Info]${NC} Xray Start Successfully !"
sleep 1
clear
echo -e "================================="
echo -e "      TRIAL VLESS WS & GRPC      "
echo -e "================================="
echo -e "Remarks   : ${user}"
echo -e "IP/host   : ${MYIP}"
echo -e "SubDomain : ${dom}"
echo -e "Sni/Bug   : ${sni}"
echo -e "port tls  : $xtls"
echo -e "port none : $none"
echo -e "id        : ${uuid}"
echo -e "================================="
echo -e "VLESS WS TLS LINK"
echo -e " ${vlesslink1}"
echo -e "================================="
echo -e "VLESS WS LINK"
echo -e " ${vlesslink2}"
echo -e "================================="
echo -e "VLESS GRPC TLS LINK"
echo -e " ${vlesslink3}"
echo -e "================================="
echo -e "Created        : $hariini"
echo -e "Expired On     : $exp"
echo -e "================================="
echo -e "ScriptMod By Manternet"
