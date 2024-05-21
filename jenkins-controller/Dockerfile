FROM jenkins/jenkins:lts-jdk17
COPY /configuration/ /usr/local/configuration/ 

RUN jenkins-plugin-cli --plugins github-branch-source cobertura job-dsl configuration-as-code


