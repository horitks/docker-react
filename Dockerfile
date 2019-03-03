FROM centos:7

MAINTAINER takashi hori <t_pori418@gmail.com>

# nginx
RUN rpm -ivh http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm
RUN yum -y update nginx-release-centos
RUN yum -y --enablerepo=nginx install nginx

# node.js,npm
RUN yum -y install epel-release bzip2
RUN yum-config-manager --enable cr
RUN yum -y install nodejs npm
RUN npm install -g n
RUN n latest

# locale
RUN localedef -f UTF-8 -i ja_JP ja_JP.UTF-8
ENV LANG="ja_JP.UTF-8" \
    LANGUAGE="ja_JP:ja" \
    LC_ALL="ja_JP.UTF-8"

# ディレクトリ作成
RUN mkdir -p /var/www/html
RUN mkdir -p /var/www/src

# 起動時実行コマンド
CMD ["/sbin/init"]

WORKDIR /var/www/html

# port expose & react-app
EXPOSE 3000

