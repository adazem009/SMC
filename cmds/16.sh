#!/bin/bash

# ---
# Set variable(s) to value(s).
# ---
source ./f.sh
i3=1
cmdlentemp="${#command[@]}"
while ((i3 < cmdlentemp)); do
	i3="$(($i3+1))"
	process_argument ${command[$(($i3-1))]}
    setas=""
    for (( countme=1; countme<=${#argument[@]}-1; countme++ ))
    do  
       setas+=${argument[${countme}]}
    done
	set_var ${argument[0]} ${setas}
done
