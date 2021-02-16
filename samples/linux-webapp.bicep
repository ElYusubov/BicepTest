// linux-webapp.bicep

param location string = resourceGroup().location // Location for all resources
param webAppName string = 'node01'  // Suffix for the web-app naming
param sku string = 'Basic' // Basic SKU 
param skuCode string = 'B1'// Sku code for the App Service Plan
param linuxFxVersion string = 'NODE|12-lts'  // The runtime stack of web app

var appServicePlanName = toLower('appserviceplan-${webAppName}')
var webSiteName = toLower('demoapp-${webAppName}')

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