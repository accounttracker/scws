#!/bin/bash
RED='\033[0;31m'                                                                                          
GREEN='\033[0;32m'                                                                                                                                                                                 
NC='\033[0;37m'

# // Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"

#, // Autodel vmess
data=( `cat /etc/mon/xray/uservmess.txt | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/etc/mon/xray/uservmess.txt" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^### $user $exp/,/^},{/d"  /usr/local/etc/xray/config.json
sed -i "/^### $user $exp/,/^},{/d" /etc/mon/xray/uservmess.txt
rm -f /usr/local/etc/xray/$user-tls.json 
rm -f /usr/local/etc/xray/$user-grpc.json 
rm -f /usr/local/etc/xray/$user-none.json 
fi
done

#, // Autodel vless
data=( `cat /etc/mon/xray/uservless.txt | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/etc/mon/xray/uservless.txt" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^### $user $exp/,/^},{/d"  /usr/local/etc/xray/config.json
sed -i "/^### $user $exp/,/^},{/d" /etc/mon/xray/uservless.txt
fi
done

#, // Autodel Trojan
data=( `cat /etc/mon/xray/usertrojan.txt | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/etc/mon/xray/uservmess.txt" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^### $user $exp/,/^},{/d"  /usr/local/etc/xray/config.json
sed -i "/^### $user $exp/,/^},{/d" /etc/mon/xray/uservmess.txt
fi
done

#, // Autodel ss
data=( `cat /etc/mon/xray/userss.txt | grep '^###' | cut -d ' ' -f 2`);
now=`date +"%Y-%m-%d"`
for user in "${data[@]}"
do
exp=$(grep -w "^### $user" "/etc/mon/xray/userss.txt" | cut -d ' ' -f 3)
d1=$(date -d "$exp" +%s)
d2=$(date -d "$now" +%s)
exp2=$(( (d1 - d2) / 86400 ))
if [[ "$exp2" = "0" ]]; then
sed -i "/^### $user $exp/,/^},{/d"  /usr/local/etc/xray/config.json
sed -i "/^### $user $exp/,/^},{/d" /etc/mon/xray/userss.txt
fi
done
systemctl restart xray.service
systemctl restart cron
