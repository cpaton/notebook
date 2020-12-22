#! /usr/bin/env pwsh

[CmdletBinding()]
param
(
    # Relative path to where output should be copied
    [Parameter(Mandatory = $false)]
    [string]
    $OutputRelative = $(".build/output")
)

$ErrorActionPreference = "Stop"

$repositoryRoot = Join-Path $PSScriptRoot ".." -Resolve
$outputFolder = Join-Path -Path $repositoryRoot -ChildPath $OutputRelative

Write-Host "Building docker image ..."
$env:DOCKER_BUILDKIT=1
docker build --tag capaton/notebook --file Dockerfile .
$dockerBuildExitCode = $LASTEXITCODE
Write-Host "Docker Build Exit Code : $dockerBuildExitCode"
if ($dockerBuildExitCode -ne 0)
{
    throw "Failed to build docker file. See above for details"
}
Write-Host "Docker image built"

Write-Host "Creating container from image"
docker container create --name notebook-build capaton/notebook
try
{
    if ( Test-Path -Path $outputFolder )
    {
        Remove-Item -Path $outputFolder -Recurse
    }
    $outputParentFolder = Split-Path $outputFolder -Parent
    if (-not (Test-Path -Path $outputParentFolder))
    {
        New-Item -Path $outputParentFolder -ItemType Directory -Force | Out-Null
    }

    docker container cp notebook-build:/usr/share/nginx/html "$outputFolder"
    if ($LASTEXITCODE -ne 0)
    {
        throw "Failed to copy output from within docker container"
    }
}
finally
{
    docker container rm notebook-build
}