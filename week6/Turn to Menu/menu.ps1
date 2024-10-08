. (Join-Path $PSScriptRoot Event-Logs.ps1)
. (Join-Path $PSScriptRoot "Apache-Function.ps1")
#clear

$Prompt = "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins`n"
$Prompt += "3 - Display at-risk users`n"
$Prompt += "4 - Start Chrome`n"
$Prompt += "5 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 

    } elseif ($choice -eq 1) {
   $logs = ApacheLogs1
   $logs | Out-String
 
    

    } elseif ($choice -eq 2) {
    $failedLogins = getFailedLogins(90)
    $failedLogins | Out-String


    } elseif ($choice -eq 3) {
    $risks = getAtRiskUsers(90)
    $risks | Out-String

    } elseif ($choice -eq 4) {
        $Chrome = Get-Process | Where-Object {$_.Name -ilike "*chrome*" }
    if ($Chrome) {
    Write-Host "Closing Chrome..."
        $Chrome | Stop-Process
    } else {
    Write-Host "Starting Chrome..."
        Start-Process -FilePath Chrome -Args "https://champlain.edu"
    }
    } else {
     Write-Host "Invalid choice. Please try again."
    }

    }