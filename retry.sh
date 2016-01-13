# /bin/bash
#retry.sh
#author: Nicholas Peterson (longboolean)
#description: will rerun a command that fails untill it runs successfully.
#example: $ retry.sh 30s "livestreamer http://www.twitch.tv/handmade_hero best"

if [ -n "$1" ]; then
	numSeconds=$1
	runCommand=$2
else
	echo -n "Command: "
	read runCommand 
	echo -n "Seconds: "
	read numSeconds
fi

while true
do
	echo "running: $runCommand "
	bash -c "$runCommand"
	error=$?
	if [ $error -eq "0" ]; then
		echo "Successfully ran command."
		break;
	else
		echo "Command failed, rerun in $numSeconds"
		echo -n "    ctrl-C to Cancel."
		echo " "
		sleep $numSeconds
	fi

done
