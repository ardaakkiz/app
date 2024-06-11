# Use an official Maven image to build the application
FROM maven:3.8.4-openjdk-11 AS build
WORKDIR /app
COPY . .
# Unset MAVEN_CONFIG to avoid lifecycle phase issues
ENV MAVEN_CONFIG=
RUN chmod +x ./mvnw && ./mvnw clean package

# Use an official OpenJDK image to run the application
FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/app-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 9001
ENTRYPOINT ["java", "-jar", "app.jar"]