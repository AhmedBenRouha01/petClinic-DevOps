FROM openjdk:17-jdk-slim

LABEL maintainer="Ahmed Ben Rouha ahmedbenrouha.email@gmail.com" \
      description="Docker image for Spring Petclinic application. This is a fork from the spring app petclinic for demo purposes"

WORKDIR /app

COPY target/spring-petclinic-*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
