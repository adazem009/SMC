#!/bin/bash

# ---
# Get length of list.
# 19/[list name]/[variable(s)]
# ---
source ./f.sh
process_argument "${command[1]}"
tmp0='!'
temp4="$(wc -l < "./misc/.lists/${argument[0]}")"
process_argument "${command[2]}"
i3=0
while ((i3 < ${#argument[@]})); do
	i3=$((i3+1))
	set_var "${argument[$((i3-1))]}" "$temp4"
done
