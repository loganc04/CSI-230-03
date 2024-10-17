function getTable() {
$scrapped = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.5/IOC.html

$page=$scrapped.ParsedHtml.body.getElementsByTagName("tr")

$FullTable = @()

for($i=1; $i -lt $page.length; $i++) {
    $tds = $page[$i].getElementsByTagName("td")

    $FullTable += [pscustomobject]@{"Pattern" = $tds[0].innerHTML; `
                                    "Explanation" = $tds[1].innerHTML
}
}
return $FullTable
}
getTable