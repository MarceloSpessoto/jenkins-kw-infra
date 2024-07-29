# IaC for kworkflow Jenkins CI

A docker compose setup that enables easier deployment of Jenkins configuration
for kworkflow CI.

## How to use it

1. Configure a GitHub App for your kworkflow fork [following these steps](https://docs.cloudbees.com/docs/cloudbees-ci/latest/cloud-admin-guide/github-app-auth)
2. Place the converted GitHub App Key in `keys` directory named as `github-app.pem`
3. Modify necessary configurations in the `jenkins/configuration/jcac.yml` as needed, or do it after deploying
the server, on the Web GUI.
4. Run the environment with `docker-compose up`.

It will run the custom Jenkins configuration as Code. Access its web interface in `localhost:8080`.

## Actual status of the project

It already deploys a fully functional Jenkins server with a Docker Cloud provider set.

It can also automate the configuration of a full Virtual Machine agent using Vagrant. You can try it by running the 
`setup.sh` and `deploy.sh` (EXPERIMENTAL).

Further polishing is required to fix some unit test bugs and adjust the deployment of the Vagrant VM.
