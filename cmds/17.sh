#!/bin/bash

# ---
# Round a value and write the result into variable(s).
# 11/[value],[number of digits]/[variable(s)]
# ---
process_argument ${command[1]}
temp2=$(/usr/bin/printf "%.*f" "${argument[1]}" "${argument[0]}")
lentemp=${#temp2}
temp3=""
i2=0
while ((i2 < lentemp)); do
	i2="$(($i2+1))"
	if [ "${temp2:$(($i2-1)):1}" = "," ]; then
		temp3="${temp3}."
	else
		temp3="${temp3}${temp2:$(($i2-1)):1}"
	fi
done
temp2="$temp3"
process_argument ${command[2]}
arglentemp=${#argument[@]}
i2=0
while ((i2 < arglentemp)); do
	i2="$(($i2+1))"
	set_var ${argument[$(($i2-1))]} "$temp2"
done
