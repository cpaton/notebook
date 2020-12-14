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
    $GhPagesBranchRelativePath = $('.build/gh-pages')
)

$ghPagesPath = Join-Path $WorkspaceRoot $GhPagesBranchRelativePath
$outputPath = Join-Path $WorkspaceRoot $OutputRelativePath

Write-Host @"
             Script : $($PSCmdlet.MyInvocation.MyCommand.Definition)
          Timestamp : $([DateTime]::UtcNow.ToString("dddd, dd MMM yyyy HH:mm:ss"))
     Workspace Root : $WorkspaceRoot
gh-ages Branch Root : $ghPagesPath
        Output Root : $outputPath
"@

if (-not (Test-Path $ghPagesPath))
{
    throw "gh-pages path $ghPagesPath does not exist"
}

if (-not (Test-Path $outputPath))
{
    throw "Output Path $outputPath does not exist"
}

Push-Location $ghPagesPath
try
{
    # Clear the current branch files and copy in the latest build output
    git rm -rf .
    Copy-Item -Path "$outputPath/*" -Destination $ghPagesPath -Recurse -Verbose

    # Prepare for the commit
    git config --local user.email "craigpaton@gmail.com"
    git config --local user.name "Craig Paton"

    # Commit the latest chaanges
    git add -A
    git status
    git commit -a -m "Build update"

    # Push the chnanges
    git push
}
finally
{
    Pop-Location
}