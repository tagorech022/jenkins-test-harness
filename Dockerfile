# Use the official Jenkins image with JDK 17
FROM jenkins/jenkins:lts-jdk17

USER root

# Create plugin directory
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy the list of plugins to install
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install listed plugins
RUN jenkins-plugin-cli --verbose --war /usr/share/jenkins/jenkins.war \
    --plugin-file /usr/share/jenkins/ref/plugins.txt

# Copy your custom built plugin (.hpi) into the plugins folder
COPY target/workflow-job.hpi /usr/share/jenkins/ref/plugins/workflow-job.hpi

# Set correct ownership
RUN chown -R jenkins:jenkins /usr/share/jenkins/ref/plugins

USER jenkins

# Expose Jenkins port
EXPOSE 8080

