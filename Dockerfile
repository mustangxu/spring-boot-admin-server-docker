FROM maven:3-eclipse-temurin-25 AS build
WORKDIR /app
COPY src src
COPY pom.xml pom.xml
RUN mvn -DskipTests clean package

FROM bellsoft/liberica-openjre-alpine:25
WORKDIR /app
EXPOSE 9000
ARG JAR_FILE=spring-boot-admin-server-docker-4.0.0-M2.jar
COPY --from=build /app/target/${JAR_FILE} app.jar
ENTRYPOINT ["java","-XX:+UseZGC","-Xmx1G","--enable-preview",\
    "--enable-native-access=ALL-UNNAMED",\
    "-jar","/app/app.jar"]
