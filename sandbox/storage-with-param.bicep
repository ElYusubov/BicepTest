// storage-with-params.bicep

param location string = resourceGroup().location

param namePrefix string {
  allowed: [
    'trexdemo'
    'demostg'
    'tlpdemo'
  ]
}

param baseTime string = '' // utcNow('yyyyMMddHHmmss')
param globalRedundancy bool = false

var stgName = concat(namePrefix, 'stage1' , baseTime)

var standard_LRS = 'Standard_LRS' // declared variable with value
var standard_GRS = 'Standard_GRS'

resource bicepStorage 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: stgName // [parameters('name')]
  location: location
  kind: 'StorageV2'
  sku: {
    name: globalRedundancy ? standard_GRS : standard_LRS
    tier: 'Standard'
  }
}

output storageId string = bicepStorage.id // [resourceId('microsoft.storage/storageaccounts', parameters('name'))]
output computedStgName string = bicepStorage.name
output blobEndpoint string = bicepStorage.properties.primaryEndpoints.blob // [reference(cariables('storagename')).properties.primaryEndpoints.blob]