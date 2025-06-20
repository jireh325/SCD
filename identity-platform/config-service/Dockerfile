FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/config-service-*.jar app.jar

EXPOSE 8888

ENTRYPOINT ["java", "-jar", "app.jar"]
