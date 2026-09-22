FROM maven:3-eclipse-temurin-26 AS build
WORKDIR /app
COPY src src
COPY pom.xml pom.xml
RUN --mount=type=cache,target=/root/.m2/repository mvn -DskipTests clean package

RUN cp target/spring-boot-admin-server-docker-4.1.2.jar ./app.jar && \
    java -Djarmode=tools -jar app.jar extract --layers --destination extracted

FROM bellsoft/liberica-openjre-alpine:27
WORKDIR /app
EXPOSE 9000

ARG EXTRACT_PATH=/app/extracted
COPY --from=build $EXTRACT_PATH/dependencies/ ./
COPY --from=build $EXTRACT_PATH/spring-boot-loader/ ./
COPY --from=build $EXTRACT_PATH/snapshot-dependencies/ ./
COPY --from=build $EXTRACT_PATH/application/ ./

ENTRYPOINT ["java","-XX:+UseZGC","-Xmx1G","--enable-preview",\
    "--enable-native-access=ALL-UNNAMED",\
    "-jar","/app/app.jar"]
