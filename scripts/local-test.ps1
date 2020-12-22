$repositoryRoot = Join-Path $PSScriptRoot ".." -Resolve
$outputFolder = Join-Path -Path $repositoryRoot -ChildPath ".build/output"

$cmd = "dotnet serve --open-browser --directory $outputFolder"
Write-Host $cmd
Invoke-Expression $cmd