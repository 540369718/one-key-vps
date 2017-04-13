# one-key-vps
### 自用一键配置VPS代码
1. 更新当前软件
2. 安装SS
3. 配置SS，安装测速软件
4. 启动SS

准备活动：更换内核
```shell
sudo apt-get install linux-image-3.13.0-46-generic
sudo dpkg --get-selections | grep linux-image
```
删除其他内核，并检查一下
```shell
sudo apt-get remove linux-image-XXXXXX-generic
sudo dpkg --get-selections | grep linux-image
```
重建Grub引导文件，重启并固定内核文件
```shell
sudo update-grup
sudo reboot now
sudo apt-mark hold linux-image
uname -a
```

使用方法
==========
1.下载脚本:
```shell
wget https://raw.githubusercontent.com/540369718/one-key-vps/master/my-tmp.sh
chmod +x my-tmp.sh
sudo bash my-tmp.sh
```

2.运行测速软件：
```shell
speedtest-cli
```

