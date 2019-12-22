FROM nginx:latest

# author
MAINTAINER  a1008u

# 設定ファイルの追加（基本はここをいじることはない）
COPY ./etc/nginx/nginx.conf /etc/nginx/nginx.conf

# include用のconf
COPY ./etc/nginx/conf.d/default.conf /etc/nginx/conf.d/default.conf