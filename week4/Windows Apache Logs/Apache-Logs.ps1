function Get-VisitedIPs {
param (
[string]$page,
[int]$httpCode,
[string]$browser
)
$visits = Get-Content -Path C:\xampp\apache\logs\access.log

$tableRecords = @()

for($i=0; $i -lt $visits.Count; $i++) {
$words = $visits[$i].Split(" ")

$tableRecords += [pscustomobject]@{ "IP" = $words[0]; `
                                    "Time" = $words[3].Trim('['); `
                                    "Method" = $words[5].Trim('"'); `
                                    "Page" = $words[6]; `
                                    "Protocol" = $words[7]; `
                                    "Response" = $words[8]; `
                                    "Referrer" = $words[10]; `
                                    "Client" = $words[11..($words.Length)]; }
                                 
}
return $tableRecords | Where-Object { ($_.Page -ilike $page) -or ($_.Response -ilike $httpCode) -or ($_.Client -ilike $browser) }
}
$tableRecords = Get-VisitedIPs
$tableRecords | Format-Table -AutoSize -Wrap


#Get-VisitedIPs("page1.html", "200", "Mozilla")
Get-VisitedIPs -page "page1.html" -httpCode 200 -browser "Mozilla" | Format-Table -AutoSize -Wrap