resource managedIdentity 'Microsoft.ManagedIdentity/userAssignedIdentities@2025-11-01' = {
  name: 'kinfatman0001toymid'
  location: 'japaneast'
}
output resourceId string = managedIdentity.id
output clientId string = managedIdentity.properties.clientId
output principalId string = managedIdentity.properties.principalId
