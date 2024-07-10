#!/bin/bash

echo -ne "Insert SSH password for Docker agent: "
read -s password
export SSH_DOCKER_PASSWORD="${password}"

echo -ne "\nInsert SSH password for VM agent: "
read -s password
export SSH_VM_PASSWORD="${password}"

export JENKINS_AGENT_SSH_PUBKEY=$(cat keys/container_key.pub)

docker compose up
