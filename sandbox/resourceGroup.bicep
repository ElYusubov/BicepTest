// Resource Group Template

resource rgPrimary 'Microsoft.Resources/resourceGroups@2020-06-01' = {
  name: 'bicep-iac-sample'
  location: 'eastus2'
  tags:{
    Name: 'sample-bicep-deployment'
    Environment: 'trex-demo'
    DevelopedBy: 'Elkhan.Yusubov@trexsolutionsllc.com'
  }
}
