#!/bin/bash

# ---
# Wait for a(ny) key to be pressed.
# Input 1 of argument 2 is the key.
# Input 2 of argument 2 (0 or 1) toggles release waiting. It'll wait until you release the key after you pressed it.
# ---
source ./f.sh
process_argument "${command[1]}"
if [ "${argument[0]}" = "" ]; then
	wait_for_key any
else
	wait_for_key "${argument[0]}"
fi
### INVERSE IS NOT SUPPORTED YET ###
#if [ "${argument[1]}" = "1" ]; then
#	if [ "${argument[0]}" = "" ]; then
#		wait_for_key any 1
#	else
#		wait_for_key "${argument[0]}" 1
#	fi
#fi
