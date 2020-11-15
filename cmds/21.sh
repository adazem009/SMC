 #!/bin/bash

# ---
# Append to list.
# 15/[string]/[list name]
# ---
source ./f.sh
process_argument "${command[2]}"
temp4="${argument[0]}"
process_argument "${command[1]}"
echo "${argument[0]}" >> "./misc/.lists/$temp4"
