#! /bin/bash

#===============================================================================================
#   System Required:  Debian/Ubuntu
#   Description:  Install SS-libev for Debian
#   Author: Nero
#  
#===============================================================================================
clear
echo "#############################################################"
echo "# Install SS-libev for Ubuntu"
echo "#"
echo "# Author: Nero"
echo "#"
echo "#############################################################"
echo ""

# Install SS
function install_SS(){
	check_sys
    rootness
    get_my_ip
    install_env
	install_libev
    install_lotServer
	install_status_client
    show_doc
}

# Make sure only root can run our script
function rootness(){
if [[ $EUID -ne 0 ]]; then
   echo "Error:This script must be run as root!" 1>&2
   exit 1
fi
}

# Check release
check_sys(){
	if [[ -f /etc/redhat-release ]]; then
		release="centos"
	elif cat /etc/issue | grep -q -E -i "debian"; then
		release="debian"
	elif cat /etc/issue | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /etc/issue | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
	elif cat /proc/version | grep -q -E -i "debian"; then
		release="debian"
	elif cat /proc/version | grep -q -E -i "ubuntu"; then
		release="ubuntu"
	elif cat /proc/version | grep -q -E -i "centos|red hat|redhat"; then
		release="centos"
    fi
	bit=`uname -m`
	if [[ ${release} = "debian" ]]; then
		version=`cat /etc/debian_version`
		apt install -y sudo		
	fi
}

# Get IP address of the server
function get_my_ip(){
    echo "Preparing, Please wait a moment..."      
    IP=$(ifconfig eth0|awk '/inet/ {split ($2,x,":");print x[2]}')
}

# Install necessary lib
function install_env(){
	apt-get install -y python-dev libffi-dev python-setuptools curl vim wget
	curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && python get-pip.py && rm get-pip.py
	pip install paramiko psutil
}

function install_libev(){
	if [[ ${release} = "debian" ]]; then
		if [[ $version > "8" && $version < "9" ]];then
			install_libev_debian_Jessie
		elif [[ $version > "9" && $version < "10" ]];then
			install_libev_debian_Stretch
		fi		
	elif [[ ${release} = "ubuntu" ]]; then
		install_libev_ubuntu
	fi
	
	wget -O /etc/init.d/shadowsocks-manager https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocks-manager && chmod 755 /etc/init.d/shadowsocks-manager
	mkdir /etc/shadowsocks-manager
	sample_config
	/etc/init.d/shadowsocks-manager start		
}
function install_libev_debian_Jessie(){
	sudo sh -c 'printf "deb http://deb.debian.org/debian jessie-backports main\n" > /etc/apt/sources.list.d/jessie-backports.list'
	sudo sh -c 'printf "deb http://deb.debian.org/debian jessie-backports-sloppy main" >> /etc/apt/sources.list.d/jessie-backports.list'
	sudo apt update
	sudo apt -t jessie-backports-sloppy install shadowsocks-libev
}
function install_libev_debian_Stretch(){
	sudo sh -c 'printf "deb http://deb.debian.org/debian stretch-backports main" > /etc/apt/sources.list.d/stretch-backports.list'
	sudo apt update
	sudo apt -t stretch-backports install shadowsocks-libev
}
function install_libev_ubuntu(){
	sudo apt-get install software-properties-common -y
	sudo add-apt-repository ppa:max-c-lv/shadowsocks-libev -y
	sudo apt-get update
	sudo apt install shadowsocks-libev
}
function sample_config(){
    echo "{
\"server\":\"${IP}\",
\"port_password\":{
    \"9001\":\"password1\",
    \"9002\":\"password2\",
    \"9003\":\"password3\"    
},
\"timeout\":600,
\"fast_open\":true,
\"user\":\"nobody\",
\"method\":\"rc4-md5\",
\"nameserver\":\"8.8.8.8\",
\"mode\":\"tcp_and_udp\"
}" >>/etc/shadowsocks-manager/config.json
}

function install_lotServer(){
	wget -N --no-check-certificate -O appex.sh "https://raw.githubusercontent.com/0oVicero0/serverSpeeder_Install/master/appex.sh" && bash appex.sh 'install'		
}

function install_status_client(){
	wget -N --no-check-certificate https://raw.githubusercontent.com/540369718/ServerStatus/master/shell/status_client.sh && chmod +x status_client.sh && bash status_client.sh
}

function show_doc(){
    echo "Test your VPS: speedtest-cli"
	echo "vim /usr/local/ServerStatus/status-client.py  //修改SERVER地址，username帐号， password密码"
	echo "vim /usr/local/ServerStatus/customMsg.txt 添加显示信息" 
	echo "/etc/shadowsocks-manager/config.json 配置文件"
}

install_SS






