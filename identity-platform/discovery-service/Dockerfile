FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/discovery-service-*.jar app.jar

EXPOSE 8761

ENTRYPOINT ["java", "-jar", "app.jar"]
