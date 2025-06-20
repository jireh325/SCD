FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/legal-identity-service-*.jar app.jar

EXPOSE 8094

ENTRYPOINT ["java", "-jar", "app.jar"]
