#! /bin/bash

echo "<html><head><style>table, th, td { border: 1px solid black;}</style><body>
<table><tr><th>IP</th><th>Date</th><th>Page</th></tr>" > report.html

logs=$(cat access.log | sort | egrep -i -f IOC.txt)

echo "$logs" | while read -r line;
do
	ip=$(echo $line | cut -d ' ' -f1)
	date=$(echo $line | cut -d ' ' -f4 | tr -d '[')
	page=$(echo $line | cut -d ' ' -f7)

	echo "<tr><td>$ip</td><td>$date</td><td>$page</td></tr>" >> report.html
done

echo "</table></body></html>" >> report.html

mv report.html /var/www/html/
