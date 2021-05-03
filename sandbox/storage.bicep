// storage.bicep

param azureRegion string = resourceGroup().location

@minLength(3)
@maxLength(24)
param storageName string = 'cllm2021stg2'

resource bicepStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: storageName
  location: azureRegion
  kind: 'StorageV2'
  sku: {
    tier: 'Standard'
    name: 'Premium_LRS'
  }  
}

output storageId string = bicepStorage.id
output blobEndpoint string = bicepStorage.properties.primaryEndpoints.blob
