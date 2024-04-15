param appi_name string
param log_resource_id string
param location string

resource appiresource 'microsoft.insights/components@2020-02-02' = {
  name: appi_name
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    Flow_Type: 'Redfield'
    Request_Source: 'IbizaAIExtension'
    RetentionInDays: 90
    WorkspaceResourceId: log_resource_id
    IngestionMode: 'LogAnalytics'
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

output id string = appiresource.id
output connectionString string = appiresource.properties.ConnectionString
output instrumentationKey string = appiresource.properties.InstrumentationKey
