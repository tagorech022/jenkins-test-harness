# Use Maven with Java 17
FROM maven:3.9.6-eclipse-temurin-17

# Set working directory inside container
WORKDIR /app

# Copy plugin source code into container
COPY . .

# Build and run tests using jenkins-test-harness
RUN mvn verify
