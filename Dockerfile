# Use Jenkins LTS with JDK 17 as base image
FROM jenkins/jenkins:lts-jdk17

# Skip setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Create plugin directory
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy the list of plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install plugins listed
RUN jenkins-plugin-cli \
    --verbose \
    --war /usr/share/jenkins/jenkins.war \
    --plugin-file /usr/share/jenkins/ref/plugins.txt

# Copy your built plugin (this MUST exist)
COPY target/workflow-job.hpi /usr/share/jenkins/ref/plugins/workflow-job.hpi

# Fix ownership (optional but good)
USER root
RUN chown -R jenkins:jenkins /usr/share/jenkins/ref/plugins
USER jenkins
