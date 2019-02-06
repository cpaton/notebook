$sourceRoot = $PSScriptRoot
$outputFolder = Join-Path -Path $sourceRoot -ChildPath "output"

docker container run --platform=linux --name notebook-nginx --volume "$($outputFolder):/usr/share/nginx/html:ro" --publish 8080:80 --detach --rm nginx
Start-Process "http://localhost:8080"