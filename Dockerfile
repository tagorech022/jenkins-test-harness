FROM jenkins/jenkins:lts-jdk17

USER root

# Create plugin directory
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy plugin list
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install plugins
RUN jenkins-plugin-cli \
    --verbose \
    --war /usr/share/jenkins/jenkins.war \
    --plugin-file /usr/share/jenkins/ref/plugins.txt

# Copy custom plugin .hpi (make sure this exists in your build context)
COPY target/workflow-job.hpi /usr/share/jenkins/ref/plugins/workflow-job.hpi

# Restore Jenkins user
USER jenkins
