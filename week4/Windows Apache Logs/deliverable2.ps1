#3 List all of the apache logs of xampp
Get-Content -Path C:\xampp\apache\logs\access.log




#4 List only last 5 logs
Get-Content -Path C:\xampp\apache\logs\access.log -TotalCount 5




#5 Display only 404 or 400 logs
Get-Content -Path C:\xampp\apache\logs\access.log | Select-String ' 404 ',' 400 '




#6 Logs that do NOT contain 200
Get-Content -Path C:\xampp\apache\logs\access.log | Select-String -Pattern ' 200 ' -NotMatch




#7 From every .log file, only get logs that contain 'error'
$A = Get-Content -Path C:\xampp\apache\logs\*.log | Select-String -Pattern 'error'
# Display last 5 elements of array
$A[5..1]




#8 Display only IP addresses for 404s
$notfounds = Get-Content -Path C:\xampp\apache\logs\access.log | Select-String -Pattern '404'

$regex = [regex] "\d{1,3}.\d{1,3}.\d{1,3}.\d{1,3}"

$ipsUnorganized = $regex.Matches($notfounds)

$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++) {
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value; }
}
$ips | Where-Object { $_.IP -ilike "10.*" } | Format-Table




#9 Count ips from 8
$ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group-Object IP
$counts | Select-Object Count, Name | Format-Table