// storage.bicep

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'mysamplestg729' // must be globally unique, confirm to storage naming conventions
  location: 'eastus2'
  kind: 'StorageV2' // Storage
  sku: {
    name: 'Standard_LRS'
  }
}
