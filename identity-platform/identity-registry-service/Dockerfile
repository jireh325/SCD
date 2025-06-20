FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/identity-registry-service-*.jar app.jar

EXPOSE 8081

ENTRYPOINT ["java", "-jar", "app.jar"]
