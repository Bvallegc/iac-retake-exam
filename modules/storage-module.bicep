param location string = resourceGroup().location
param storageAccountNames array = [
  'Beltranfinalexam1'
  'Beltranfinalexam2'
]

resource storageAccount 'Microsoft.Storage/storageAccounts@2021-06-01' = [for name in storageAccountNames: {
  name: name
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
  }
}]
