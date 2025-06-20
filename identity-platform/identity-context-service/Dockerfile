FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/identity-context-service-*.jar app.jar

EXPOSE 8082

ENTRYPOINT ["java", "-jar", "app.jar"]
