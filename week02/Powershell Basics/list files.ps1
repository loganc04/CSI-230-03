cd $PSScriptRoot

$files=(Get-ChildItem)
for ($j=0; $j -le $files.length; $j++){
if ($files[$j].Name -ilike "*ps1") {
    Write-Host $files[$j].Name
}
}