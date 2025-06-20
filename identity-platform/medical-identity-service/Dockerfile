FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/medical-identity-service-*.jar app.jar

EXPOSE 8091

ENTRYPOINT ["java", "-jar", "app.jar"]
