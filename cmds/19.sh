#!/bin/bash

# ---
# Get length of a string and save it in variable(s).
# 13/[string]/[variable(s)].
# ---
source ./f.sh
process_argument "${command[1]}"
temp4="${#argument[0]}"
process_argument "${command[2]}"
i3=0
while ((i3 < ${#argument[@]})); do
	i3=$((i3+1))
	set_var "${argument[$((i3-1))]}" "$temp4"
done
