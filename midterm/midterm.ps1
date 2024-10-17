function getTable() {
    $scrapped = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.5/IOC.html

    $page = $scrapped.ParsedHtml.body.getElementsByTagName("tr")

    $FullTable = @()

    for ($i = 1; $i -lt $page.length; $i++) {
        $tds = $page[$i].getElementsByTagName("td")

        $FullTable += [pscustomobject]@{"Pattern" = $tds[0].innerHTML; `
                "Explaination"                    = $tds[1].innerHTML
        }
    }
    return $FullTable
}
getTable


function ApacheLogs() {
    $visits = Get-Content -Path C:\users\champuser\Desktop\CSI-230\midterm\access.log
    $tableRecords = @()
    for ($i = 0; $i -lt $visits.Count; $i++) {
        $words = $visits[$i].Split(" ")
        $tableRecords += [pscustomobject]@{"IP" = $words[0]; `
                "Time"                          = $words[3].Trim('['); `
                "Method"                        = $words[5].Trim('"'); `
                "Page"                          = $words[6]; `
                "Protocol"                      = $words[7]; `
                "Response"                      = $words[8]; `
                "Referrer"                      = $words[10];
        }
    }
    return $tableRecords
}
ApacheLogs | Format-Table


function Challenge3($logFile, $indicator) {
    $visits = Get-Content -Path C:\users\champuser\Desktop\CSI-230\midterm\$logFile
    $tableRecords = @()
    for ($i = 0; $i -lt $visits.Count; $i++) {
        $words = $visits[$i].Split(" ")
        $tableRecords += [pscustomobject]@{"IP" = $words[0]; `
                "Time"                          = $words[3].Trim('['); `
                "Method"                        = $words[5].Trim('"'); `
                "Page"                          = $words[6]; `
                "Protocol"                      = $words[7]; `
                "Response"                      = $words[8]; `
                "Referrer"                      = $words[10];
        }
    }
    # Modified from https://www.oreilly.com/library/view/regular-expressions-cookbook/9780596802837/ch07s13.html
    return $tableRecords | Where-Object { $_.Page -match ".$indicator.*\?([^#]+)" } | Format-Table
}
Challenge3 access.log index