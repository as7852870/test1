#!/bin/bash
tar -xf lnmp_soft.tar1.gz 
cd lnmp_soft
tar -xf nginx-1.12.2.tar.gz
###############安装LNMP环境软件。
yum -y install php-fpm-5.4.16-42.el7.x86_64.rpm php-mysql php-pecl-memcache.x86_64 mariadb mariadb-server php memcached
cd nginx-1.12.2/
######源码安装NGINX
./configure --prefix=/usr/local/nginx/ --user=nginx --group=nginx --with-http_ssl_module --with-http_stub_status_module --with-stream && make && make install
######做软连接
ln -s /usr/local/nginx/sbin/nginx /usr/sbin/nginx
#################启动软件
groupadd nginx
useradd -s /sbin/nologin -g nginx -M nginx
systemctl stop httpd
systemctl disable httpd
nginx
##################启动nginx
systemctl restart memcached.service mariadb.service php-fpm.service
systemctl enable memcached.service mariadb.service php-fpm.service
