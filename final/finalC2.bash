#! /bin/bash


tail $1 | egrep -i -f /home/champuser/CSI-230/final/$2 | cut -d ' ' -f1 | uniq -c
