FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/identity-aggregator-service-*.jar app.jar

EXPOSE 8101

ENTRYPOINT ["java", "-jar", "app.jar"]
