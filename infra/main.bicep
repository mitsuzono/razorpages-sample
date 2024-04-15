param resource_suffix string
@secure()
param sql_login_id string
@secure()
param sql_login_pass string

param location string = 'japaneast'
param app_location string = 'Japan East'

param app_name string = 'app-${resource_suffix}'
param sql_name string = 'sql-${resource_suffix}'
param sqldb_name string = 'sqldb-${resource_suffix}'
param plan_name string = 'plan-${resource_suffix}'
param appi_name string = 'appi-${resource_suffix}'
param log_name string = 'log-${resource_suffix}'

module logAnalyticsModule 'module/log.bicep' = {
  name: 'logAnalyticsDeploy'
  params: {
    log_name: log_name
    location: location
  }
}

module applicationInsightsModule 'module/appi.bicep' = {
  name: 'applicationInsightsDeploy'
  params: {
    appi_name: appi_name
    log_resource_id: logAnalyticsModule.outputs.id
    location: location
  }
}

module sqlDatabaseModule 'module/sqldb.bicep' = {
  name: 'sqlDatabaseDeploy'
  params: {
    sql_name: sql_name
    sql_login_id: sql_login_id
    sql_login_pass: sql_login_pass
    sqldb_name: sqldb_name
    location: location
  }
}

module appServicePlanModule 'module/plan.bicep' = {
  name: 'appServicePlanDeploy'
  params: {
    plan_name: plan_name
    app_location: app_location
  }
}

module webAppModule 'module/app.bicep' = {
  name: 'webAppDeploy'
  params: {
    app_name: app_name
    plan_resource_id: appServicePlanModule.outputs.id
    appSettings: [
      {
        name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
        value: applicationInsightsModule.outputs.instrumentationKey
      }
      {
        name: 'APPLICATIONINSIGHTS_CONNECTION_STRING'
        value: applicationInsightsModule.outputs.connectionString
      }
      {
        name: 'ApplicationInsightsAgent_EXTENSION_VERSION'
        value: '~3'
      }
      {
        name: 'XDT_MicrosoftApplicationInsights_Mode'
        value: 'recommended'
      }
    ]
    sqldbConnectionString: 'Server=tcp:${sql_name}.database.windows.net,1433;Initial Catalog=${sqldb_name};Persist Security Info=False;User ID=${sql_login_id};Password=${sql_login_pass};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
    app_location: app_location
  }
}
