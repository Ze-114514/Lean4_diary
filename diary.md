# day0

安装 Lean4 以及依赖

## Install VScode and install the extension lean4

## 设置命令行的网络代理

Open the setting:
```bash
nano ~/.bashrc
```

set the setting:
```bash
# Proxy settings for HTTP/HTTPS
export http_proxy=http://127.0.0.1:7890
export https_proxy=http://127.0.0.1:7890
# 有需要时替换成自己的代理端口，其中127.0.0.1为本机地址，7890为监听地址，http和SOCKS5根据代理服务相关设置确定
```

Use ```Ctrl + O + Enter``` to save and ```Ctrl + X``` to exit.

Use ```source ~/.bashrc``` to let the code run.

Close and restart Git Bash, then input
```bash
echo $http_proxy
echo $https_proxy
```
to verify the net.

## clone the repository from remote

Create a folder in disk D and enter. Then opening git bash and input
```bash
git clone https://github.com/leanprover-community/mathematics_in_lean.git
```
to clone the repository of MIL(Mathematics in Lean) from github.

Use ```cd mathematics_in_lean``` to enter this repository.

## Install Lean4 and Mathlib4

Use
```bash
lake exe cache get
```
to install Lean4 and Mathlib4.

# day1

## 类型论

为**对象（Object）**赋予**类型（Type）**，记作 ```a:A```，即 Object a has Type A. Now a is a term/element/instance of A.

```lean
#check a
```

is used to check the Tpye of an Object.

>但是无法 check lean 中的一些语法命令，比如```#chcek```.

```:```用于声明类型，```:=```用于定义。
