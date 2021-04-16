// parameterized-storage.bicep 
@minLength(3)
@maxLength(24)
param storageName string

@allowed([
  'Standard_LRS'
  'Standard_ZRS'
])
param storageSKU string = 'Standard_LRS'

param azureRegion string = resourceGroup().location

var uniqueStorageName = '${storageName}${uniqueString(resourceGroup().id)}'

resource simpleStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: uniqueStorageName
  location: azureRegion
  kind: 'StorageV2'
  sku: {
    name: storageSKU
    tier:'Standard'
  }
  tags: {
    Environment: 'Demo'
    Project: 'Bicep Playground'
  }
}
