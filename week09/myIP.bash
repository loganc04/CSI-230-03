#!/bin/bash


ip addr | grep -o -E "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}" \
| awk '{print $1}' | head -n 2 | tail -n 1
