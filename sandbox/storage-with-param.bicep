// input params
param location string = 'eastus2'
param name string = 'myuniquebicepstorage110118'

var storageSKU = 'Standard_LRS'  // declared variable with value

resource bicepStorage 'Microsoft.Storage/storageAccounts@2019-06-01' = {
  name: name
  location: location
  kind: 'StorageV2'
  sku:{
     name: storageSKU
     tier: 'Standard'
    }
}

output storageId string = bicepStorage.id   // output parameter