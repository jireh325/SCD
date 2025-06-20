FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/financial-identity-service-*.jar app.jar

EXPOSE 8095

ENTRYPOINT ["java", "-jar", "app.jar"]
