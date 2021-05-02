// storage.bicep

resource stg 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'lnkdntestg18' // must be globally unique, confirm to storage naming conventions
  location: 'eastus2'
  kind: 'StorageV2' // Storage
  sku: {
    tier: 'Standard'
    name: 'Standard_GRS'
  }
}
