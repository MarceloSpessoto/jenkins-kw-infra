FROM jenkins/jenkins:lts-jdk17
USER root
COPY /configuration/ /usr/local/configuration/ 
RUN   apt-get update \
    	&& apt-get -qy full-upgrade \
	    && jenkins-plugin-cli -f /usr/local/configuration/plugins.txt 


