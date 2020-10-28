#!/bin/bash

# ---
# Else.
# ---
source ./f.sh
pos=1
process_command "${PRG[$(($i1-1))]}"
until [ "${command[0]}" = "5" ] && ((pos == 0)); do
	i1="$(($i1+1))"
	process_command "${PRG[$(($i1-1))]}"
	if [ "${command[0]}" = "4" ]; then
		pos="$(($pos+1))"
	elif [ "${command[0]}" = "5" ]; then
		pos="$(($pos-1))"
	fi
done
