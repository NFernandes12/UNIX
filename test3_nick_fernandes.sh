#!/bin/bash


FIRST_TTL="First"
LAST_TTL="Last"
JOB_TTL="Job"
OLD_TTL="Old"
NEW_TTL="New"
MESSAGE_TTL="Message"


printf "%-10s%-10s%-10s%-10s%-10s%-10s\n" $LAST_TTL $FIRST_TTL $JOB_TTL $OLD_TTL $NEW_TTL $MESSAGE_TTL

while read IN_TEST3
do
	USER_ID=`echo $IN_TEST3 | cut -d '|' -f1`
	LAST_NAME=`echo $IN_TEST3 | cut -d '|' -f2`
	FIRST_NAME=`echo $IN_TEST3 | cut -d '|' -f3`
	JOB=`echo $IN_TEST3 | cut -d '|' -f4`
	OLD_NICE=`echo $IN_TEST3 | cut -d '|' -f5`
	PREFERRED_PASSWORD=`echo $IN_TEST3 | cut -d '|' -f6`
	

	FULL_NAME="$FIRST_NAME $LAST_NAME"

	if [ "$JOB" = "P" ]
	then NEW_NICE=3
	
	elif [ "$JOB" = "S" ]
	then NEW_NICE=6
	
	else NEW_NICE=7
	fi
	
	test -d $USER_ID

	if [ "$?" -eq "0" ]
       	then
		MESSAGE="$USER_ID already setup"

	else
	       	useradd -m -c "$FULL_NAME" -p $(echo "$PREFERRED_PASSWORD"  | openssl passwd -1 -stdin) $USER_ID
		MESSAGE="$USER_ID created"
	fi


	test -d /home/$USER_ID/${LAST_NAME}_backup
	
	if [ "$?" -eq "0" ]
	then
	       MESSAGE="$USER_ID is already backed up"	
	else
		mkdir /home/$USER_ID/${LAST_NAME}_backup
	fi
	
	printf "%-10s%-10s%-10s%-10s%-10s%-15s%-10s%-10s\n" $LAST_NAME $FIRST_NAME $JOB $OLD_NICE $NEW_NICE $MESSAGE

done < test3_data.txt


