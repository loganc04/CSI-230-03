. (Join-Path $PSScriptRoot "Functions and Event Logs.ps1")
clear

$loginoutsTable = getLogsFromDays(15)
$loginoutsTable

$shutdownTable = getPowerLogs(25)
$shutdownTable