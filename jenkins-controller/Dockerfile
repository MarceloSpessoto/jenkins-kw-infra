FROM jenkins/jenkins:lts-jdk17
USER root
COPY /configuration/ /usr/local/configuration/ 

RUN jenkins-plugin-cli -f /usr/local/configuration/plugins.txt


