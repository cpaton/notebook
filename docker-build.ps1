[CmdletBinding()]
param
(
    # Relative path to where output should be copied
    [Parameter(Mandatory = $false)]
    [string]
    $OutputRelative = $("output")
)

$ErrorActionPreference = "Stop"

$scriptFolder = $PSScriptRoot
$outputFolder = Join-Path -Path $scriptFolder -ChildPath $OutputRelative

Write-Host "Building docker image ..."
docker build --tag capaton/notebook --file Dockerfile-build .
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

    docker container cp notebook-build:c:\app\output "$outputFolder"
}
finally
{
    docker container rm notebook-build
}
