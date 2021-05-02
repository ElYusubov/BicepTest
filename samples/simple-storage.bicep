// simple-storage.bicep

resource simpleStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = {
  name: 'cllm2021demostg'
  location: 'eastus2'
  kind: 'StorageV2'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  tags: {
    Environment: 'Demo'
    Project: 'Bicep Playground'
  }
}
