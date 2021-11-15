//parameter für die intialisierung

param webAppName string = 'Clarcd2Test' // Generate  String for web app name
param sku string = 'P1v2' // The SKU of App Service Plan
param linuxFxVersion string = 'node|14-lts' // The runtime stack of web app
param location string = resourceGroup().location // Location for all resources
param repositoryUrl string = 'https://github.com/GartnerF/uebung2' //Git Repository
param branch string = 'master' // name des branches

//namen fuer AppServicePlan und Name der Webapp
var appServicePlanName = toLower('AppServicePlan-${webAppName}')
var webSiteName = toLower('gartnersuperduper-${webAppName}')


// AppSErvice Plan erstellen
resource appServicePlan 'Microsoft.Web/serverfarms@2020-06-01' = {
  name: appServicePlanName
  location: location
  properties: {
    reserved: true
  }
  sku: {
    name: sku
  }
  kind: 'linux'
}
// AppService erstellen
resource appService 'Microsoft.Web/sites@2020-06-01' = {
  name: webSiteName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: linuxFxVersion
    }
  }
}
//test
//Repository wo sich die Daten für das deployment befinden
resource srcControls 'Microsoft.Web/sites/sourcecontrols@2021-01-01' = {
  name: '${appService.name}/web'
  properties: {
    repoUrl: repositoryUrl
    branch: branch
    isManualIntegration: true
  }
}
