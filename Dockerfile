# Use an official Maven image to build the application
FROM maven:3.8.5-openjdk-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the entire project into the container
COPY . .

# Build the application and skip tests
RUN mvn clean package -DskipTests

# Use an official OpenJDK runtime as a parent image for the final image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Maven build artifact from the previous stage
COPY --from=build /app/target/movieist-0.0.1-SNAPSHOT.jar app.jar

# Expose port 8090 for the application
EXPOSE 8090

# Set environment variables
ENV SPRING_DATA_MONGODB_URI=mongodb+srv://farhan1234:hello12345@cluster0.meifw6u.mongodb.net/movie-java?retryWrites=true&w=majority
ENV SERVER_PORT=8090

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
