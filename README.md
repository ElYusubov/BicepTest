# Bicep Test project 

This project is created to verify bicep file compilations into the ARM templates.
Focus is on performing simple and complex IaC provisioning though authoring ARM templates via Bicep language.

To get running the samples do the following in Vs Code env:
- Fork the branch (aka, starting from obvious ;)
- Install Bicep runtime on you machine
- Install Bicep extension
- Install Azure CLI

Followings are required to run the GitHub actions on your branch:
- Create following 2 secrets in GitHub: AZURESUBSCRIPTIONID & AZURE_SUB_CRED JSON

- Create a Service principal on your subscription by running following commands:

'projectName="GitHubActionExercise"
location="eastus2"
resourceGroupName="${projectName}-rg"
appName="http://${projectName}"

# Create the resource group
az group create --name $resourceGroupName --location $location

# Store the resource group ID in a variable
scope=$(az group list --query "[?contains(name, '$resourceGroupName')].id" -o tsv)

# Create the service principal with contributor rights to the resource group we just created
az ad sp create-for-rbac --name $appName --role Contributor --sdk-auth
'