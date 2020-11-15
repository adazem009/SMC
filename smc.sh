#!/bin/bash

# -----
# SMC source code
# 2020 - adazem009
# -----
#
# f.sh - functions file
source ./f.sh
# --- Check if program file exists ---
FILE=./program.smc
if test -f "$FILE"; then
	# Nothing here
	:
else
	echo "Error: Couldn't open ${FILE}."
	read -n 1 -s -r -p "Press any key to continue..."
	exit 1
fi
# --- Init ---
echo > ./misc/.screen # Temporary screen file
characters="$(cat ./options/chars.txt)"
IFS=$'\r\n' GLOBIGNORE='*' command eval  'PRG=($(cat $FILE))'
prg_len="${#PRG[@]}"
var_names=()
var_values=()
clear
loops_i=()
loops_id=()
loops_max=()
if [ -d "./misc/.lists" ]; then
	rm -rf ./misc/.lists
fi
mkdir ./misc/.lists
# --- Execute commands ---
i1=0
while (( i1 < prg_len )); do
	i1="$(($i1+1))"
	process_command "${PRG[$(($i1-1))]}"
	execute
done
rm ./misc/.screen
rm -rf ./misc/.lists
# --- The end ---
#echo && echo "-----------"
printf "\n--------------------\nProcess completed, press any key to continue..."
read -n 1 -s -r
