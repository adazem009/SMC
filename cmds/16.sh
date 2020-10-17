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
	set_var ${argument[0]} ${argument[1]}
done
