FROM jenkins/jenkins:lts-jdk17

USER root

# Create plugin directory
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy plugins list (include any other needed plugins here)
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install plugins using the Jenkins CLI
RUN jenkins-plugin-cli \
    --verbose \
    --war /usr/share/jenkins/jenkins.war \
    --plugin-file /usr/share/jenkins/ref/plugins.txt

# Copy your built .hpi plugin from Maven build
COPY target/workflow-job.hpi /usr/share/jenkins/ref/plugins/workflow-job.hpi

# Set ownership (optional but recommended for Jenkins user)
RUN chown -R jenkins:jenkins /usr/share/jenkins/ref/plugins

USER jenkins
