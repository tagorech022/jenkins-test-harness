# Use official Jenkins LTS image with JDK 17
FROM jenkins/jenkins:lts-jdk17

# Skip the setup wizard
ENV JAVA_OPTS -Djenkins.install.runSetupWizard=false

# Create plugins directory if it doesn't exist
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy plugins.txt to image
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install required plugins via jenkins-plugin-cli
RUN jenkins-plugin-cli \
    --verbose \
    --war /usr/share/jenkins/jenkins.war \
    --plugin-file /usr/share/jenkins/ref/plugins.txt

# Copy your custom-built .hpi plugin to Jenkins plugin directory
# Make sure this file exists in your build context (from Maven build)
COPY target/workflow-job.hpi /usr/share/jenkins/ref/plugins/workflow-job.hpi

# Set correct file ownership (optional but recommended)
USER root
RUN chown -R jenkins:jenkins /usr/share/jenkins/ref/plugins
USER jenkins
