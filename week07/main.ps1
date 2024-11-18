. (Join-Path $PSScriptRoot "Email.ps1")
. (Join-Path $PSScriptRoot "Configuration.ps1")
. (Join-Path $PSScriptRoot "Scheduler1.ps1")
. (Join-Path $PSScriptRoot "Event-Logs.ps1")
. (Join-Path $PSScriptRoot "String-Helper.ps1")




$configuration = readConfiguration

$Failed = getAtRiskUsers $configuration.Days

SendAlertEmail ($Failed | Format-Table | Out-String)

ChooseTimeToRun($configuration.Time)