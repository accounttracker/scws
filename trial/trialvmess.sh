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
rm -f trialvmess
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

xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')
none="$(cat ~/log-install.txt | grep -w "XRAY VMESS WS NTLS" | cut -d: -f2|sed 's/ //g')"
user=TRIALvmess-`</dev/urandom tr -dc X-Z0-9 | head -c4`
exp=1

uuid=$(cat /proc/sys/kernel/random/uuid)
read -p "SNI (bug): " sni 
read -p "Subdomain (EXP : manternet.xyz. / Press Enter If Only Using Hosts) : " sub
dom=$sub$domain
MYIP=$(curl -sS ipv4.icanhazip.com)
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`

# websocket 
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json

# Grpc
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json

echo -e "### $user $exp" >> /etc/mon/xray/uservmess.txt

cat > /usr/local/etc/xray/$user-tls.json << EOF
            {
      "v": "2",
      "ps": "${user}",
      "add": "${dom}",
      "port": "${xtls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${sni}",
      "tls": "tls"
}
EOF

cat > /usr/local/etc/xray/$user-none.json << EOF
      {
      "v": "2",
      "ps": "${user}",
      "add": "${dom}",
      "port": "${none}",
      "id": "${uuid}",
      "aid": "0",
      "net": "ws",
      "path": "/vmess",
      "type": "none",
      "host": "${sni}",
      "tls": "none"
}
EOF

cat > /usr/local/etc/xray/$user-grpc.json << EOF
      {
      "v": "0",
      "ps": "${user}",
      "add": "${dom}",
      "port": "${xtls}",
      "id": "${uuid}",
      "aid": "0",
      "net": "grpc",
      "path": "vmess-grpc",
      "type": "none",
      "host": "${sni}",
      "tls": "tls"
}
EOF

vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)

vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"
vmesslink3="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-grpc.json)"

systemctl restart xray.service
service cron restart
echo -e "${CYAN}[Info]${NC} Xray Start Successfully !"
sleep 1
clear
echo -e "================================="
echo -e "      TRIAL VMESS WS & GRPC       " 
echo -e "================================="
echo -e "Remarks   : ${user}"
echo -e "IP/Host   : ${MYIP}"
echo -e "Subdomain : ${dom}"
echo -e "Sni/Bug   : ${sni}"
echo -e "port tls  : ${xtls}"
echo -e "port none : ${none}"
echo -e "id        : ${uuid}"
echo -e "alterId   : 0"
echo -e "Security  : auto"
echo -e "================================="
echo -e "VMESS WS TLS LINK"
echo -e " ${vmesslink1}"
echo -e "================================="
echo -e "VMESS WS LINK"
echo -e " ${vmesslink2}"
echo -e "================================="
echo -e "VMESS GRPC TLS LINK"
echo -e " ${vmesslink3}"
echo -e "================================="
echo -e "Created     : $hariini"
echo -e "Expired On  : $exp"
echo -e "================================="
echo -e "ScriptMod By Manternet"
