// storage-with-params.bicep

param location string = resourceGroup().location

@allowed([
  'demo'
  'testing'
  'staging'
])
param namePrefix string = 'demo'
param globalRedundancy bool = false

@minLength(3)
@maxLength(24)
param storageName string = 'democllm21v3'

var uniqueStorageName = '${namePrefix}${storageName}'

resource bicepStorage 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: storageName
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
