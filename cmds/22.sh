 #!/bin/bash

# ---
# Replace item in list.
# 16/[item],[string]/[list name]
# ---
source ./f.sh
process_argument "${command[2]}"
temp4="${argument[0]}"
process_argument "${command[1]}"
echo > ./misc/.list && rm ./misc/.list
i3=0
echo "$(wc -l < "./misc/.lists/$temp4")"
tmplen="$(wc -l < "./misc/.lists/$temp4")"
while ((i3 < tmplen)); do
	i3=$((i3+1))
	echo $i3
	if [[ "$i3" = "${argument[0]}" ]]; then
		echo "${argument[1]}" >> "./misc/.list"
	else
		tmp0='!'
		echo "$(sed "${i3}${tmp0}d" "./misc/.lists/$temp4")" >> "./misc/.list"
	fi
done
rm "./misc/.lists/$temp4" && mv ./misc/.list "./misc/.lists/$temp4"
