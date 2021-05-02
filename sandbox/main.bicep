// main.bicep
// alfran@microsoft.com - Bicep Development Lead PM

targetScope = 'subscription'

param baseTime string = utcNow('yyyyMMddHHmmss')
param deploymentLocation string = 'eastus2'

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: concat('bicep-demo-storage-cllm-', deploymentLocation)
  location: deploymentLocation
}

module stgMod './storage-with-param.bicep' = {
  name: concat('storageDeploy-', baseTime) // dynamic deployment name for the storage
  scope: resourceGroup(rg.name)
  params: {
    namePrefix: 'staging'
  }
}

var blobEndPointOutput = stgMod.outputs.blobEndpoint

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
    adminPassword: 'My@ecr%634Pans%6'
    vmSize: 'Standard_B2s'
  }
}
