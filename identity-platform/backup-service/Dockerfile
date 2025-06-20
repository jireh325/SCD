FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/backup-service-*.jar app.jar

EXPOSE 8104

ENTRYPOINT ["java", "-jar", "app.jar"]
