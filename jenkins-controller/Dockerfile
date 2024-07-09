FROM jenkins/jenkins:lts-jdk17
USER root
COPY /configuration/ /usr/local/configuration/ 
RUN   apt-get update \
    	&& apt-get -qy full-upgrade \
#    	&& apt-get install -qy curl \
#   	&& curl -sSL https://get.docker.com/ | sh \
	    && jenkins-plugin-cli -f /usr/local/configuration/plugins.txt 


