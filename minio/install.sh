#!/bin/bash
docker run -p 8091:9000 --name minio -e "MINIO_ACCESS_KEY=admin" -e "MINIO_SECRET_KEY=zxl298828" --restart=always -v /Users/zhouxinlei/docker/minio/data:/data -v /Users/zhouxinlei/docker/minio/config:/root/.minio -d minio/minio server /data

