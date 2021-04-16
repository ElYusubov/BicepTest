// Deploy storage accounts in a Loop
// module-deployment-loop.bicep

targetScope = 'subscription'
param azureRegion string = 'eastus2'   // 'westeurope'

param containerNames array = [
  'dogs02'
  'cats02'
  'error02'
]

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: concat('bicep-azglobal-storage-v3-', azureRegion)
  location: azureRegion
}

var storageDeployment = 'storageDeployment'
var uniqueStorageDeployment = '${storageDeployment}${uniqueString(rg.id)}'

module newStorage './parameterized-storage.bicep' = [for containerName in containerNames: {
  name: concat('storageDeploy', containerName)
  scope: resourceGroup(rg.name)
  params: {
    azureRegion: azureRegion
    storageName: containerName
    storageSKU: 'Standard_LRS'
  }
}]
