. (Join-Path $PSScriptRoot "String-Helper.ps1")
function getAtRiskUsers($timeBack){
  
  $atRiskLogins = Get-EventLog security -After (Get-Date).AddDays("-"+"$timeBack") | Where { $_.InstanceID -eq "4625" }
 
  $atRiskTable = @()
  for($i=0; $i -lt $atRiskLogins.Count; $i++){

    $account=""
    $domain="" 

    $usrlines = getMatchingLines $atRiskLogins[$i].Message "*Account Name*"
    $usr = $usrlines[1].Split(":")[1].trim()

    $dmnlines = getMatchingLines $atRiskLogins[$i].Message "*Account Domain*"
    $dmn = $dmnlines[1].Split(":")[1].trim()

    $user = $dmn+"\"+$usr;

    $atRiskTable += [pscustomobject]@{"User" = $user;}

    }
    $atRiskUsers = $atRiskTable | Group-Object User | Select-Object Name, Count | Where-Object {$_.Count -gt 10 }
    return $atRiskUsers
} 