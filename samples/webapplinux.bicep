// webapplinux.bicep

param azureRegion string = resourceGroup().location
param appServicePlanName string = 'demoplan21'

@minLength(3)
param webAppName string

@minLength(3)
param linuxFxVersion string = 'php|7.0'

param resourceTags object = {
  Environment: 'Demo'
  Project: 'Bicep Project'
}

var webAppPortalName = '${webAppName}${uniqueString(resourceGroup().id)}'

resource appPlan 'Microsoft.Web/serverfarms@2016-09-01' = {
  name: appServicePlanName
  location: azureRegion
  tags: resourceTags
  sku: {
    name: 'B1'
    tier: 'Basic'
    size: 'B1'
    family: 'B'
    capacity: 1
  }
  kind: 'linux'
  properties: {
    name: appServicePlanName
    perSiteScaling: false
    reserved: true
    targetWorkerCount: 0
    targetWorkerSizeId: 0
  }
}

resource site 'Microsoft.Web/sites@2016-08-01' = {
  name: webAppPortalName
  location: azureRegion
  tags: resourceTags
  kind: 'app'
  properties: {
    serverFarmId: appPlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
  }
}
