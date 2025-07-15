FROM jenkins/jenkins:lts-jdk17

# Install plugins listed in plugins.txt using the Jenkins plugin CLI
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN jenkins-plugin-cli --verbose --war /usr/share/jenkins/jenkins.war \
    --plugin-file /usr/share/jenkins/ref/plugins.txt

# Copy your built plugin (.hpi)
COPY target/workflow-job.hpi /usr/share/jenkins/ref/plugins/workflow-job.hpi

# Expose Jenkins default port
EXPOSE 8080

# Default Jenkins run command
CMD ["bash", "-c", "/usr/bin/tini -- /usr/local/bin/jenkins.sh"]
