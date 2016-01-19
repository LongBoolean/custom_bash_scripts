#! /bin/bash
#check_streams.sh
#author: Nicholas Peterson
#note: requires livestreamer
FILENAME="streams.txt"

echo -e -n "***** Check Streams *****"
#for each stream in file
while read -r -a line
do
	if [ $line ]; then
		if [ ${line:0:1} == "#" ]; then
			#echo comment in file
			echo -e -n "\n$line\n"
		else
			streamURL="$line"
			#check if stream is online
			{
				bash -c "livestreamer $streamURL"
			} &> /dev/null #silence the output of this command
			error=$?
			#print out status of the stream
			if [ $error -eq "0" ]; then
				echo -e -n "ONLINE \t $streamURL \n"
			else
				echo -e -n "       \t $streamURL \n"
			fi
		fi
	fi
done < "$FILENAME"  
echo -e -n "\n"
