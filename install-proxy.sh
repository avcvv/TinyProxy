#!/bin/sh

if [ -z "$serverip" ]; then
        read -p "Please enter IPv4 : " serverip
    fi

if [ -z "$outport" ]; then
        read -p "Please enter outgoing port for ipv4 : " outport
    fi


echo "Now proxy will be available here:" $serverip:$outport

echo
echo '                                  Start install proxies software'
echo -e "\n\n"

yum -y install epel-release nano tinyproxy
sed -i "/Port 8888/c\Port $outport" /etc/tinyproxy/tinyproxy.conf
sed -i '/#XTinyproxy Yes/c\XTinyproxy No' /etc/tinyproxy/tinyproxy.conf
sed -i '/ViaProxyName "tinyproxy"/c\#ViaProxyName "tinyproxy" ' /etc/tinyproxy/tinyproxy.conf
sed -i '/#DisableViaHeader Yes/c\DisableViaHeader Yes' /etc/tinyproxy/tinyproxy.conf
sed -i "/Allow 127.0.0.1/c\Allow 127.0.0.1\nAllow $serverip" /etc/tinyproxy/tinyproxy.conf
service tinyproxy restart
chkconfig tinyproxy on

echo "Now you can use proxy $serverip:$outport"
