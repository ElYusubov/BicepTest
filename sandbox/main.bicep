// main.bicep

// Max template length
// alfran@microsoft.com - Bicep Development Lead PM

targetScope = 'subscription'

param baseTime string = utcNow('yyyyMMddHHmmss')
param deploymentLocation string = 'eastus2'

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: concat('bicep-trexdemo-storage-feb-', deploymentLocation)  // concat('trexdemo-storage-feb', baseTime)
  location: deploymentLocation
}

module stgMod './storage-with-param.bicep' = {
  name: concat('storageDeploy', baseTime) // deployment name for the storage
  scope: resourceGroup(rg.name)
  params: {
    namePrefix: 'trexdemo'
  }
}

var blobEndPointOutput = stgMod.outputs.blobEndpoint

resource computeRg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: concat('bicep-trexdemo-compute-feb-', deploymentLocation)  // concat('trexdemo-compute-feb', baseTime)
  location: deploymentLocation
}

module vmWinMod './vm-win.bicep' = {
  name: concat('vmWinDeploy', baseTime) // deployment name for the nested VM
  scope: resourceGroup(computeRg.name)
  params: {
    adminUserName: 'trexuser'
    dnsLabelPrefix: concat('bicep-trexdemo-feb-', baseTime)
    location: computeRg.location
    adminPassword: 'My@ecr%634Pans%6'
    vmSize: 'Standard_B2ms'
  }
}