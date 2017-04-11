#!/bin/bash

converter="/zynthian/zynthian-sw/plugins/dexed/bin/dx7sysex2lv2"

cd "$1"
echo "$1"
for fn in *.SYX; do
	echo $converter \"$fn\"
	$converter "$fn"
done

for fn in *.syx; do
	echo $converter \"$fn\"
	$converter "$fn"
done
