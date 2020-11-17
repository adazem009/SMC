#!/bin/bash

# ---
# Insert item to list
# 17/[item],[string]/[list name]
# ---
source ./f.sh
process_argument "${command[2]}"
temp4="${argument[0]}"
process_argument "${command[1]}"
echo > ./misc/.list && rm ./misc/.list
i3=0
tmplen="$(wc -l < "./misc/.lists/$temp4")"
tmplen="$((tmplen+1))"
m=0
while ((i3 < tmplen)); do
	i3=$((i3+1))
	if [[ "$i3" = "${argument[0]}" ]]; then
		echo "${argument[1]}" >> "./misc/.list"
		m=1
	else
		tmp0='!'
		echo "$(sed "$((i3-m))${tmp0}d" "./misc/.lists/$temp4")" >> "./misc/.list"
	fi
done
rm "./misc/.lists/$temp4" && mv ./misc/.list "./misc/.lists/$temp4"
