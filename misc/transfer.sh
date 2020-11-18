#!/bin/bash

if ((move == 1)); then
	if test -f "./SMC/program.smc"; then
		mv ./SMC/program.smc ./program.smc
	else
		echo "Error: couldn't find program.smc."
		rm ./smctransfer.sh &
		exit -2
	fi
fi
smcdir=SMC
until [ -d "$smcdir" ]; do
	read -p "Couldn't find your SMC directory. Please enter its name: " smcdir
done
while true; do
	read -p "Are you sure you want to delete your SMC directory? (Y/N)" yn
	case $yn in
		[Yy]* ) break;;
		[Nn]* )
			cp ./smctransfer.sh "./${smcdir}/misc/transfer.sh"
			if ((move == 1)); then
				mv ./program.smc "./${smcdir}/program.smc"
			fi
			rm ./smctransfer.sh &
			exit
			;;
		* ) echo "Please answer yes or no.";;
	esac
done
rm -rf ./SMC
git clone --single-branch --branch "$branch" https://github.com/adazem009/SMC
if ((move == 1)); then
	mv ./program.smc ./SMC/program.smc
fi
cd SMC
chmod +x ./smc.sh && chmod +x ./update.sh
rm ../smctransfer.sh &
