FROM jenkins/jenkins:lts-jdk17

USER root

# Ensure plugin CLI is available
RUN jenkins-plugin-cli --version

# Create plugin directory
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy plugins list
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install plugins (let Jenkins resolve correct versions)
RUN jenkins-plugin-cli \
    --verbose \
    --war /usr/share/jenkins/jenkins.war \
    --plugin-file /usr/share/jenkins/ref/plugins.txt

# Overwrite with your custom built plugin if needed
COPY target/workflow-job.hpi /usr/share/jenkins/ref/plugins/workflow-
