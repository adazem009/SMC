#!/bin/bash

# ---
# The end of the last loop.
# ---
source ./f.sh
if [[ "${loops_max[$((${#loops_max[@]}-1))]:1:1}" = "/" ]]; then
	# End of while loop
	process_command "${loops_max[$((${#loops_max[@]}-1))]}"
	source ./cmds/4.sh 1
	if ((gate_output == 1)); then
		loops_i[$((${#loops_i[@]}-1))]="$(($c3i1+1))"
		i1=${loops_id[$((${#loops_id[@]}-1))]}
	else
		unset 'loops_i[${#loops_i[@]}-1]'
		unset 'loops_id[${#loops_id[@]}-1]'
		unset 'loops_max[${#loops_max[@]}-1]'
	fi
else
	# End of repeat loop
	c3i1="${loops_i[$((${#loops_i[@]}-1))]}"
	c3i2="${loops_max[$((${#loops_max[@]}-1))]}"
	if ((c3i1 < c3i2)); then
		loops_i[$((${#loops_i[@]}-1))]="$(($c3i1+1))"
		i1=${loops_id[$((${#loops_id[@]}-1))]}
	else
		unset 'loops_i[${#loops_i[@]}-1]'
		unset 'loops_id[${#loops_id[@]}-1]'
		unset 'loops_max[${#loops_max[@]}-1]'
	fi
fi
