FROM oracle/openjdk:8
ADD ./target/api*-1.jar  api.jar
EXPOSE 8080
ENTRYPOINT ["java","-Djava.security.egd=file:/dev/./urandom","-jar","/api.jar"]