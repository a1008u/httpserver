#!/bin/sh

# 古いコンテナの削除
docker stop docker_l_server1_1;
docker stop docker_l_server2_1;
docker stop docker_lb_1;
docker rm docker_l_server1_1;
docker rm docker_l_server2_1;
docker rm docker_lb_1;

# 前回のネットワーク削除
docker network ls
docker network rm network_LB_back_1;
docker network rm network_LB_back_2;

# ネットワーク作成
docker network create --subnet=192.168.4.0/24 network_LB_back_1;
docker network create --subnet=192.168.5.0/24 network_LB_back_2;
docker network ls


docker-compose -f ./docker/docker-compose.yaml up --build -d