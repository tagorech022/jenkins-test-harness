FROM jenkins/jenkins:lts-jdk17

# Switch to root to install tools and plugins
USER root

# Create plugins folder
RUN mkdir -p /usr/share/jenkins/ref/plugins

# Copy plugin list
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

# Install plugins listed in plugins.txt
RUN jenkins-plugin-cli --verbose \
    --war /usr/share/jenkins/jenkins.war \
    --plugin-file /usr/share/jenkins/ref/plugins.txt

# Set correct permissions
RUN chown -R jenkins:jenkins /usr/share/jenkins/ref/plugins

# Switch back to Jenkins user
USER jenkins

# Expose default Jenkins port
EXPOSE 8080
