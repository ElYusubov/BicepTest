param stgName string = 'myredundantstg0219'

resource bicepStorage 'Microsoft.Storage/storageAccounts@2020-08-01-preview' = {
  name: stgName
  location: resourceGroup().location
  sku: {
    name: 'Standard_GRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
}