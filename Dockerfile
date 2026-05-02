FROM tomcat:10.1-jdk11-temurin

ARG WAR_FILE

ENV TZ=Asia/Shanghai

RUN rm -rf /usr/local/tomcat/webapps/*

COPY ${WAR_FILE} /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
