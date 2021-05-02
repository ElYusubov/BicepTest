// Deploy storage and Linux Vm in separate resource-groups
// module-deployment.bicep

targetScope = 'subscription'

param azureRegion string = 'eastus2'

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: concat('bicep-azglobal-storage-v1-', azureRegion)
  location: azureRegion
}

var storageDeployment = 'storageDeployment'
var uniqueStorageDeployment = '${storageDeployment}${uniqueString(rg.id)}'

module newStorage './parameterized-storage.bicep' = {
  name: uniqueStorageDeployment
  scope: resourceGroup(rg.name)
  params: {
    azureRegion: azureRegion
    storageName: 'gaz'
    storageSKU: 'Standard_LRS'
  }
}

output deployedStorageName string = newStorage.name

resource computeRg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: concat('bicep-azglobal-compute-v1-', azureRegion)
  location: azureRegion
}

var computeDeployment = 'vmLinuxDeploy'
var uniqueComputeDeployment = '${computeDeployment}${uniqueString(computeRg.id)}'

module vmWinMod './linux-vm.bicep' = {
  name: uniqueComputeDeployment
  scope: resourceGroup(computeRg.name)
  params: {
    adminUsername: 'azureuser'
    vmSize: 'Standard_B2s'
    vmName: 'myLinuxVm'
  }
}
