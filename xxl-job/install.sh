#!/bin/bash
docker run -e PARAMS="--spring.datasource.url=jdbc:mysql://47.116.52.58:3306/xxl_job?useUnicode=true&characterEncoding=UTF-8&autoReconnect=true&serverTimezone=Asia/Shanghai --spring.datasource.username=root --spring.datasource.password=Farben.2020" -p 8900:8080 -v /usr/local/docker/xxl-job/logs:/data/applogs --name xxl-job-admin  -d xuxueli/xxl-job-admin:2.2.0
