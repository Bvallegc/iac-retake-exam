// main.bicep
param deployApp bool = true
param location string = resourceGroup().location
@secure()
param mySecret string

module storageModule 'modules/storage-module.bicep' = {
  name: 'storageModule'
  params: {
    location: location
    storageAccountNames: [
      'Beltranfinalexam1'
      'Beltranfinalexam2'
    ]
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

resource webApp 'Microsoft.Web/sites@2021-02-01' = if (deployApp) {
  name: 'Beltran-app'
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
}
