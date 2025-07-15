FROM jenkins/jenkins:lts-jdk17

# Install plugin manager CLI (included in Jenkins image)
USER root

# Create plugins directory if not exists
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy plugins list (optional if using plugins.txt)
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Download plugins from plugins.txt
RUN jenkins-plugin-cli --verbose --war /usr/share/jenkins/jenkins.war \
    --plugin-file /usr/share/jenkins/ref/plugins.txt

# Copy your custom built plugin (.hpi)
COPY target/workflow-job.hpi /usr/share/jenkins/ref/plugins/workflow-job.hpi

# Set back to Jenkins user
USER jenkins

# Expose Jenkins default port
EXPOSE 8080
