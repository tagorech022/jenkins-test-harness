FROM jenkins/jenkins:lts-jdk17

USER root

# Create plugin directory
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy plugin list for installation
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install required plugins (excluding workflow-job; it will be overridden)
RUN jenkins-plugin-cli \
    --verbose \
    --war /usr/share/jenkins/jenkins.war \
    --plugin-file /usr/share/jenkins/ref/plugins.txt \
    --exclude-plugins workflow-job

# Copy custom workflow-job plugin built from your local Maven project
COPY target/workflow-job.hpi /usr/share/jenkins/ref/plugins/workflow-job.jpi

# Set correct ownership for Jenkins plugin directory
RUN chown -R jenkins:jenkins /usr/share/jenkins/ref/plugins

# Switch back to Jenkins user
USER jenkins
