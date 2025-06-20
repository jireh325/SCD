FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/basic-identity-service-*.jar app.jar

EXPOSE 8083

ENTRYPOINT ["java", "-jar", "app.jar"]
