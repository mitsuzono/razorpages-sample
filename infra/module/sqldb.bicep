param sql_name string
@secure()
param sql_login_id string
@secure()
param sql_login_pass string
param sqldb_name string
param location string

resource sql_resource 'Microsoft.Sql/servers@2023-05-01-preview' = {
  name: sql_name
  location: location
  properties: {
    administratorLogin: sql_login_id
    administratorLoginPassword: sql_login_pass
    version: '12.0'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
  }
}

resource sqldb_resource 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  parent: sql_resource
  name: sqldb_name
  location: location
  sku: {
    name: 'GP_S_Gen5'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 2
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 34359738368
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    readScale: 'Disabled'
    autoPauseDelay: 60
    requestedBackupStorageRedundancy: 'Local'
    isLedgerOn: false
    availabilityZone: 'NoPreference'
    // Free Offer
    // useFreeLimit: true
    // freeLimitExhaustionBehavior: 'AutoPause'
  }
}
