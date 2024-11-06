#!/bin/bash

allLogs=""
file="/var/log/apache2/access.log"


function getAllLogs() {
allLogs=$(cat "$file" | cut -d ' ' -f1,4,7 | tr -d "[")
}

function ips(){
ipsAccessed=$(echo "$allLogs" | cut -d ' ' -f1)
}

function getPageCounts() {
	allLogs=$(cat "$file" | cut -d ' ' -f7 | tr -d "["  | sort | uniq -c)
}
getAllLogs
ips
#echo "$ipsAccessed"

getPageCounts
echo "$allLogs"
