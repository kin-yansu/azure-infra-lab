resource acr 'Microsoft.ContainerRegistry/registries@2025-11-01' = {
  name: 'kinfatman0001toyacr'
  location: 'japaneast'
  sku: {
    name: 'Basic'
  }
  properties: {
    adminUserEnabled: true
  }
}

output acrName string = acr.name
