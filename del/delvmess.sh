#!/bin/bash
# My Telegram : https://t.me/Manternet
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

# ==========================================
# Getting
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
#########################
MYIP=$(curl -sS ipv4.icanhazip.com)
clear
NUMBER_OF_CLIENTS=$(grep -c -E "^### " "/etc/mon/xray/uservmess.txt")
	if [[ ${NUMBER_OF_CLIENTS} == '0' ]]; then
		echo ""
		echo "You have no existing clients!"
		exit 1
	fi

	echo ""
	echo " Client Vmess remove"
	echo " Press CTRL+C to return"
	echo " ==============================="
	echo "     No  Expired   User"
	grep -E "^### " "/etc/mon/xray/uservmess.txt" | cut -d ' ' -f 2-3 | nl -s ') '
	until [[ ${CLIENT_NUMBER} -ge 1 && ${CLIENT_NUMBER} -le ${NUMBER_OF_CLIENTS} ]]; do
		if [[ ${CLIENT_NUMBER} == '1' ]]; then
	echo " ==============================="
	read -rp "Select one client [1]: " CLIENT_NUMBER
	else
	echo " ==============================="
	read -rp "Select one client [1-${NUMBER_OF_CLIENTS}]: " CLIENT_NUMBER
	fi
	done
user=$(grep -E "^### " "/etc/mon/xray/uservmess.txt" | cut -d ' ' -f 2 | sed -n "${CLIENT_NUMBER}"p)
exp=$(grep -E "^### " "/etc/mon/xray/uservmess.txt" | cut -d ' ' -f 3 | sed -n "${CLIENT_NUMBER}"p)
sed -i "/^### $user $exp/,/^},{/d" /etc/mon/xray/uservmess.txt
sed -i "/^### $user $exp/,/^},{/d" /usr/local/etc/xray/config.json
systemctl restart xray.service
service cron restart

clear
echo ""
echo "================================"
echo "    Vmess Account Deleted  "
echo "================================"
echo " Username  : $user"
echo " Expired   : $exp"
echo "================================"
echo " ScriptMod By Manternet"
