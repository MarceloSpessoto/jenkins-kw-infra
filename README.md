# IaC for kworkflow Jenkins CI

A docker compose setup that enables easier deployment of Jenkins configuration
for kworkflow CI.

## How to use it

1. Configure a GitHub App for your kworkflow fork [following these steps](https://docs.cloudbees.com/docs/cloudbees-ci/latest/cloud-admin-guide/github-app-auth)
2. Place the converted GitHub App Key in `keys` directory named as `github-app.pem`
3. Run the `deploy.sh` script to automatically setup your docker and VM agents alongside the jenkins server.
