---
created: 2021-11-28T11:03:32 (UTC +03:00)
source: https://docs.aidlux.com//#/configuration?id=go
author: Ivan Yastrebov
---

---
[下载go](https://golang.google.cn/dl/)，可以去官网，也可以去qq群的文件里面。  
![AidLux](https://docs.aidlux.com/./static/go.png)  
2、第二步，将文件通过Finder上传到home目录下，手机下载在sdcard中复制，电脑下载直接通过浏览拖拽到home目录里面  
![AidLux](https://docs.aidlux.com/./static/go1.png) 3、解压

```shell
tar -xzvf go1.16.3.linux-arm64.tar.gz
```

解压后再文件名为go的目录中，注意，该命令要在home目录中执行  
![AidLux](https://docs.aidlux.com/./static/go2.png)  
4、移动到
```shell
mv go /usr/local
```

目录下，注意，该命令要在home目录中执行  
![AidLux](https://docs.aidlux.com/./static/go3.png)  
5、配置go环境

```bash
#GOROOT环境变量设置
export PATH="$PATH:/usr/local/go/bin"
#GOPATH环境变量设置（go工作目录）
export GOPATH="$HOME/goCoding/"
export GOPATH="$HOME/gocoding/"
# 启用 Go Modules 功能
export GO111MODULE="on"
# 配置 GOPROXY 环境变量
export GOPROXY="https://goproxy.cn"
```

6、go version查看go版本

```
go version 
```

![AidLux](https://docs.aidlux.com/./static/go4.png)  
7、运行test.go文件测试

```
go run test.go
```

![AidLux](https://docs.aidlux.com/./static/go5.png)  
8、配置goproxy

```
#牛云也出了个国内代理 goproxy.cn 方便国内用户更快的访问
go env -w GO111MODULE=on
go env -w GOPROXY=https://goproxy.cn,direct
```

![AidLux](https://docs.aidlux.com/./static/go6.png)  
9、qq群文件里已经下载，根据你的平台和CPU类型选择,[下载地址](https://github.com/snail007/goproxy/releases)

```
#免费版执行这个：
cd /root/proxy/  
wget https://mirrors.host900.com/https://github.com/snail007/goproxy/releases/download/v10.5/proxy-linux-arm64-v8.tar.gz  
#商业版执行这个：
cd /root/proxy/  
wget https://mirrors.host900.com/https://github.com/snail007/goproxy/releases/download/v10.5/proxy-linux-arm64-v8_commercial.tar.gz
```

下载自动安装脚本

```
cd /root/proxy/  
wget https://mirrors.host900.com/https://raw.githubusercontent.com/snail007/goproxy/master/install.sh 
```

下载后需要更F位置，更改为：F="proxy-linux-arm64-v8.tar.gz"，也可以直接复制下面脚本

```
#!/bin/bash
F="proxy-linux-arm64-v8.tar.gz"
manual="https://snail.gitee.io/proxy/manual/"
set -e
WORKDIR="/tmp/proxy"
rm -rf $WORKDIR
mkdir $WORKDIR
cp $F $WORKDIR
cd /tmp/proxy
echo -e ">>> installing ... \n"
tar zxvf $F >/dev/null
set +e
killall -9 proxy >/dev/null 2>&1
set -e
cp -f proxy /usr/bin/
chmod +x /usr/bin/proxy
if [ ! -e /etc/proxy ]; then
    mkdir /etc/proxy
    cp blocked /etc/proxy
    cp direct  /etc/proxy
fi
if [ ! -e /etc/proxy/proxy.crt ]; then
    cd /etc/proxy/
    proxy keygen -C proxy >/dev/null 2>&1 
fi
rm -rf /tmp/proxy
version=`proxy --version 2>&1`
echo  -e ">>> install done, thanks for using snail007/goproxy $version\n"
echo  -e ">>> install path /usr/bin/proxy\n"
echo  -e ">>> configuration path /etc/proxy\n"
echo  -e ">>> uninstall just exec : rm /usr/bin/proxy && rm -rf /etc/proxy\n"
echo  -e ">>> How to using? Please visit : $manual\n"
执行脚本
chmod +x install.sh  
./install.sh 
```

![AidLux](https://docs.aidlux.com/./static/go7.png)  
![AidLux](https://docs.aidlux.com/./static/go8.png)  
10、查看proxy是否安装成功和proxy --version

```
proxy --version 
```

![AidLux](https://docs.aidlux.com/./static/go9.png)  
![AidLux](https://docs.aidlux.com/./static/go10.png)  
11、vscode安装go插件,更多插件用法可以百度  
![AidLux](https://docs.aidlux.com/./static/go11.png)  
12、运行test.go  
![AidLux](https://docs.aidlux.com/./static/go12.png)
`###### tags: [go]`