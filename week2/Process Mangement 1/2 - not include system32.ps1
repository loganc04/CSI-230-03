﻿Get-Process | Where-Object { $_.Path -inotlike "system32" }