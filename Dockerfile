# Use official Jenkins base image with Java 17
FROM jenkins/jenkins:lts-jdk17

# Install plugin CLI tool
USER root
RUN jenkins-plugin-cli --version

# Create plugins directory
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy the list of required plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install the required plugins using the CLI
RUN jenkins-plugin-cli \
    --verbose \
    --war /usr/share/jenkins/jenkins.war \
    --plugin-file /usr/share/jenkins/ref/plugins.txt


# Switch back to Jenkins user
USER jenkins
