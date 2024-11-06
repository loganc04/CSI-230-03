#!/bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function countCurlAccess() {
	curlLogs=$(cat "$file" | grep "curl" |  cut -d ' ' -f1,12 | tr -d "[" | sort | uniq -c)
}

countCurlAccess
echo "$curlLogs"
