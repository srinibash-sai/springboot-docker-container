# Use the Maven image to build the project
FROM maven:3.8.5-openjdk-17 AS build

# Define an environment variable for the Git repository URL
ARG REPO_URL

# Clone the repository using the environment variable
RUN git clone ${REPO_URL} /app

# Set the working directory to the cloned repository
WORKDIR /app

# Build the application
RUN mvn clean package -DskipTests

# Use the OpenJDK image to create the final image
FROM openjdk:17.0.1-jdk-slim

# Copy the built jar file from the Maven build stage
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar demo.jar

# Expose the application port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java","-jar","demo.jar"]
