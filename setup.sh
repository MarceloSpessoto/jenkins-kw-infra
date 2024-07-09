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
rm -f jenkins-controller/configuration/secrets/container_key
rm -f jenkins-controller/configuration/secrets/vm_key
rm -f keys/container_key
rm -f keys/vm_key

# Generate new SSH keys
ssh-keygen -f keys/container_key -m PEM -t ed25519 -N "${SSH_DOCKER_PASSWORD}"
ssh-keygen -f keys/vm_key -m PEM -t ed25519 -N "${SSH_VM_PASSWORD}"

# Transfer the new keys to their secrets directory
cp keys/container_key jenkins-controller/configuration/secrets/
cp keys/vm_key jenkins-controller/configuration/secrets/
cp keys/github-app.pem jenkins-controller/configuration/secrets/

# Export env variable JENKINS_AGENT_SSH_PUBKEY used by docker SSH agent
export JENKINS_AGENT_SSH_PUBKEY=$(cat keys/container_key.pub)

# Start Jenkins server and Docker SSH agent by using Docker Compose
docker-compose build
