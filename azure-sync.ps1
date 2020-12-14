#! /usr/bin/env pwsh

[CmdletBinding()]
param(
    [Parameter()]
    [string]
    $WorkspaceRoot = $($env:GITHUB_WORKSPACE),
    [Parameter()]
    [string]
    $OutputRelativePath = $('output'),
    [Parameter()]
    [string]
    $AzureSubscriptionId = $($env:AZURE_SUBSCRIPTION_ID),
    [Parameter()]
    [string]
    $AzureServicePrincipal = $($env:AZURE_SERVICE_PRINCIPAL),
    [Parameter()]
    [string]
    $AzureConnectionString = $($env:AZURE_CONNECTION_STRING),
    [Parameter()]
    [string]
    $AzureBlobContainer = $('$web')
)

$ErrorActionPreference = "Stop"

$outputPath = Join-Path $WorkspaceRoot $OutputRelativePath

Write-Host @"
              Script : $($PSCmdlet.MyInvocation.MyCommand.Definition)
           Timestamp : $([DateTime]::UtcNow.ToString("dddd, dd MMM yyyy HH:mm:ss"))
      Workspace Root : $WorkspaceRoot
         Output Root : $outputPath
Azure BLOB Container : $AzureBlobContainer
"@

# Sync the output to the azure blob store
Write-Host "Sync to the Azure BLOB store"
az storage blob sync --connection-string $AzureConnectionString --source $outputPath --container $AzureBlobContainer
if ($LASTEXITCODE -ne 0)
{
    throw "Failed to sync output to Blob store"
}

# Login to Azure
Write-Host "Login to Azure with service principal"
$servicePrincipal = ConvertFrom-Json $AzureServicePrincipal
az login --service-principal --username $servicePrincipal.appId --password $servicePrincipal.password --tenant $servicePrincipal.tenant
if ($LASTEXITCODE -ne 0)
{
    throw "Failed to login to Azure"
}

# Purge the CDN profile
Write-Host "Purge the CDN profile"
az cdn endpoint purge --content-paths '/*' --subscription $AzureSubscriptionId --resource-group personal --profile-name CraigPaton --name craigpatonnotebook
if ($LASTEXITCODE -ne 0)
{
    throw "Failed to purge CDN profile"
}