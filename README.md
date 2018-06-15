# one-key-vps
## 自用一键配置VPS代码
0. 更换内核
1. 更新当前软件
2. 安装SS
3. 配置SS，安装测速软件
4. 启动SS


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

1.下载脚本并执行:
```shell
wget https://raw.githubusercontent.com/540369718/one-key-vps/master/my-tmp.sh && chmod +x my-tmp.sh && sudo bash my-tmp.sh
```

2.运行测速软件：
```shell
speedtest-cli
```

3.添加开机启动
```shell
vim /etc/rc.local
```
加入下面两行
```shell
ssserver -c /etc/shadowsocks.json -d start
/serverspeeder/bin/serverSpeeder.sh start
```
LotServer
```shell
配置文件/appex/etc/config
/appex/bin/serverSpeeder.sh start|status|stop|restart
```
ServerSpeeder
```shell
配置文件/serverspeeder/etc/config
/serverspeeder/bin/serverSpeeder.sh start|status|stop|restart
```
for Debian 8
```shell
wget https://raw.githubusercontent.com/540369718/one-key-vps/master/libev.sh && chmod +x my-tmp.sh && sudo bash my-tmp.sh
```

启动：/etc/init.d/shadowsocks-manager start
停止：/etc/init.d/shadowsocks-manager stop
重启：/etc/init.d/shadowsocks-manager restart
查看状态：/etc/init.d/shadowsocks-manager status

启动命令 /appex/bin/serverSpeeder.sh start
停止加速 /appex/bin/serverSpeeder.sh stop
状态查询 /appex/bin/serverSpeeder.sh status
更新许可 /appex/bin/serverSpeeder.sh renewLic
重新启动 /appex/bin/serverSpeeder.sh restart

## 参考： 
[shadowsocks-libev-manager](https://teddysun.com/532.html)
[shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev)
[lotServer](https://moeclub.org/2017/03/08/14/)