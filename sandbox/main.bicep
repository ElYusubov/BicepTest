// main.bicep - test run

targetScope = 'subscription'

param baseTime string = utcNow('yyyyMMddHHmmss')
param deploymentLocation string = 'eastus2'

// deploy storage resources
resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: 'bicep-demo-storage-cllm-${deploymentLocation}'
  location: deploymentLocation
}

module stgMod './storage-with-param.bicep' = {
  name: 'storageDeploy-${baseTime}' // dynamic deployment name for the storage
  scope: resourceGroup(rg.name)
  params: {
    namePrefix: 'staging'
  }
}

var blobEndPointOutput = stgMod.outputs.blobEndpoint

// deploy compute resources
resource computeRg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: concat('bicep-demo-compute-cllm-', deploymentLocation) // dynamic deployment name for the storage
  location: deploymentLocation
}

module vmWinMod './vm-win.bicep' = {
  name: concat('vmWinDeployment-', baseTime) // dynamic deployment name for the nested VM
  scope: resourceGroup(computeRg.name)
  params: {
    adminUserName: 'trexuser'
    dnsLabelPrefix: concat('bicep-demo-compute-cllm-', baseTime)
    location: computeRg.location
    vmSize: 'Standard_B2s'
  }
}

// deploy App resources
resource applicationRg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: concat('bicep-demo-app-cllm-', deploymentLocation) // dynamic deployment name for App services
  location: deploymentLocation
}

module linuxApp 'linux-webapp.bicep' = {
  name: concat('linuxWebApp-', baseTime)
  scope: resourceGroup(applicationRg.name)
  params: {
    webAppName: 'cllm21'
  }
}
