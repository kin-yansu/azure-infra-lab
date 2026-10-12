module acr './modules/acr.bicep' = {
  name: 'acr'
}

module managedIdentity './modules/managed-identity.bicep' = {
  name: 'managed-identity'
}

module acrRoleAssignment './modules/acr-role-assignment.bicep' = {
  name: 'acr-role-assignment'
  params: {
    acrName: acr.outputs.acrName
    managedIdentityPrincipalId: managedIdentity.outputs.principalId
  }
}

module appService './modules/app-service.bicep' = {
  name: 'app-service'
  params: {
    managedIdentityResourceId: managedIdentity.outputs.resourceId
    managedIdentityClientId: managedIdentity.outputs.clientId
  }
  dependsOn: [
    acrRoleAssignment
  ]
}