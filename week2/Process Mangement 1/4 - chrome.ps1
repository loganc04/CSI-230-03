$Chrome = Get-Process | Where-Object { $_.Name -ilike "*chrome*" }
if ($Chrome) {
$Chrome | Stop-Process
} else {
Start-Process -FilePath Chrome -Args "https://champlain.edu"
}