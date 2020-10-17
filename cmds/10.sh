#!/bin/bash
# ---
# Print.
# ---
source ./f.sh
process_argument "${command[1]}"
print="${argument[0]}"
scrfile="./misc/.screen"
IFS=$'\r\n' GLOBIGNORE='*' command eval  'SCR=($(cat $scrfile))'
scrlen="${#SCR}"
printf "%s" "$print" >> ./misc/.screen
if ((scrlen == 0)); then
	sed '1d' ./misc/.screen > ./misc/.tmp1; mv ./misc/.tmp1 ./misc/.screen
fi

