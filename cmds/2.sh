#!/bin/bash

# ---
# Loop.
# ---
source ./f.sh
process_argument ${command[1]}
loops_i[${#loops_i[@]}]="1"
loops_id[${#loops_id[@]}]="$i1"
loops_max[${#loops_max[@]}]="${argument[0]}"
