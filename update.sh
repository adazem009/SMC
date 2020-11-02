#!/bin/bash

read -p "Which branch do you want to use? (main/beta)" branch
if [[ "$branch" != "main" ]] && [[ "$branch" != "beta" ]]; then
	echo "Error: couldn't find branch '${branch}'."
	exit -1
fi
move=0
while true; do
	read -p "Do you want to move your program.smc to the new directory? (Y/N)" yn
	case $yn in
		[Yy]* ) move=1; break;;
		[Nn]* ) break;;
		* ) echo "Please answer yes or no.";;
	esac
done
echo "Moving transfer script..."
mv ./misc/transfer.sh ../smctransfer.sh
echo "Executing transfer script..."
cd ..
source ./smctransfer.sh
echo Done! && sleep 1
