#!/bin/bash

# ---
# Setup list(s).
# 14/[list name(s)]/[items]
# ---
source ./f.sh
process_argument "${command[2]}"
echo > ./misc/.list && rm ./misc/.list
i3=0
while ((i3 < ${#argument[@]})); do
	i3=$((i3+1))
	echo "${argument[$((i3-1))]}" >> ./misc/.list
done
process_argument "${command[1]}"
i3=0
while ((i3 < ${#argument[@]})); do
	i3=$((i3+1))
	if [ -f "./misc/.lists/${argument[$((i3-1))]}" ]; then
		rm "./misc/.lists/${argument[$((i3-1))]}"
	fi
	cp ./misc/.list "./misc/.lists/${argument[$((i3-1))]}"
done
rm ./misc/.list
