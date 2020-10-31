 #!/bin/bash

# ---
# While loop.
# ---
source ./f.sh
process_argument "${command[1]}"
loops_i[${#loops_i[@]}]=1
loops_id[${#loops_id[@]}]=$i1
loops_max[${#loops_max[@]}]="${PRG[$(($i1-1))]}"
source ./cmds/4.sh 1
if ((gate_output == 0)); then
	pos=0
	until [ "${command[0]}" = "3" ] && [ "$pos" = "0" ]; do
		i1="$(($i1+1))"
		process_command "${PRG[$(($i1-1))]}"
		if [[ "${command[0]}" = "2" ]] || [[ "${command[0]}" = "7" ]]; then
			pos="$(($pos+1))"
		elif [[ "${command[0]}" = "3" ]] && ((pos > 0)); then
			pos="$(($pos-1))"
		fi
	done
fi
