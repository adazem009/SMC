#!/bin/bash

# ---
# Get letter of a string and save it in variable(s).
# 12/[string],[letter]/[variable(s)]
# ---
source ./f.sh
process_argument "${command[1]}"
temp4="${argument[1]:$((${argument[0]}-1)):1}"
process_argument "${command[2]}"
i3=0
while ((i3 < ${#argument[@]})); do
	i3=$((i3+1))
	set_var "${argument[$((i3-1))]}" "$temp4"
done
