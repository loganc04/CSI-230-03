function gatherClasses() {
$page = Invoke-WebRequest -TimeoutSec 5 http://10.0.17.18/Courses.html

$trs=$page.ParsedHtml.body.getElementsByTagName("tr")


$FullTable = @()
for($i=1; $i -lt $trs.length; $i++) {

$tds = $trs[$i].getElementsByTagName("td")

$Times = $tds[5].innerText.split("-")

$FullTable += [pscustomobject]@{"Class Code" = $tds[0].innerHTML; `
                                "Title" = $tds[1].getElementsByTagName("a")[0].innerHTML; `
                                "Days" = $tds[4].innerHTML; `
                                "Time Start" = $Times[0]; `
                                "Time End" = $Times[1]; `
                                "Instructor" = $tds[6].getElementsByTagName("a")[0].innerHTML; `
                                "Location" = $tds[9].innerHTML; `
                                }
}
return $FullTable
}


function daysTranslator($FullTable) {
    for ($i=0; $i -lt $FullTable.length; $i++) {
        $Days = @()

        if($FullTable[$i].Days -ilike "*M*") { $Days += "Monday" }
        if($FullTable[$i].Days -ilike "*T[WF]*") { $Days += "Tuesday" }
        if($FullTable[$i].Days -ilike "T") { $Days += "Tuesday" }
        if($FullTable[$i].Days -ilike "*W*") { $Days += "Wednesday" }
        if($FullTable[$i].Days -ilike "*TH*") { $Days += "Thursday" }
        if($FullTable[$i].Days -ilike "*F*") { $Days += "Friday" }

        $FullTable[$i].Days = $Days
    }
    return $FullTable
}
