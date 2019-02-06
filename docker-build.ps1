[CmdletBinding()]
param
(
    # Relative path to where output should be copied
    [Parameter(Mandatory = $false)]
    [string]
    $OutputRelative = $("output")
)

$scriptFolder = $PSScriptRoot
$outputFolder = Resolve-Path -Path ( Join-Path -Path $scriptFolder -ChildPath $OutputRelative )

docker build --tag capaton/notebook --file Dockerfile-build .
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
