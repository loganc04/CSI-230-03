cd $PSScriptRoot
$files=(Get-ChildItem)

$folderpath = "$PSScriptRoot/outfolder/"
$filePath = New-Item -Path $folderpath -Name "out.csv"

$files | Where-Object -Filter { $_.Extension -eq ".ps1" } | Select-Object Name | Export-Csv -Path $filePath