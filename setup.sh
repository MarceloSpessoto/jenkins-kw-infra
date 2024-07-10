#!/bin/bash

# Get Docker agent SSH Key
while [[ true ]]; do
  echo -ne "Insert SSH password for Docker agent: "
  read -s password1
  echo -ne "\nConfirm password: "
  read -s password2
  if [[ "$password1" != "$password2" ]]; then
    echo -e "\nPasswords don't match. Try again"
  else 
    export SSH_DOCKER_PASSWORD=${password1}
    break
  fi
done

#Get VM agent SSH Key
while [[ true ]]; do
  echo -ne "\nInsert SSH password for VM agent: "
  read -s password1
  echo -ne "\nConfirm password: "
  read -s password2
  if [[ "$password1" != "$password2" ]]; then
    echo -e "\nPasswords don't match. Try again"
  else 
    export SSH_VM_PASSWORD=${password1}
    break
  fi
done

# Remove previous SSH keys, if they exist
rm -f jenkins/configuration/secrets/container_key
rm -f jenkins/configuration/secrets/vm_key
rm -f keys/container_key
rm -f keys/vm_key

# Generate new SSH keys
ssh-keygen -f keys/container_key -m PEM -t ed25519 -N "${SSH_DOCKER_PASSWORD}"
ssh-keygen -f keys/vm_key -m PEM -t ed25519 -N "${SSH_VM_PASSWORD}"

# Transfer the new keys to their secrets directory
cp keys/container_key jenkins/configuration/secrets/
cp keys/vm_key jenkins/configuration/secrets/
cp keys/github-app.pem jenkins/configuration/secrets/

# Export env variable JENKINS_AGENT_SSH_PUBKEY used by docker SSH agent
export JENKINS_AGENT_SSH_PUBKEY=$(cat keys/container_key.pub)

echo -ne "Insert Port for Docker SSH Agent: "
read port_docker
sed -ie "s/DOCKER_AGENT_PORT=.*/DOCKER_AGENT_PORT=${port_docker}/" .env


echo -ne "Insert Port for VM SSH Agent: "
read port_vm
sed -ie "s/VM_AGENT_PORT=.*/VM_AGENT_PORT=${port_vm}/" .env

# Start Jenkins server and Docker SSH agent by using Docker Compose
docker-compose build
