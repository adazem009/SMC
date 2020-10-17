#!/bin/bash

# ---
# Operations.
# F/[operation ID(s)]/[target variable(s)]/[inputs]/[scale]
# ---
source ./f.sh
scale=16 # Default scale
process_argument ${command[4]}
if [ "${argument[0]}" != "" ]; then
	scale="${argument[0]}"
fi
process_argument ${command[1]}
operations=()
operations[0]=""
i2=0
arglentemp=${#argument[@]}
while ((i2 < arglentemp)); do
	i2="$(($i2+1))"
	operations[${#operations[@]}]="${argument[$(($i2-1))]}"
done
process_argument ${command[3]}
arglentemp=${#argument[@]}
temp2=0
i2=0
while ((i2 < arglentemp)); do
	i2="$(($i2+1))"
	if ((i2 == 1)); then
		temp2=${argument[$(($i2-1))]}
	else
		case ${operations[$(($i2-1))]} in
			1)
				# Add
				temp2="$(echo "scale=${scale};${temp2}+${argument[$(($i2-1))]}" | bc)"
				;;
			
			2)
				# Subtract
				temp2="$(echo "scale=${scale};${temp2}-${argument[$(($i2-1))]}" | bc)"
				;;
			
			3)
				# Multiply
				temp2="$(echo "scale=${scale};${temp2}*${argument[$(($i2-1))]}" | bc)"
				;;
			
			4)
				# Divide
				temp2="$(echo "scale=${scale};${temp2}/${argument[$(($i2-1))]}" | bc)"
				;;
		esac
	fi
done
temp2=$(/usr/bin/printf "%.*f" "${scale}" "${temp2}")
lentemp=${#temp2}
temp4=0
i2=0
while ((i2 < lentemp)); do
	i2="$(($i2+1))"
	if [ "${temp2:$(($i2-1)):1}" = "," ]; then
		temp4=1
		break
	fi
done
temp3=""
zero=0
i2=$lentemp
while ((i2 > 0)); do
	if [ "${temp2:$(($i2-1)):1}" = "," ]; then
		if ((zero == 1)); then
			zero=1
			temp3=".${temp3}"
		fi
	elif [ "${temp2:$(($i2-1)):1}" = "0" ] && ((zero == 0)) && ((temp4 == 0)); then
		# Nothing here
		:
	else
		zero=1
		temp3="${temp2:$(($i2-1)):1}${temp3}"
	fi
	i2="$(($i2-1))"
done
temp2="$temp3"
process_argument ${command[2]}
arglentemp=${#argument[@]}
i2=0
while ((i2 < arglentemp)); do
	i2="$(($i2+1))"
	set_var ${argument[$(($i2-1))]} $temp2
done
