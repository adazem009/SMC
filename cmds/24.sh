#!/bin/bash

# ---
# Get item from list.
# 18/[list name],[item]/[variable(s)]
# ---
source ./f.sh
process_argument "${command[1]}"
tmp0='!'
temp4="$(sed "${argument[1]}${tmp0}d" "./misc/.lists/${argument[0]}")"
process_argument "${command[2]}"
i3=0
while ((i3 < ${#argument[@]})); do
	i3=$((i3+1))
	set_var "${argument[$((i3-1))]}" "$temp4"
done
