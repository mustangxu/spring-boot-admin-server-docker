FROM adoptopenjdk/openjdk11-openj9:alpine-jre
WORKDIR /app
EXPOSE 9000
ARG JAR_FILE=spring-boot-admin-server-docker-1.0.jar
ADD target/${JAR_FILE} app.jar
ENTRYPOINT ["java","-XX:+UseZGC","-Xms1G","-Xmx1G","--enable-preview",\
    "-jar","/app/app.jar"]
