function readConfiguration {
    $text = Get-Content -Path .\configuration.txt
    # stackoverflow.com/questions/39252620
    $words = $text.Split([Environment]::NewLine, [StringSplitOptions]::RemoveEmptyEntries)
    if ($words[1] -notmatch "^\d{1,2}:\d{1,2} [AP]M$") {
        Write-Host "Invalid data in config file." | Out-String
    }
    else {
        $config = [PSCustomObject]@{
            "Days" = $words[0];
            "Time" = $words[1];
        }
        return $config
    }  
}


function changeConfiguration {
    $daysValid = $false
    $timeValid = $false

    while ($daysValid -eq $false) {
        Write-Host "Enter the number of days for which the logs will be obtained: " | Out-String
        $newConfigDays = Read-Host
        if ($newConfigDays -match "\d{1,3}") {
            $daysValid = $true  
        }
        else {
            Write-Host "Invalid time. Please try again." | Out-String
            $daysValid = $false
        }
    }

    while ($timeValid -eq $false) {
        Write-Host "Enter the daily execution time for the script: (H:MM AM/PM)" | Out-String
        $newConfigTime = Read-Host
        if ($newConfigTime -match "^[0-9]:[0-5][0-9] [AP]M$") {
            $timeValid = $true  
        }
        else {
            Write-Host "Invalid time. Please try again." | Out-String
            $timeValid = $false
        }
    }

    Write-Host "Writing new configuration..." | Out-String
    $newConfig = "$newConfigDays`n$newConfigTime" | Out-File -FilePath .\configuration.txt
    Write-Host "Wrote new configuration." | Out-String
}

function configurationMenu {
    $Menu = "Select an option:`n"
    $Menu += "1. Show configuration`n"
    $Menu += "2. Change configuration`n"
    $Menu += "3. Exit`n"
    
    $running = $true
    while ($running) {
        Write-Host $Menu | Out-String
        $choice = Read-Host
    
        if ($choice -eq 1) {
            Write-Host "Current configuration:`n" | Out-String
            $config = readConfiguration
            $config | Out-String
        }
        elseif ($choice -eq 2) {
            changeConfiguration
          
        }
        elseif ($choice -eq 3) {
            Write-Host "Goodbye." | Out-String
            exit
            $running = $false
    
        }
        else {
            Write-Host "Invalid input. Try again."
        }
    
    }
}