FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/identity-orchestrator-service-*.jar app.jar

EXPOSE 8102

ENTRYPOINT ["java", "-jar", "app.jar"]
