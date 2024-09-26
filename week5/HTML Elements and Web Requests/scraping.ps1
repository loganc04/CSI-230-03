#9
$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.18/ToBeScraped.html

$scraped_page.Links.Count


#10
$scraped_page.Links


#11
$scraped_page.Links | Select-Object outerText, href


#12
$h2s=$scraped_page.ParsedHtml.body.getElementsByTagName("h2") | Select-Object outerText
$h2s


#13
$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | where { $_.getAttributeNode("class").Value -ilike "div-1" } | select innerText
$divs1 | Format-Table