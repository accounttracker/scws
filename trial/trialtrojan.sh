#!/bin/bash
RED='\033[0;31m' 
NC='\033[0m' 
GREEN='\033[0;32m' 
ORANGE='\033[0;33m' 
BLUE='\033[0;34m' 
PURPLE='\033[0;35m' 
CYAN='\033[0;36m' 
LIGHT='\033[0;37m'

# // CREATED TROJAN
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
rm -f trialtrojan
exit 0
fi
clear

# // Trial Trojan
source /var/lib/scvpn/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/mon/xray/domain)
else                                                                      
domain=$IP                                                                
fi

xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')"

user=TRIALtrojan-`</dev/urandom tr -dc X-Z0-9 | head -c4`
exp=1

read -p "SNI (bug) : " sni
read -p "Subdomain (EXP : manternet.xyz. / Press Enter If Only Using Hosts) : " sub
dom=$sub$domain
uuid=$(cat /proc/sys/kernel/random/uuid)
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`

# Websocket
sed -i '/#trojanws$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json

# // Grpc
sed -i '/#trojangrpc$/a\### '"$user $exp"'\
},{"password": "'""$uuid""'","email": "'""$user""'"' /usr/local/etc/xray/config.json

echo -e "### $user $exp" >> /etc/mon/xray/usertrojan.txt

# // Link
trojanlink="trojan://${uuid}@${dom}:$xtls?type=ws&security=tls&path=/trojan-ws#${user}"
trojanlink0="trojan://${uuid}@${dom}:$none?host=${dom}&security=none&type=ws&path=/trojan-ws#${user}"
trojanlink1="trojan://${uuid}@$dom:${xtls}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${sni}#${user}"

systemctl restart xray.service
service cron restart
echo -e "${CYAN}[Info]${NC} Xray Start Successfully !"
sleep 1

clear
echo -e "================================="
echo -e "      TRIAL TROJAN WS & GRPC     " 
echo -e "================================="
echo -e "Remarks   : ${user}"
echo -e "IP/Host   : ${IP}"
echo -e "Subdomain : ${dom}"
echo -e "Sni/Bug   : ${sni}"
echo -e "Port tls  : ${xtls}"
echo -e "Port none : ${none}"
echo -e "Password  : ${uuid}"
echo -e "================================="
echo -e "TROJAN WS TLS LINK"
echo -e " ${trojanlink}"
echo -e "================================="
echo -e "TROJAN WS LINK"
echo -e " ${trojanlink0}"
echo -e "================================="
echo -e "TROJAN GRPC TLS LINK"
echo -e " ${trojanlink1}"
echo -e "================================="
echo -e "Created : $hariini"
echo -e "Expired : $exp"
echo -e "================================="
echo -e "ScriptMod By Manternet"
