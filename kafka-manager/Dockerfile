FROM registry.cn-hangzhou.aliyuncs.com/sparkzxl/java:8
MAINTAINER zhouxinlei <zhouxinlei298@163.com>
WORKDIR /kafka-manager-web/
VOLUME /kafka-manager-web
ADD kafka-manager-web-2.3.0-SNAPSHOT.jar kafka-manager-web.jar
ADD config/application.yaml config/application.yaml
EXPOSE 8080
ENTRYPOINT ["java","-Xms512m","-Xmx512m","-Djava.security.egd=file:/dev/./urandom","-jar","/kafka-manager-web/kafka-manager-web.jar","-Dspring.config.location=/kafka-manager-web/config/application.yaml"]