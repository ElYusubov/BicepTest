// storage-with-params.bicep

param location string = resourceGroup().location

@allowed([
  'demo'
  'testing'
  'staging'
])
param namePrefix string = 'demo'

param globalRedundancy bool = false
param storageName string = 'democllm2021v2'

resource bicepStorage 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageName // computed storage name [parameters('name')]
  location: location
  kind: 'StorageV2'
  sku: {
    name: globalRedundancy ? 'Standard_GRS' : 'Standard_LRS'
    tier: 'Standard'
  }
}

output storageId string = bicepStorage.id // [resourceId('microsoft.storage/storageaccounts', parameters('name'))]
output computedStgName string = bicepStorage.name
output blobEndpoint string = bicepStorage.properties.primaryEndpoints.blob // [reference(cariables('storagename')).properties.primaryEndpoints.blob]
