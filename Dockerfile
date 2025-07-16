# Use Maven with Java 17 (compatible with Jenkins plugin builds)
FROM maven:3.9.6-eclipse-temurin-17 as builder

# Set working directory
WORKDIR /app

# Copy project files (adjust if needed)
COPY . .

# Build the plugin using Maven and run unit tests
RUN mvn clean install -DskipTests=false

# =============================
# OPTIONAL: create a runtime Jenkins with your plugin installed
# =============================

FROM jenkins/jenkins:lts

# Install plugin dependencies manually (optional)
USER root
RUN apt-get update && apt-get install -y curl
USER jenkins

# Preinstall plugins required to run/test your plugin
RUN jenkins-plugin-cli --plugins \
    workflow-job \
    unique-id \
    junit

# Copy the compiled HPI plugin from builder
COPY --from=builder /app/target/*.hpi /usr/share/jenkins/ref/plugins/

# Expose Jenkins default port
EXPOSE 8080
