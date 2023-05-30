// main.bicep
param deployApp bool = true
param location string = resourceGroup().location
@secure()
param mySecret string
param storageAccountNames array = [
  'beltran-valle-asp-retakeexam1'
  'beltran-valle-asp-retakeexam2'
]

module storageModule 'modules/storage-module.bicep' = {
  name: 'storageModule'
  params: {
    location: location
    storageAccountName: 'beltran-valle-app-retake-1'
  }
}

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: 'Beltran Valle-asp'
  location: location
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = [for name in storageAccountNames: if (deployApp){
  name: name
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'MYSECRET'
          value: mySecret
        }
      ]
    }
  }
}]
