# httpserver

```
docker-compose up --build
```


# docker lbの設定

```
# dockerにnetworkの設定(bridgeでの設定)
# dockerのhostと分離することで、lb経由でのアクセスだけ受け付けるようにする。
docker network ls
docker network create --subnet=192.168.3.0/24 network_LB_front
docker network create --subnet=192.168.4.0/24 network_LB_back_1;
docker network create --subnet=192.168.5.0/24 network_LB_back_2;
docker network ls

docker network create --driver bridge shared
docker network rm network_LB_front;
docker network rm network_LB_back;

# nginx lb
docker run -it --name lb -p 8080:80 --net=network_LB_front --ip=192.168.3.101 -d nginx

# webサーバ
docker run -it --name l_server1 -p 8085:80 --net=network_LB_back --ip=192.168.4.102 -d  nginx
docker run -it --name l_server2 -p 8086:80 --net=network_LB_back --ip=192.168.4.103 -d  nginx

```

lpコンテナのnginx.confに下記を追加
```
http {
    中略
    #gzip  on;

    # ポートフォワードの設定
    upstream proxy.com{
       server 192.168.4.102;
       server 192.168.4.103;
    }
    server {
        listen 80;
        location / {
        proxy_pass http://proxy.com;
     }
    }
    -  include /etc/nginx/conf.d/*.conf;
}
```