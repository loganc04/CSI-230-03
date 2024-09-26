. (Join-Path $PSScriptRoot "Apache-Function.ps1")
cls

$apacheFunction = ApacheLogs1 | Format-Table -AutoSize -Wrap
$apacheFunction