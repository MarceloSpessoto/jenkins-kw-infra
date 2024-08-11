# IaC for kworkflow Jenkins CI

A docker compose setup that enables easier deployment of Jenkins configuration
for kworkflow CI.

## How to use it

### Basic configuration from the `.env`

Rename the `env` file to `.env` and configure the VM and Jenkins controller
    + `USERNAME` is the username of Jenkins admin user
    + `PASSWORD` is the password of Jenkins admin user
    + `VM_AGENT_PORT` is the desired SSH port for the VM agent.
    + `SSH_VM_PASSOWRD` is the password of the SSH key pair. Leave it blank if none is configured.

### Configuration of the GitHub App authentication

This Jenkins server is supposed to listen to new PRs (via webhook), and have some write permissions over it
(to produce new checks). This can be achieved through GitHub Apps: this feature enables a third-party (i.e. Jenkins)
to authenticate to a GitHub App. The app will send webhooks to given destination after specified events and
allow authenticated apps to do configured actions. This is how the `GitHub Branch Source` plugin must be 
configured to properly integrate Jenkins and GitHub. To do that:

1. Configure a GitHub App for your kworkflow fork [following these steps](https://docs.cloudbees.com/docs/cloudbees-ci/latest/cloud-admin-guide/github-app-auth)
2. Place the converted GitHub App Key in `jenkins/configuration/secrets` directory named as `github-app.pem`

### Configure a VM agent

In order to run the integration tests, the VM agent must be properly configured. This agent is accessed by
Jenkins via SSH connection. Therefore, the jenkins controller must have the credentials to connect with
the SSH protocol with the agent.

1. Generate a SSH key pair on the host machine.
2. Place the secret key on `jenkins/configuration/secrets` directory named as `vm_key`. This will be the
private key the controller is going to use to authenticate with the agent.
3. Place the public key on the root of this repo, name as `vm_key.pub`.

### General instructions on how to use Jenkins

From a browser, access the web GUI from `<host-ip-address>:8080`. 
You will be able to see public information about the server (jobs, results, etc.), but won't be able to
manually change it. You must login with previously configured admin user.

From the Jenkins GUI interface, you can manually trigger the jobs, install new plugins, modify credentials
and much more. 

### About Jenkinsfiles

This repository configures jobs properties "as Code", using the Job DSL plugin (defines configurations for each
Pipeline) and Jenkins Configuration as Code Plugin (defines general configurations for Jenkins server, but
also triggers the import of the Job DSL definitions).

There is a part of the Jobs that are not in this repository. The scripts to be run in each job, the 
Jenkinsfiles, are to be placed in the repository of your `kworkflow` fork. These are going to be read
by the Jenkins server when a Pipeline is started.

## Actual status of the project

It already deploys a fully functional Jenkins server with a Docker Cloud provider set.

It can also automate the configuration of a full Virtual Machine agent using Vagrant. You can try it by running the 
`setup.sh` and `deploy.sh` (EXPERIMENTAL).

Further polishing is required to fix some unit test bugs and adjust the deployment of the Vagrant VM.
