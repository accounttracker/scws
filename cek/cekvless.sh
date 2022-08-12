#!/bin/bash
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'

############
dateFromServer=$(curl -v --insecure --silent https://google.com/ 2>&1 | grep Date | sed -e 's/< Date: //')
biji=`date +"%Y-%m-%d" -d "$dateFromServer"`
############

clear
MYIP=$(wget -qO- ifconfig.me/ip);
echo -n > /tmp/other.txt
data=($(cat /etc/mon/xray/usertrojan.txt | awk '{print $2}'));
#data=( `cat /etc/mon/xray/uservless.txt | grep '^###' | cut -d ' ' -f 2`);
echo "------------------------------------";
echo "-------=[ Vless User Login ]=-------";
echo "------------------------------------";
for akun in "${data[@]}"
do
if [[ -z "$akun" ]]; then
akun="tidakada"
fi
echo -n > /tmp/ipvless.txt
data2=( `netstat -anp | grep ESTABLISHED | grep tcp | grep nginx | awk '{print $5}' | cut -d: -f1 | sort | uniq`);
for ip in "${data2[@]}"
do
jum=$(cat /var/log/xray/access.log | grep -w $akun | awk '{print $3}' | cut -d: -f1 | grep -w $ip | sort | uniq)
if [[ "$jum" = "$ip" ]]; then
echo "$jum" >> /tmp/ipvless.txt
else
echo "$ip" >> /tmp/other.txt
fi
jum2=$(cat /tmp/ipvless.txt)
sed -i "/$jum2/d" /tmp/other.txt > /dev/null 2>&1
done
jum=$(cat /tmp/ipvless.txt)
if [[ -z "$jum" ]]; then
echo > /dev/null
else
jum2=$(cat /tmp/ipvless.txt | nl)
echo "user : $akun";
echo "$jum2";
echo "-------------------------------"
fi
rm -rf /tmp/ipvmess.txt
done
oth=$(cat /tmp/other.txt | sort | uniq | nl)
#echo "other";
#echo "$oth";
#echo "-------------------------------"
echo "ScriptMod By Manternet"
rm -rf /tmp/other.txt
read -p "Press Enter For Back To XRay Menu / CTRL+C To Cancel : "
menu-xray
