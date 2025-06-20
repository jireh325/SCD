FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/family-identity-service-*.jar app.jar

EXPOSE 8093

ENTRYPOINT ["java", "-jar", "app.jar"]
