function ApacheLogs1() {
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
return $tableRecords | Where-Object { $_.IP -ilike "10.*" }
}
$tableRecords = ApacheLogs1
$tableRecords | Format-Table -AutoSize -Wrap