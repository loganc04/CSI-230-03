﻿Get-Service | Where-Object -Filter {$_.Status -eq "Stopped" } | Sort-Object | Export-Csv "out.csv"