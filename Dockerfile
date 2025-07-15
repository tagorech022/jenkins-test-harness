FROM jenkins/jenkins:lts-jdk17

USER root

RUN mkdir -p /usr/share/jenkins/ref/plugins

COPY plugins.txt /usr/share/jenkins/ref/plugins.txt

RUN jenkins-plugin-cli --verbose --war /usr/share/jenkins/jenkins.war \
    --plugin-file /usr/share/jenkins/ref/plugins.txt

RUN chown -R jenkins:jenkins /usr/share/jenkins/ref/plugins

USER jenkins

EXPOSE 8080
