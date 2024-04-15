param plan_name string
param app_location string

resource plan_resource 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: plan_name
  location: app_location
  sku: {
    name: 'B1'
  }
  kind: 'linux'
  properties: {
    perSiteScaling: false
    elasticScaleEnabled: false
    maximumElasticWorkerCount: 1
    isSpot: false
    reserved: true
    isXenon: false
    hyperV: false
    targetWorkerCount: 0
    targetWorkerSizeId: 0
    zoneRedundant: false
  }
}

output id string = plan_resource.id
