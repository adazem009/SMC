#!/bin/bash

# --- Functions ---
process_command ()
{
	local cmd="$1"
	cmdlen=${#cmd}
	command=()
	quotes=0
	temp=""
	i2=0
	while ((i2 < cmdlen)); do
		i2="$(($i2+1))"
		chartemp="$(($i2-1))"
		chartemp="${cmd:${chartemp}:1}"
		if [ "$chartemp" = '"' ]; then
			quotes="$((1-$quotes))"
		fi
		if [ "$chartemp" = "/" ] && ((quotes == 0)); then
			lentemp="${#command[@]}"
			addcmd="$temp"
			if (( lentemp == 0 )); then
				addcmd="$(( 16#$temp))"
			fi
			command[${#command[@]}]="$addcmd"
			temp=""
		else
			temp="${temp}${chartemp}"
		fi
	done
	lentemp="${#command[@]}"
	addcmd="$temp"
	if (( lentemp == 0 )); then
		addcmd="$(( 16#$temp))"
	fi
	command[${#command[@]}]="$addcmd"
}
execute ()
{
	source "./cmds/${command[0]}.sh"
	clear && cat ./misc/.screen
}
process_argument ()
{
	avalue=$1
	arglen=${#avalue}
	argument=()
	argument_translation=()
	quotes=0
	quoted=0
	temp=""
	i2=0
	while ((i2 < arglen)); do
		i2="$(($i2+1))"
		if [ "${avalue:$(($i2-1)):1}" = '"' ]; then
			quotes="$((1-$quotes))"
			quoted=1
		fi
		if [ "${avalue:$(($i2-1)):1}" = "," ] && ((quotes == 0)); then
			temp3=1
		else
			temp3=0
		fi
		if ((temp3 == 1)) || [ "$i2" = "$arglen" ]; then
			if [ "$i2" = "$arglen" ] && [ "${avalue:$(($i2-1)):1}" != '"' ]; then
				temp="${temp}${avalue:$(($i2-1)):1}"
			fi
			if ((quoted == 1)); then
				argument_translation[${#argument_translation[@]}]="0"
			else
				re='^-?[0-9]+([.][0-9]+)?$'
				if ! [[ $temp =~ $re ]]; then
        				argument_translation[${#argument_translation[@]}]="1"
					vari=0
					varlentemp=${#var_names[@]}
					varincluded=0
					while ((vari < varlentemp)); do
						vari="$(($vari+1))"
						if [ "${var_names[$(($vari-1))]}" = "$temp" ]; then
							varincluded=$vari
							break
						fi
					done
					if ((varincluded == 0)); then
						temp=""
					else
						temp=${var_values[$((${varincluded}-1))]}
					fi
				else
					argument_translation[${#argument_translation[@]}]="0"
				fi
			fi
			argument[${#argument[@]}]="$temp"
			temp=""
			quoted=0
		else
			if [ "${avalue:$(($i2-1)):1}" != '"' ]; then
				temp="${temp}${avalue:$(($i2-1)):1}"
			fi
		fi
	done
}
decode ()
{
	number=$1
	noend=$2
	list=()
	item=""
	letter=1
	nltemp="$((${#number} / 2))"
	loadi=0
	while ((loadi < nltemp)); do
		loadi="$(($loadi+1))"
		symbol="${number:$(($letter-1)):1}${number:$(($letter)):1}"
		if [ "$symbol" = "0" ]; then
			list[${#list[@]}]=$item
			item=""
		else
			if [ "$symbol" = "95" ]; then
				item="${item} "
			else
				if [ "${symbol:0:1}" = "0" ]; then
					symbol=${symbol:1:1}
				fi
				item="${item}${characters:$(($symbol-1)):1}"
			fi
		fi
		letter="$(($letter+2))"
	done
	if ((noend == 1)); then
		list[${#list[@]}]=$item
	fi
}
set_var ()
{
	varname=$1
	varvalue=$2
	vari=0
	varlentemp=${#var_names[@]}
	varincluded=0
	while ((vari < varlentemp)); do
		vari="$(($vari+1))"
		if [ "${var_names[$(($vari-1))]}" = "$varname" ]; then
			varincluded=$vari
			break
		fi
	done
	if ((varincluded == 0)); then
		var_names[${#var_names[@]}]="$varname"
		var_values[${#var_values[@]}]="$varvalue"
	else
		var_names[$(($varincluded-1))]="$varname"
		var_values[$(($varincluded-1))]="$varvalue"
	fi
}
wait_for_key ()
{
	local key=$1
	k="random"
	if [ "$key" = "enter" ]; then
		read -s
	elif [ "$key" = "space" ]; then
			read -s -d ' '
	elif [ "$key" = "any" ]; then
		read -n 1 -s -r
	else
		while [ "$k" != "$key" ]; do
			read -s -n 1 k <&1
		done
	fi
}
