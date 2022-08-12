#!/bin/bash
#Port Changer Xray

# Color
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0;37m'
LIGHT='\033[0;37m'

# Validate Your IP Address
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"
clear

# // Port Xray
xtls="$(cat ~/log-install.txt | grep -w "XRAY VLESS WS TLS" | cut -d: -f2|sed 's/ //g')"
echo -e "======================================"
echo -e "          XRay Port Changer"
echo -e ""
echo -e "   [1]  Change Port XRay All ${RED}$xtls${NC}"
echo -e "   [x]  ${RED}Exit${NC}"
echo -e ""
echo -e "======================================"
echo -e ""
read -p " silahkan masukkan nomor [1 or x] :  "  port                                                                                                                                                                                                 
echo -e ""
case $port in
1)
read -p "Type New Port For Xray : " xtls1
if [ -z $xtls1 ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $xtls1)
if [[ -z $cek ]]; then
sed -i "s/$xtls/$xtls1/g" /etc/nginx/conf.d/alone.conf
sed -i "s/   - XRAY VLESS WS TLS  : $xtls/   - XRAY VLESS WS TLS  : $xtls1/g" /root/log-install.txt
sed -i "s/   - XRAY VMESS WS TLS  : $xtls/   - XRAY VMESS WS TLS  : $xtls1/g" /root/log-install.txt
sed -i "s/   - XRAY TROJAN WS TLS : $xtls/   - XRAY TROJAN WS TLS : $xtls1/g" /root/log-install.tx
sed -i "s/   - XRAY SS WS TLS     : $xtls/   - XRAY SS WS TLS     : $xtls1/g" /root/log-install.tx
sed -i "s/   - XRAY VLESS GRPC    : $xtls/   - XRAY VLESS GRPC    : $xtls1/g" /root/log-install.txt
sed -i "s/   - XRAY VMESS GRPC    : $xtls/   - XRAY VMESS GRPC    : $xtls1/g" /root/log-install.txt
sed -i "s/   - XRAY TROJAN GRPC   : $xtls/   - XRAY TROJAN GRPC   : $xtls1/g" /root/log-install.txt
sed -i "s/   - XRAY SS GRPC       : $xtls/   - XRAY SS GRPC       : $xtls1/g" /root/log-install.txt
iptables -D INPUT -m state --state NEW -m tcp -p tcp --dport $xtls -j ACCEPT
iptables -D INPUT -m state --state NEW -m udp -p udp --dport $xtls -j ACCEPT
iptables -I INPUT -m state --state NEW -m tcp -p tcp --dport $xtls1 -j ACCEPT
iptables -I INPUT -m state --state NEW -m udp -p udp --dport $xtls1 -j ACCEPT
iptables-save > /etc/iptables.up.rules
iptables-restore -t < /etc/iptables.up.rules
netfilter-persistent save > /dev/null
netfilter-persistent reload > /dev/null
systemctl restart xray > /dev/null

echo -e "${CYAN}[Info]${NC} xray Start Successfully !"
clear
echo -e "Succesfully Changed XRay Port To ${RED}$xtls1${NC}"
else
echo -e "${RED}Error !!! ${NC}Port $xtls1 Is Already Used"
fi
;;
x)
exit
;;
*)
echo "Boh salah tekan" ; sleep 1 ; port-xray ;;
esac
