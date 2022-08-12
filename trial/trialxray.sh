#!/bin/bash
# My Telegram : https://t.me/Manternet
RED='\033[0;31m' 
NC='\033[0m' 
GREEN='\033[0;32m' 
ORANGE='\033[0;33m' 
BLUE='\033[0;34m' 
PURPLE='\033[0;35m' 
CYAN='\033[0;36m' 
LIGHT='\033[0;37m'

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
rm -f trialxray
exit 0
fi
clear

# // Add
source /var/lib/scvpn/ipvps.conf
if [[ "$IP" = "" ]]; then
domain=$(cat /etc/mon/xray/domain)
else
domain=$IP
fi
domain=$(cat /etc/mon/xray/domain)

none="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS NTLS" | cut -d: -f2|sed 's/ //g')"
xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"

user=TRIALxray-`</dev/urandom tr -dc X-Z0-9 | head -c4`
exp=1

read -p "SNI (bug) : " sni
read -p "Subdomain (EXP : manternet.xyz. / Press Enter If Only Using Hosts) : " sub
dom=$sub$domain

uuid=$(cat /proc/sys/kernel/random/uuid)
uuid1=$(cat /proc/sys/kernel/random/uuid)
uuid2=$(cat /proc/sys/kernel/random/uuid)
hariini=`date -d "0 days" +"%Y-%m-%d"`
exp=`date -d "$masaaktif days" +"%Y-%m-%d"`

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

# // Trojan
sed -i '/#trojanws$/a\### '"$user $exp"'\
},{"password": "'""$uuid2""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#trojangrpc$/a\### '"$user $exp"'\
},{"password": "'""$uuid2""'","email": "'""$user""'"' /usr/local/etc/xray/config.json

# // Vless
sed -i '/#vless$/a\### '"$user $exp"'\
},{"id": "'""$uuid1""'","email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vlessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid1""'","email": "'""$user""'"' /usr/local/etc/xray/config.json

# // Vmess
sed -i '/#vmess$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json
sed -i '/#vmessgrpc$/a\### '"$user $exp"'\
},{"id": "'""$uuid""'","alterId": '"0"',"email": "'""$user""'"' /usr/local/etc/xray/config.json

echo -e "### $user $exp" >> /etc/mon/xray/uservless.txt
echo -e "### $user $exp" >> /etc/mon/xray/uservmess.txt
echo -e "### $user $exp" >> /etc/mon/xray/usertrojan.txt

vmess_base641=$( base64 -w 0 <<< $vmess_json1)
vmess_base642=$( base64 -w 0 <<< $vmess_json2)
vmess_base643=$( base64 -w 0 <<< $vmess_json3)

vmesslink1="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-tls.json)"
vmesslink2="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-none.json)"
vmesslink3="vmess://$(base64 -w 0 /usr/local/etc/xray/$user-grpc.json)"

# // Link
trojanlink="trojan://${uuid2}@${dom}:$xtls?type=ws&security=tls&path=/trojan-ws#${user}"
trojanlink0="trojan://${uuid2}@${dom}:$none?host=${dom}&security=none&type=ws&path=/trojan-ws#${user}"
trojanlink1="trojan://${uuid2}@$dom:${xtls}?mode=gun&security=tls&type=grpc&serviceName=trojan-grpc&sni=${sni}#${user}"

vlesslink1="vless://${uuid1}@${dom}:$xtls?path=/vless&security=tls&encryption=none&type=ws&sni=$sni#${user}"
vlesslink2="vless://${uuid1}@${dom}:$none?path=/vless&encryption=none&type=ws&sni=$sni#${user}"
vlesslink3="vless://${uuid1}@${dom}:${xtls}?mode=gun&security=tls&encryption=none&type=grpc&serviceName=vless-grpc&sni=$sni#$user"

systemctl restart xray.service
service cron restart
echo -e "${CYAN}[Info]${NC} Xray Start Successfully !"
sleep 1

clear
echo -e "================================="
echo -e "      TRIAL XRAY WS & GRPC       " 
echo -e "================================="
echo -e "Remarks   : ${user}"
echo -e "IP/Host   : ${IP}"
echo -e "Subdomain : $dom"
echo -e "Sni/Bug   : $sni"
echo -e "Port tls  : ${xtls}"
echo -e "Port none : ${none}"
echo -e "Key       : ${uuid}"
echo -e "================================="
echo -e "VLESS WS TLS LINK"
echo -e " ${vlesslink1}"
echo -e "================================="
echo -e "VLESS WS LINK"
echo -e " ${vlesslink2}"
echo -e "================================="
echo -e "VLESS GRPC TLS LINK"
echo -e " ${vlesslink3}"
echo -e ""
echo -e "================================="
echo -e "VMESS WS TLS LINK"
echo -e " ${vmesslink1}"
echo -e "================================="
echo -e "VMESS WS LINK"
echo -e " ${vmesslink2}"
echo -e "================================="
echo -e "VMESS GRPC TLS LINK"
echo -e " ${vmesslink3}"
echo -e ""
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
echo -e "Created   : $hariini"
echo -e "Expired   : $exp"
echo -e "================================="
echo -e "ScriptMod By Manternet"

