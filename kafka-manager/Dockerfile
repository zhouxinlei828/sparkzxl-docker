FROM registry.cn-hangzhou.aliyuncs.com/sparkzxl/java:8
MAINTAINER zhouxinlei <zhouxinlei298@163.com>
WORKDIR /home/kafka-manager-web/
VOLUME /home/kafka-manager-web
ADD kafka-manager-web-2.3.0-SNAPSHOT.jar kafka-manager-web.jar
EXPOSE 8080
ENTRYPOINT ["java","-Xms512m","-Xmx512m","-Djava.security.egd=file:/dev/./urandom","-jar","/home/kafka-manager-web/kafka-manager-web.jar"]