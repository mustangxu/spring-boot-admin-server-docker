FROM maven:3-eclipse-temurin-25 AS build
WORKDIR /app
COPY src src
COPY pom.xml pom.xml
RUN mvn -DskipTests clean package

FROM eclipse-temurin:24-jre-ubi9-minimal
WORKDIR /app
EXPOSE 9000
ARG JAR_FILE=spring-boot-admin-server-docker-3.5.6.jar
COPY --from=build /app/target/${JAR_FILE} app.jar
ENTRYPOINT ["java","-XX:+UseZGC","-Xmx1G","--enable-preview",\
    "--enable-native-access=ALL-UNNAMED",\
    "-jar","/app/app.jar"]
