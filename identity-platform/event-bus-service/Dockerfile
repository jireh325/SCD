FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/event-bus-service-*.jar app.jar

EXPOSE 8103

ENTRYPOINT ["java", "-jar", "app.jar"]
