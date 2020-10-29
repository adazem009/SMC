#!/bin/bash

# ---
# If.
# 4/[value],[operator],[value],[! or nothing]/[gate]/[value],[operator],[value],[! or nothing]/ ...
# ---
source ./f.sh
gates=()
cmdlen=${#command[@]}
i3=1
while ((i3 < cmdlen)); do
	i3="$(($i3+1))"
	process_argument "${command[$(($i3-1))]}"
	if [ "$(($i3%2))" = "0" ]; then
		gate_output=0
		case ${argument[1]} in
			"==")
				# A1 equals A2
				if [ "${argument[0]}" = "${argument[2]}" ]; then
					gate_output=1
				else
					gate_output=0
				fi
				;;
			"!=")
				# NOT A1 equals A2
				if [ "${argument[0]}" != "${argument[2]}" ]; then
                                        gate_output=1
                                else
                                        gate_output=0
                                fi
                                ;;
			">")
				# A1 is greater than A2
				if ((${argument[0]} > ${argument[2]})); then
                                        gate_output=1
                                else
                                        gate_output=0
                                fi
                                ;;
			"!>")
				# NOT A1 is greater than A2
				if ! ((${argument[0]} > ${argument[2]})); then
                                        gate_output=1
                                else
                                        gate_output=0
                                fi
                                ;;
			"<")
				# A1 is lower than A2
				if ((${argument[0]} < ${argument[2]})); then
                                        gate_output=1
                                else
                                        gate_output=0
                                fi
                                ;;
			"!<")
				# NOT A1 is lower than A2
				if ! ((${argument[0]} < ${argument[2]})); then
                                        gate_output=1
                                else
                                        gate_output=0
                                fi
                                ;;
			">=")
				# A1 is greater or equal to A2
				if ((${argument[0]} >= ${argument[2]})); then
                                        gate_output=1
                                else
                                        gate_output=0
                                fi
                                ;;
			"!>=")
				# NOT A1 is greater or equal to A2
				if ! ((${argument[0]} >= ${argument[2]})); then
                                        gate_output=1
                                else
                                        gate_output=0
                                fi
                                ;;
			"<=")
				# A1 is lower or equal to A2
				if ((${argument[0]} <= ${argument[2]})); then
                                        gate_output=1
                                else
                                        gate_output=0
                                fi
                                ;;
			"!<=")
				# NOT A1 is lower or equal to A2
				if ! ((${argument[0]} <= ${argument[2]})); then
                                        gate_output=1
                                else
                                        gate_output=0
                                fi
                                ;;
		esac
		if [ "${argument[3]}" = "!" ]; then
			# NOT
			gate_output="$((1-$gate_output))"
		fi
		gates[${#gates[@]}]=$gate_output
	else
		gates[${#gates[@]}]=${argument[0]}
	fi
done
gate_output=0
if [ "${#gates[@]}" = "1" ]; then
	gate_output=${gates[0]}
fi
tempcount="$((${#gates[@]}-1))"
tempcount="$(($tempcount/2))"
i2=0
tempi=0
while ((tempi < tempcount)); do
	tempi="$(($tempi+1))"
	i2="$(($i2+2))"
	gate=()
	if ((i2 == 2)); then
		gate[${#gate[@]}]=${gates[$(($i2-2))]}
	else
		gate[${#gate[@]}]=$gate_output
	fi
	gate[${#gate[@]}]=${gates[$(($i2-1))]}
	gate[${#gate[@]}]=${gates[$i2]}
	case ${gate[1]}	in
		"&&")
			# AND
			if [ "$((${gate[0]}+${gate[2]}))" = "2" ]; then
                                        gate_output=1
			else
                                        gate_output=0
			fi
			;;
		"!&")
			# NAND
			if ! [ "$((${gate[0]}+${gate[2]}))" = "2" ]; then
                                        gate_output=1
                        else
                                        gate_output=0
                        fi
                        ;;
		"||")
			# OR
			if ! [ "$((${gate[0]}+${gate[2]}))" = "0" ]; then
                                        gate_output=1
                        else
                                        gate_output=0
                        fi
                        ;;
		"!|")
			# NOR
			if [ "$((${gate[0]}+${gate[2]}))" = "0" ]; then
                                        gate_output=1
                        else
                                        gate_output=0
                        fi
                        ;;
		"/")
			# XOR
			if [ "$((${gate[0]}+${gate[2]}))" = "1" ]; then
                                        gate_output=1
                        else
                                        gate_output=0
                        fi
                        ;;
		"!/")
			# XNOR
			if ! [ "$((${gate[0]}+${gate[2]}))" = "1" ]; then
                                        gate_output=1
                        else
                                        gate_output=0
                        fi
                        ;;
	esac
done
if ((gate_output == 0)); then
	pos=0
	process_command "${PRG[$(($i1-1))]}"
	until [ "$tempcond" = "1" ] && [ "$pos" = "0" ]; do
		i1="$(($i1+1))"
		process_command "${PRG[$(($i1-1))]}"
		if [ "${command[0]}" = "4" ]; then
			pos="$(($pos+1))"
		elif [ "${command[0]}" = "5" ]; then
			pos="$(($pos-1))"
		fi
		if [ "${command[0]}" = "5" ] || [ "${command[0]}" = "6" ]; then
                        tempcond=1
                else
                        tempcond=0
                fi
	done
fi
