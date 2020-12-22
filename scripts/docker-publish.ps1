#! /usr/bin/env pwsh

[CmdletBinding()]
param()

$ErrorActionPreference = "Stop"

$dockerUsername = $env:DOCKER_USER_NAME
$dockerPassword = $env:DOCKER_PASSWORD

if ([string]::IsNullOrWhiteSpace($dockerUsername))
{
    throw "DOCKER_USER_NAME environment variable must be set"
}

if ([string]::IsNullOrWhiteSpace($dockerPassword))
{
    throw "DOCKER_PASSWORD environment variable must be set"
}

$loginCmd = "docker login --password-stdin --username $dockerUsername"
Write-Host $loginCmd
Invoke-Expression "'$dockerPassword' | $loginCmd"

if ($LASTEXITCODE -ne 0)
{
    throw "Failed to login to docker hub"
}

try
{
    $pushCommand = "docker push capaton/notebook:latest"
    Write-Host $pushCommand
    Invoke-Expression $pushCommand

    if ($LASTEXITCODE -ne 0)
    {
        throw "Failed to push docker image"
    }
}
finally
{
    $logoutCmd = 'docker logout'
    Write-Host $logoutCmd
    Invoke-Expression $logoutCmd
}