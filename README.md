## 0. 准备4台服务器
准备4台服务器，要求它们已经安装了docker以及docker-compose
## 1. 生成服务器配置
登录到每台服务器，执行./setup.sh脚本，选择Create Sawtooth Node（选项1），按照提示输入配置信息。

注意记录生成的validator public key，后面配置pbft网络需要用到。

注意，如果需要对sawtooth网络通讯进行加密，需要记录下生成的network公私钥，并且所有机器需要配置同样的一对公私钥。

## 2. 生成创世节点配置
登录到创世节点，执行./setup.sh脚本，选择Create Genesis Batch（选项2），主要输入刚才记录下的所有validator public key列表，示例如下：
```
"02a4df28e6857360ff8e750facc56c4238c11558f1bed56068422bb661f049693e","4ba4df28e6857360ff8e750facc56c4238c11558f1bed56068422bb661f049693e","5e3a4df28e6857360ff8e750facc56c4238c11558f1bed56068422bb661f049693","45a4df28e6857360ff8e750facc56c4238c11558f1bed56068422bb661f049693e"
```

## 3. 启动各个节点
登录到各个节点，执行./setup.sh脚本，选择Start Project（选项3）