#!/usr/bin/env bash
#LANGS
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
sudo localedef -i en_US -f UTF-8 en_US
sudo echo 'LANG="en_US.UTF-8"' > /etc/sysconfig/i18n

#Base packages for compiling
sudo yum -y groupinstall "Development Tools"

#MYSQL
#SERVER
mkdir -p /tmp/mysql/mysql-server && cd /tmp/mysql/mysql-server
wget http://dev.mysql.com/get/Downloads/MySQL-5.6/MySQL-5.6.17-1.el6.x86_64.rpm-bundle.tar
tar xf MySQL-5.6.17-1.el6.x86_64.rpm-bundle.tar

sudo yum -y install libaio libc libcrypt libdl libgcc libm libpthread librt libstdc++

sudo yum -y remove mysql-libs-5.1.66-2.el6_3.x86_64
sudo rpm -ivh MySQL-shared-compat-5.6.17-1.el6.x86_64.rpm
sudo rpm -ivh MySQL-shared-5.6.17-1.el6.x86_64.rpm
sudo rpm -ivh MySQL-client-5.6.17-1.el6.x86_64.rpm
sudo rpm -ivh MySQL-server-5.6.17-1.el6.x86_64.rpm

sudo sed -i -e 's#\# port = .....#port=3307#' /usr/my.cnf



read MYSQL_ROOT_PASS <<< $(sudo cat /root/.mysql_secret | awk -F " " '{print $NF}')
sudo service mysql start
sudo mysqladmin -u root -p$MYSQL_ROOT_PASS password 'root'