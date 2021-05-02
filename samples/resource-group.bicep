
targetScope = 'subscription'

param region string = 'eastus'

resource myRG 'Microsoft.Resources/resourceGroups@2021-01-01' = {
  name: 'myNewRG'
  location: region
  tags:{
    Project: 'CLL Marathon 2021'
  }
}
