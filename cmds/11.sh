#!/bin/bash

# ---
# Ask and save to variable in input 2 of argument 2.
# ---
source ./f.sh
process_argument "${command[1]}"
echo
read -p "${argument[0]}" readtemp
set_var "${argument[1]}" "$readtemp"
