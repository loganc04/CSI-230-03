. (Join-Path $PSScriptRoot "classes.ps1")

$classes = gatherClasses
daysTranslator $classes


#i
$classes | Select-Object "Class Code", Instructor, Location, Days, "Time Start", "Time End" | where { $_."Instructor" -ilike "*Furkan*" }

#ii
$classes | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.days -contains "Monday") } | Sort-Object "Time Start" | Format-Table "Time Start", "Time End", "Class Code"

#iii
$ITSInstructors = $classes | Where-Object { ($_."Class Code" -ilike "SYS*" ) -or `
    ($_."Class Code" -ilike "NET*") -or `
    ($_."Class Code" -ilike "SEC*") -or `
    ($_."Class Code" -ilike "FOR*") -or `
    ($_."Class Code" -ilike "CSI*") -or `
    ($_."Class Code" -ilike "DAT*") } `
    | Sort-Object "Instructor" -Unique `
    | Format-Table "Instructor" -AutoSize
    
$ITSInstructors

#iv
$classes | Where { $_.Instructor -in $ITSInstructors.Instructor } `
    | Group-Object "Instructor" | Select-Object Count,Name | Sort-Object Count -Descending | Format-Table