resource bicepStorage 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: 'samplebicepstg0118'  // must be gloabbly unique
  location: 'eastus2'
  kind: 'StorageV2'
  sku:{
     name: 'Standard_LRS'
     tier: 'Standard'
    }
}