FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/biometric-identity-service-*.jar app.jar

EXPOSE 8096

ENTRYPOINT ["java", "-jar", "app.jar"]
