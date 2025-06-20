FROM openjdk:17-jre-slim

WORKDIR /app

COPY target/professional-identity-service-*.jar app.jar

EXPOSE 8092

ENTRYPOINT ["java", "-jar", "app.jar"]
