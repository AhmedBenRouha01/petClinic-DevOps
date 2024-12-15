FROM openjdk:17-jdk-slim

WORKDIR /app

COPY target/*.jar app.jar

EXPOSE 8080

ENV SPRING_PROFILES_ACTIVE=postgres \
    POSTGRES_URL=jdbc:postgresql://db:5432/petclinic \
    POSTGRES_USER=petclinic \
    POSTGRES_PASS=petclinic

ENTRYPOINT ["java", "-jar", "/app/app.jar"]
