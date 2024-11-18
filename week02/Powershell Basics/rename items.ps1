$files=Get-ChildItem -Recurse -File
$files | Rename-Item -NewName {$_.Name -replace '.csv', '.log' }
Get-ChildItem -Path "$PSScriptRoot/outfolder"