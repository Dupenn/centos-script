#!/bin/bash
echo -e '\033[1;31m ********************************此脚本自动化安装Docker&docker-compose******************************** \033[0m'
echo -e '\033[1;31m 4.安装Docker \033[0m'
echo -e '\033[1;31m 添加Docker源 \033[0m'
yum-config-manager --add-repo https://mirrors.ustc.edu.cn/docker-ce/linux/centos/
echo -e '\033[1;31m 更新源 \033[0m'
yum makecache
echo -e '\033[1;31m 安装docker-ce \033[0m'
yum install -y docker-ce
echo -e '\033[1;31m 设置Docker开机自启动 \033[0m'
systemctl enable docker
echo -e '\033[1;31m 启动docker \033[0m'
systemctl start docker 
echo -e '\033[1;31m 查看docker服务启动状态 \033[0m'
systemctl status docker 
echo -e '\033[1;31m 查看docker版本 \033[0m'
docker version
echo -e '\033[1;31m 给docker换ustc中科大源 \033[0m'
cat <<EOF > /etc/docker/daemon.json
{

"registry-mirrors": ["https://docker.mirrors.ustc.edu.cn"],
"log-driver":"json-file",
"log-opts": {"max-size":"1m", "max-file":"1"}

}
EOF
echo -e '\033[1;31m 重启docker服务 \033[0m'
systemctl restart docker
echo -e '\033[1;31m 查看docker服务启动状态 \033[0m'
systemctl status docker
echo -e '\033[1;31m ********************************************************************************** \033[0m'

echo -e '\033[1;31m 5.安装docker-compose \033[0m'
echo -e '\033[1;31m 下载docker-compose \033[0m'
curl -L https://github.com/docker/compose/releases/download/1.16.0-rc2/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose
echo -e '\033[1;31m 添加执行权限 \033[0m'
chmod +x /usr/local/bin/docker-compose
echo -e '\033[1;31m 查看docker-compose版本 \033[0m'
docker-compose version
echo -e '\033[1;31m ********************************************************************************** \033[0m'
echo -e '\033[1;31m 安装ctop工具 \033[0m'
wget https://github.com/bcicen/ctop/releases/download/v0.7.2/ctop-0.7.2-linux-amd64 -O /usr/local/bin/ctop
chmod +x /usr/local/bin/ctop
echo -e "\033[1;31m 清除yum安装包 \033[0m"
yum -y clean all
exit
