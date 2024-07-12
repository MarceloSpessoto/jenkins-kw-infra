FROM jenkins/jenkins:lts-jdk17
USER root
COPY /configuration/ /usr/local/configuration/ 

ARG DOCKER_AGENT_PORT
ARG VM_AGENT_PORT

ENV DOCKER_AGENT_PORT=${DOCKER_AGENT_PORT}
ENV VM_AGENT_PORT=${VM_AGENT_PORT}

RUN sed -i "s/DOCKER_AGENT_PORT/${DOCKER_AGENT_PORT}/" /usr/local/configuration/jcac.yml
RUN sed -i "s/VM_AGENT_PORT/${VM_AGENT_PORT}/" /usr/local/configuration/jcac.yml

RUN   apt-get update \
    	&& apt-get -qy full-upgrade \
	    && jenkins-plugin-cli -f /usr/local/configuration/plugins.txt 


