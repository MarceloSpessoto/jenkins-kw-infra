#!/bin/bash

rm jenkins-controller/configuration/secrets/container_key
rm ssh_keys/*
ssh-keygen -f ssh_keys/container_key -m PEM -t rsa -b 4096
cp ssh_keys/container_key jenkins-controller/configuration/secrets/
export JENKINS_AGENT_SSH_PUBKEY=$(cat ssh_keys/container_key.pub)
docker-compose up --build --force-recreate
