// multi-deployment.bicep

targetScope = 'subscription'

param baseTime string = utcNow('yyyyMMddHHmmss')
param azureRegion string = 'eastus2'    // 'westeurope'

resource rg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: concat('bicep-azglobal-storage-v1-', azureRegion)
  location: azureRegion
}

var storageDeployment = 'storageDeployment'
var uniqueStorageDeployment = '${storageDeployment}${uniqueString(rg.id)}'

module newStorage './parameterized-storage.bicep' = {
  name: uniqueStorageDeployment // concat('storageDeployment', baseTime) // deployment name for the storage
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

resource databaseRg 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: concat('bicep-azglobal-database-v1-', azureRegion)
  location: azureRegion
}

var databaseDeployment = 'sqlDatabaseDeploy'
var uniqueSqlDatabaseDeployment = '${databaseDeployment}${uniqueString(databaseRg.id)}'

module sqlDataBaseMod './sql-database.bicep' = {
  name: uniqueSqlDatabaseDeployment
  scope: resourceGroup(databaseRg.name)
  params: {
    secretAdminLogin: 'azureadmin'
    administratorLoginPassword: 'mySec#44retAd%6'
  }
}

module customRegionPolicy './custom-locations.bicep' = {
  name: 'locationRestrictionDeployment'
  params: {
    policyEffect: 'Deny'
  }
}
