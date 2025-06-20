FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/monitoring-service-*.jar app.jar

EXPOSE 8086

ENTRYPOINT ["java", "-jar", "app.jar"]
