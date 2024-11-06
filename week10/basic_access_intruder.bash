#!/bin/bash

for i in {1..20}
do
	curl 10.0.17.34
	curl 10.0.17.34/page1.html
	curl 10.0.17.34/page2.html
done
