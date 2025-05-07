#!/bin/bash

text=$(bluetoothctl devices Connected | cut -f2 -d' ' | while read uuid; do bluetoothctl info $uuid; done|grep -e "Name" | cut -f2 -d':')

echo $text
