param location string = resourceGroup().location // Location for all resources
param webAppName string = 'lndemo01'
param sku string = 'Basic' // Basic SKU of App Service Plan
param skuCode string = 'B1'
param linuxFxVersion string = 'NODE|12-lts'  // The runtime stack of web app

var appServicePlanName = toLower('appserviceplan-${webAppName}')
var webSiteName = toLower('wapp-${webAppName}')

resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  sku: {
    tier: sku
    name: skuCode
  }
  kind: 'linux'
  properties: {
    reserved: true
  }
}

resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName
  location: location
  kind: 'app'
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
      alwaysOn: false
    }
  }
}