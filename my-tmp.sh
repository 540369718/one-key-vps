#! /bin/bash

#===============================================================================================
#   System Required:  Ubuntu
#   Description:  Install SS for Ubuntu
#   Author: nero
#  
#===============================================================================================
clear
echo "#############################################################"
echo "# Install SS for Ubuntu"
echo "# Intro: "
echo "#"
echo "# Author:nero"
echo "#"
echo "#############################################################"
echo ""

# Install SS
function install_SS(){
    rootness
    get_my_ip
    install_lib
    pre_doc
    apps
    show_doc
    run_doc
}
# Make sure only root can run our script
function rootness(){
if [[ $EUID -ne 0 ]]; then
   echo "Error:This script must be run as root!" 1>&2
   exit 1
fi
}

# Get IP address of the server
function get_my_ip(){
    echo "Preparing, Please wait a moment..."  
    #IP=`curl -s checkip.dyndns.com | cut -d' ' -f 6  | cut -d'<' -f 1`
    #if [ -z $IP ]; then
    #    IP=`curl -s ifconfig.me/ip`
    #fi
    IP=$(ifconfig eth0|awk '/inet/ {split ($2,x,":");print x[2]}')
}

#install necessary lib
function install_lib(){
    apt-get -y update
    apt-get install vim -y
    apt-get install python-pip -y
    pip install -U setuptools
    pip install shadowsocks
    pip install speedtest-cli
}

function pre_doc(){
    echo "{
\"server\":\"${IP}\",
\"local_address\": \"127.0.0.1\",
\"local_port\":1080,
\"port_password\":{
    \"7000\":\"wt5-Kpk-bx9-cW2\",
    \"7777\":\"33K-b47-BAN-xx4\",
    \"9696\":\"zhangzhengping1\",
    \"9000\":\"password0\",
    \"9001\":\"password1\"
},
\"timeout\":600,
\"method\":\"rc4-md5\",
\"workers\":4
}" >>/etc/shadowsocks.json
}

function show_doc(){
    cat /etc/shadowsocks.json
}

function run_doc(){
    ssserver -c /etc/shadowsocks.json -d start
    echo "Test your VPS: speedtest-cli"
    echo "vim /etc/rc.local"
    echo "ssserver -c /etc/shadowsocks.json -d start"
    echo "/serverspeeder/bin/serverSpeeder.sh start"
}
function apps(){
    #wget -N --no-check-certificate https://github.com/91yun/serverspeeder/raw/master/serverspeeder.sh
    #bash serverspeeder.sh     
    wget -N --no-check-certificate -O appex.sh "https://raw.githubusercontent.com/0oVicero0/serverSpeeder_Install/master/appex.sh"
    bash appex.sh 'install'
    sleep 2s 
}

install_SS



