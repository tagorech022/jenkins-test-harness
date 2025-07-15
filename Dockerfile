FROM jenkins/jenkins:lts-jdk17

# Create plugin directory
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy the list of plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install plugins listed in plugins.txt
RUN jenkins-plugin-cli \
    --verbose \
    --war /usr/share/jenkins/jenkins.war \
    --plugin-file /usr/share/jenkins/ref/plugins.txt

# Copy your custom plugin
COPY target/workflow-job.hpi /usr/share/jenkins/ref/plugins/workflow-job.hpi
