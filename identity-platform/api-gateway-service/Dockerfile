FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/api-gateway-service-*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
