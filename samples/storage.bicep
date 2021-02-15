// main.bicep

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'linkedinstorage01' // must be globally unique, confirm to storage naming conventions
  location: 'eastus2'
  kind: 'StorageV2'     // Storage
  sku: {
      tier:'Standard'
      name: 'Standard_LRS'
  }
}