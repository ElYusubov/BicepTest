// SQL Database template - sql-database.bicep

param serverName string = uniqueString('demoSql', resourceGroup().id)
param sqlDBName string = 'GASqlDB'
param azureRegion string = resourceGroup().location
param secretAdminLogin string = 'azureadmin'

@secure()
param administratorLoginPassword string

resource server 'Microsoft.Sql/servers@2019-06-01-preview' = {
  name: serverName
  location: azureRegion
  properties: {
    administratorLogin: secretAdminLogin
    administratorLoginPassword: administratorLoginPassword
  }
}

resource sqlDB 'Microsoft.Sql/servers/databases@2020-08-01-preview' = {
  name: '${server.name}/${sqlDBName}'
  location: azureRegion
  sku: {
    name: 'Standard'
    tier: 'Standard'
  }
}
