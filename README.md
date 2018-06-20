# one-key-vps
## 自用一键配置VPS代码
0. 更换内核
1. 安装SS

## 准备活动：更换内核
1. 安装新的内核文件
```shell
sudo apt-get install linux-image-4.2.0-35-generic (14.04)
sudo apt-get install linux-image-4.4.0-47-generic (16.04)
sudo dpkg --get-selections | grep linux-image
```
2. 删除其他内核，并检查一下
```shell
sudo apt-get remove linux-image-XXXXXX-generic
sudo dpkg --get-selections | grep linux-image
```
3. 重建Grub引导文件，重启并固定内核文件
```shell
sudo update-grub
sudo reboot now
sudo apt-mark hold linux-image
uname -r
```

## 使用方法
for Debian 8 / Ubuntu
```shell
wget https://raw.githubusercontent.com/540369718/one-key-vps/master/libev.sh && chmod +x libev.sh && sudo bash libev.sh
```

### ss-libev命令：  
service shadowsocks-manager start|stop|restart|status   
/etc/init.d/shadowsocks-manager start|stop|restart|status  
###### 配置文件  
/etc/shadowsocks-manager/config.json  
###### 日志文件  
/var/log/syslog  

### LotServer命令：  
service serverSpeeder start|stop|restart|status|renewLic  
/appex/bin/serverSpeeder.sh start|stop|restart|status|renewLic   
###### 配置文件  
/appex/etc/config  

### 云监控客户端：  
service status-client start|stop|restart|status   
/etc/init.d/status-client start|stop|restart|status  
###### 配置文件  
/usr/local/ServerStatus/status-client.py  

可另外安装[服务端](https://github.com/540369718/ServerStatus)    
``` bash
wget -N --no-check-certificate https://raw.githubusercontent.com/540369718/ServerStatus/master/shell/status_server.sh && chmod +x status_server.sh && bash status_server.sh 
```
### 云监控服务端：  
service status-client start|stop|restart|status  
/etc/init.d/status-server start|stop|restart|status  
###### 配置文件  
/usr/local/ServerStatus/server/config.json 

### Caddy： 
service caddy start|stop|restart|status  
/etc/init.d/caddy start|stop|restart|status  
###### 配置文件  
/usr/local/caddy/Caddyfile  

## 参考： 
[shadowsocks-libev-manager](https://teddysun.com/532.html)  
[shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev)  
[lotServer](https://moeclub.org/2017/03/08/14/)  
[支持内核列表](https://raw.githubusercontent.com/0oVicero0/serverSpeeder_kernel/master/serverSpeeder.txt)
