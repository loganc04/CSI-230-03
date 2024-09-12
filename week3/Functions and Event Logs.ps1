Get-EventLog System -source Microsoft-Windows-Winlogon

$loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.count; $i++) {
$event = ""
if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}

$user = $loginouts[$i].ReplacementStrings[1]

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
"Id" = $loginouts[$i].InstanceId; `
"Event" = $event; `
"User" = $user;
}
}

$loginoutsTable | Format-Table -AutoSize -Wrap


$loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.count; $i++) {
$event = ""
if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}

$user = $loginouts[$i].ReplacementStrings[1]
# shellgeek.com/convert-sid-to-username-in-powershell-and-cmd

$userSID = New-Object System.Security.Principal.SecurityIdentifier($user)

$userName = $userSID.Translate([System.Security.Principal.NTAccount])

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
"Id" = $loginouts[$i].InstanceId; `
"Event" = $event; `
"User" = $userName.Value;
}
}

$loginoutsTable | Format-Table -AutoSize -Wrap



function getLogsFromDays($numDays) {
Write-Host "Printing logon logs for $numDays days..."
$loginouts = Get-EventLog System -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$numDays)

$loginoutsTable = @()
for ($i=0; $i -lt $loginouts.count; $i++) {
$event = ""
if($loginouts[$i].InstanceId -eq 7001) {$event="Logon"}
if($loginouts[$i].InstanceId -eq 7002) {$event="Logoff"}

$user = $loginouts[$i].ReplacementStrings[1]


# shellgeek.com/convert-sid-to-username-in-powershell-and-cmd
$userSID = New-Object System.Security.Principal.SecurityIdentifier($user)

$userName = $userSID.Translate([System.Security.Principal.NTAccount])

$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
"Id" = $loginouts[$i].InstanceId; `
"Event" = $event; `
"User" = $userName.Value;
}
}

$loginoutsTable | Format-Table -AutoSize -Wrap
}


$logs = getLogsFromDays(3)
$logs



function getPowerLogs($numDays) {
Write-Host "Prining power logs for $numDays days..."
# Originally, this was
# $powerTimes = Get-EventLog System -source Microsoft-Windows-EventLog
##
# Remove "-source Microsoft-Windows-EventLog" to get all logs
$powerTimes = Get-EventLog System -After (Get-Date).AddDays(-$numDays)

$powerTable = @()
for ($i=0; $i -lt $powerTimes.count; $i++) {
    $powerEvent = ""
    if($powerTimes[$i].EventID -eq "6006") {$powerEvent="Shutdown"}
    elseif($powerTimes[$i].EventID -eq "6005") {$powerEvent="Startup"} # Add an else if so it only get two events
    else {continue} # if the IDs don't match, move on


$powerTable += [pscustomobject]@{"Time" = $powerTimes[$i].TimeGenerated; `
                                         "Id" = $powerTimes[$i].EventID; `
                                         "Event" = $powerEvent; `
                                         "User" = "System";
    }
}

$powerTable | Format-Table -AutoSize -Wrap
}

$logs = getPowerLogs
$logs