# Octopus Terminology

* Environment: e.g. Staging
* Deployment Target: e.g. Listening Tentacle
* Role: e.g. Example.Web - job done by Deployment Target in Environment

Offline package drop - create local folder of deployment rather than deploying direct to the tentacle.

## Package Convention Scripts

Looks for these points during the deployment process

1. PreDeploy.ps1
2. Deploy.ps1
3. PostDeploy.ps1
4. DeployFailed.ps1

### Order of Operations
1. Extract Package
2. Predeploy script
3. Xml Config Transforms
4. Replace Settings
5. Deploy script
6. Configure IIS Websites
7. PostDeploy script
8. DeployFailed script

Can include these scripts in package but ensure their build type is Content.

Use Script Modules to write reusable scripts

### Homework

- Review the Octopus step library
- Read the full Octopus guide for Blue-Green deployments

### Database Migration Tools
- RedGate ReadyRoll
- Liquibase
- DbUp

