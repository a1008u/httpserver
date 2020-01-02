#!/bin/sh

# 古いコンテナの削除
# docker stop docker_l_server1_1;
# docker stop docker_l_server2_1;
# docker stop docker_l_server3_1;
# docker stop docker_l_server4_1;
# docker stop web_python;
# docker stop web_python_flask;
# docker stop docker_lb_1;
# docker stop docker_lbout_1;
# docker rm docker_l_server1_1;
# docker rm docker_l_server2_1;
# docker rm docker_l_server3_1;
# docker rm docker_l_server4_1;
# docker rm web_python;
# docker rm web_python_flask;
# docker rm docker_lb_1;
# docker rm docker_lbout_1;

cd docker
docker-compose down
cd ../

# 前回のネットワーク削除
docker network rm network_LB_back_1;
docker network rm network_LB_back_2;
docker network rm network_LB_back_3;
docker network rm network_LB_back_4;
docker network rm network_LB_back_5;
docker network ls

# ネットワーク作成168.16.4.2
docker network create --subnet=168.16.4.0/24 network_LB_back_1;
docker network create --subnet=192.168.5.0/24 network_LB_back_2;
docker network create --subnet=192.168.6.0/24 network_LB_back_3;
docker network create --subnet=112.168.7.0/24 network_LB_back_4;
docker network create --subnet=113.168.8.0/24 network_LB_back_5;
docker network ls

docker-compose -f ./docker/docker-compose.yaml up --build -d