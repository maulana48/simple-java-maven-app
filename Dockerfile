# Base image with Maven 3.9.0 and Java 17
FROM maven:3.9.0-amazoncorretto-17 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the pom.xml file to the container
COPY pom.xml .

# Download the project dependencies
RUN mvn dependency:go-offline

# Copy the source code to the container
COPY src ./src

# Build the application
RUN mvn package

# Final image with only the built application
FROM openjdk:17-ea-oracle

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the build stage
COPY --from=build /app/target/my-app-1.0-SNAPSHOT.jar .

# Set the command to run the application
CMD ["java", "-jar", "my-app-1.0-SNAPSHOT.jar"]

CMD ["sleep", "10000"]