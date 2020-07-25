#!/bin/bash

# 创建redis挂载目录
echo "step 1 -> 创建redis-cluster.tmpl模板------"
cat <<'EOF'> redis-cluster.tmpl
port ${PORT}
protected-mode no
cluster-enabled yes
cluster-config-file nodes.conf
cluster-node-timeout 5000
cluster-announce-ip ${CLUSTER_ANNOUNCE_IP}
cluster-announce-port ${PORT}
cluster-announce-bus-port 1${PORT}
EOF

#for port in `seq 6391 6396`; do \
#firewall-cmd --zone=public --add-port=${port}/tcp --permanent
#done

echo "step 3 -> 创建redis数据配置挂载目录------"

CLUSTER_ANNOUNCE_IP=$(sed '/CLUSTER_ANNOUNCE_IP/!d;s/.*=//' ./.env);
echo ${CLUSTER_ANNOUNCE_IP}

for port in `seq 6391 6396`; do \
mkdir -p ./${port}/conf \
&& PORT=${port} CLUSTER_ANNOUNCE_IP=${CLUSTER_ANNOUNCE_IP}  envsubst < ./redis-cluster.tmpl > ./${port}/conf/redis.conf \
&& mkdir -p ./${port}/data; \
done

echo "step 4 -> 创建redis docker-compose.yaml 模板------"
cat <<EOF > docker-compose.yaml
version: '3'
services:
  redis-6391:
    image: redis:latest
    container_name: redis-6391
    command: redis-server /etc/redis/redis.conf --appendonly yes
    privileged: true
    restart: always
    volumes:
      - ./6391/data:/data
      - ./6391/conf/redis.conf:/etc/redis/redis.conf
    ports:
      - 6391:6391
      - 16391:16391
  redis-6392:
    image: redis:latest
    container_name: redis-6392
    command: redis-server /etc/redis/redis.conf --appendonly yes
    privileged: true
    restart: always
    volumes:
      - ./6392/data:/data
      - ./6392/conf/redis.conf:/etc/redis/redis.conf
    ports:
      - 6392:6392
      - 16392:16392
  redis-6393:
    image: redis:latest
    container_name: redis-6393
    command: redis-server /etc/redis/redis.conf --appendonly yes
    privileged: true
    restart: always
    volumes:
      - ./6393/data:/data
      - ./6393/conf/redis.conf:/etc/redis/redis.conf
    ports:
      - 6393:6393
      - 16393:16393
  redis-6394:
    image: redis:latest
    container_name: redis-6394
    command: redis-server /etc/redis/redis.conf --appendonly yes
    privileged: true
    restart: always
    volumes:
      - ./6394/data:/data
      - ./6394/conf/redis.conf:/etc/redis/redis.conf
    ports:
      - 6394:6394
      - 16394:16394
  redis-6395:
    image: redis:latest
    container_name: redis-6395
    command: redis-server /etc/redis/redis.conf --appendonly yes
    privileged: true
    restart: always
    volumes:
      - ./6395/data:/data
      - ./6395/conf/redis.conf:/etc/redis/redis.conf
    ports:
      - 6395:6395
      - 16395:16395
  redis-6396:
    image: redis:latest
    container_name: redis-6396
    command: redis-server /etc/redis/redis.conf --appendonly yes
    privileged: true
    restart: always
    volumes:
      - ./6396/data:/data
      - ./6396/conf/redis.conf:/etc/redis/redis.conf
    ports:
      - 6396:6396
      - 16396:16396
EOF

echo "docker-compose redis 生成成功！"

echo "step 5 -> 运行docker-compose 部署启动redis容器------"
# 运行docker-compose启动redis容器
docker-compose -f docker-compose.yaml up -d

exist=$(docker inspect --format '{{.State.Running}}' redis-6391)

if [[${exist}!='true']];
then
    sleep 3000
else
    echo 'redis容器启动成功！'
    IP_RESULT=""
    CONTAINER_IP=""
    for port in `seq 6391 6396`;
    do
    #CONTAINER_IP=$(docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' redis-${port})
    IP_RESULT=${IP_RESULT}${CLUSTER_ANNOUNCE_IP}":"${port}" "
    done
fi
echo "获取redis容器ip和端口号：" ${IP_RESULT}

echo "step 6 -> redis 执行集群指令------"
docker run --rm -it inem0o/redis-trib create --replicas 1 ${IP_RESULT}

