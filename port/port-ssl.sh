#!/bin/bash
RED='\033[0;31m'                                                                                          
GREEN='\033[0;32m'                                                                                        
ORANGE='\033[0;33m'
BLUE='\033[0;34m'                                                                                         
PURPLE='\033[0;35m'
CYAN='\033[0;36m'                                                                                         
NC='\033[0;37m'
LIGHT='\033[0;37m'

# // Getting
MYIP=$(wget -qO- ipinfo.io/ip);
echo "Checking VPS"

clear
ssl="$(cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $1}')"
ssl2="$(cat /etc/stunnel/stunnel.conf | grep -i accept | head -n 2 | cut -d= -f2 | sed 's/ //g' | tr '\n' ' ' | awk '{print $2}')"
echo -e "======================================"
echo -e "         Stunnel Port Changer"
echo -e ""
echo -e "     [1]  Change Port \033[31m$ssl\e[37m"
echo -e "     [2]  Change Port \033[31m$ssl2\e[37m"
echo -e "     [x]  \033[31mExit\e[37m"
echo -e ""
echo -e "======================================"
echo -e ""
read -p " Select From Options [1-2 or x] :  " prot
echo -e ""
case $prot in
1)
read -p "New Port Stunnel4: " stl
if [ -z $stl ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $stl)
if [[ -z $cek ]]; then
sed -i "s/$ssl/$stl/g" /etc/stunnel/stunnel.conf
sed -i "s/   - Stunnel4                : $ssl, $ssl2/   - Stunnel4                : $stl, $ssl2/g" /root/log-install.txt
/etc/init.d/stunnel4 restart > /dev/null
echo -e "\e[032;1mPort $stl modified successfully\e[0m"
else
echo "Port $stl is used"
fi
;;
2)
read -p "New Port Stunnel4: " stl
if [ -z $stl ]; then
echo "Please Input Port"
exit 0
fi
cek=$(netstat -nutlp | grep -w $stl)
if [[ -z $cek ]]; then
sed -i "s/$ssl2/$stl/g" /etc/stunnel/stunnel.conf
sed -i "s/   - Stunnel4                : $ssl, $ssl2/   - Stunnel4                : $ssl, $stl/g" /root/log-install.txt
/etc/init.d/stunnel4 restart > /dev/null
echo -e "\e[032;1mPort $stl modified successfully\e[0m"
else
echo "Port $stl is used"
fi
;;
x)
exit
menu
;;
*)
echo "Boh salah tekan" ; sleep 1 ; port-ssl ;;
esac
