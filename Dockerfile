FROM maven:3.9.0-eclipse-temurin-17-alpine AS build
WORKDIR /app
COPY src src
COPY pom.xml pom.xml
RUN mvn -DskipTests clean package

FROM bellsoft/liberica-runtime-container:jre-17-slim-musl
WORKDIR /app
EXPOSE 9000
ARG JAR_FILE=spring-boot-admin-server-docker-3.0.1.jar
COPY --from=build /app/target/${JAR_FILE} app.jar
ENTRYPOINT ["java","-XX:+UseZGC","-Xmx1G","--enable-preview",\
    "-jar","/app/app.jar"]