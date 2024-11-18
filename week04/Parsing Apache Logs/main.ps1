. (Join-Path $PSScriptRoot "Apache-Function.ps1")

$apacheFunction = ApacheLogs1 | Format-Table -AutoSize -Wrap
$apacheFunction