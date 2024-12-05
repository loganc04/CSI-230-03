#! /bin/bash


cat $1 | cut -d ' ' -f1,4,7 | tr -d "[" | sort | egrep -i -f $2 > report.txt
