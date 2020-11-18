#!/bin/bash

# ---
# Number: Go forward a number of lines,
# !Number: Jump to a line.
# ---
source ./f.sh
process_argument "${command[1]}"
temp1="${argument[0]}"
if [[ "${temp1:0:1}" = '!' ]]; then
	temp=""
	i2=1
	arglentemp="${argument[0]}"
	arglentemp=${#arglentemp}
	while ((i2 < arglentemp)); do
		i2="$(($i2+1))"
		temp="${temp}${temp1:$(($i2-1)):1}"
	done
	i1="$(($temp-1))"
else
	i1="$(($i1+${argument[0]}-1))"
fi
