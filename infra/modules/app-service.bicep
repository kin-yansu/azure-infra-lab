param managedIdentityResourceId string
param managedIdentityClientId string

resource appServicePlan 'Microsoft.Web/serverfarms@2025-03-01' = {
    name: 'kinfatman0001toyserviceplan'
    location: 'japaneast'
    sku: {
        name: 'S1'
        tier: 'Standard'
        capacity: 1
    }
    kind: 'linux'
    properties: {
        reserved: true
    }
}

resource appWebApp 'Microsoft.Web/sites@2025-03-01' = {
    name: 'kinfatman0001toyappservice'
    location: 'japaneast'
    kind: 'app,linux,container'
    properties: {
        httpsOnly: true
        serverFarmId: appServicePlan.id
        siteConfig: {
            linuxFxVersion: 'DOCKER|kinfatman0001toyacr.azurecr.io/kinfatman0001toyapp:v1'
            acrUseManagedIdentityCreds: true
            acrUserManagedIdentityID: managedIdentityClientId
            alwaysOn: true
            appSettings: [
                {
                    name: 'DOCKER_REGISTRY_SERVER_URL'
                    value: 'https://kinfatman0001toyacr.azurecr.io'
                }
                {
                    name: 'WEBSITES_PORT'
                    value: '8000'
                }
                {
                    name: 'APP_ENV'
                    value: 'production'
                }
                {
                    name: 'APP_DEBUG'
                    value: 'production'
                }
                {
                    name: 'PRODUCTION_SLOT_ONLY'
                    value: 'production_slot_only'
                }
            ]
        }
    }
    identity: {
      type: 'UserAssigned'
      userAssignedIdentities: {
        '${managedIdentityResourceId}': {}
      }
    }
}

resource stagingSlot 'Microsoft.Web/sites/slots@2025-03-01' = {
    parent: appWebApp
    name: 'staging'
    location: 'japaneast'
    kind: 'app,linux,container'
    properties: {
        httpsOnly: true
        serverFarmId: appServicePlan.id
        siteConfig: {
            linuxFxVersion: 'DOCKER|kinfatman0001toyacr.azurecr.io/kinfatman0001toyapp:v1'
            acrUseManagedIdentityCreds: true
            acrUserManagedIdentityID: managedIdentityClientId            alwaysOn: true
            appSettings: [
                {
                    name: 'DOCKER_REGISTRY_SERVER_URL'
                    value: 'https://kinfatman0001toyacr.azurecr.io'
                }
                {
                    name: 'WEBSITES_PORT'
                    value: '8000'
                }
                {
                    name: 'APP_ENV'
                    value: 'staging'
                }
                {
                    name: 'APP_DEBUG'
                    value: 'staging'
                }
                {
                    name: 'STAGING_SLOT_ONLY'
                    value: 'staging_slot_only'
                }
            ]
        }
    }
    identity: {
      type: 'UserAssigned'
      userAssignedIdentities: {
        '${managedIdentityResourceId}': {}
      }
    }
}

