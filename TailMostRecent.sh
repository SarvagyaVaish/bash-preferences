#!/bin/bash

if [ "$#" -ne 1 ] ; then
	echo -e "Error: Exactly 1 argument expected.\n"
	echo -e "Possible arguments:"
	echo -e "\t--diLog"
	exit 1
fi

FOLDER=""
CURRENT_TAIL_FILE=""
CURRENT_TAIL_PID=""

if [ "$1" == "--diLog" ] ; then
	FOLDER="/c/Users/$USERNAME/AppData/Local/Neocis/DentalImplant/Logs"
	echo "Tailing latest file in folder: $FOLDER"
fi

if [ "$FOLDER" == "" ] ; then 
	echo -e "Error: Incorrect arguments."
	exit 1
fi

# Function to kill tail PID passed in argument $1
function KillTail() {
	if [ "$CURRENT_TAIL_PID" != "" ] ; then
		kill $CURRENT_TAIL_PID
	fi
}

# Catch Ctrl-C commands to kill task cleanly
trap ctrl_c 2 
function ctrl_c() {
	KillTail
	exit
	trap - 2
}

# Function to get latest file in folder passed in argument $1
function Update_LATEST_FILE() {
	LATEST_FILE=$(find "$1" -maxdepth 1 -type f -printf "%T@ %p\n" | sort -n | tail -n 1 | cut -d' ' -f 2-)
}

# Loop until user quits script using 'q' command
while true; do
	
	Update_LATEST_FILE "$FOLDER"

	if [ "$LATEST_FILE" != "$CURRENT_TAIL_FILE" ] ; then
		KillTail

		CURRENT_TAIL_FILE="$LATEST_FILE"

		echo "Starting tail on: $CURRENT_TAIL_FILE"
		tail --lines=0 -f "$CURRENT_TAIL_FILE" &

		CURRENT_TAIL_PID="$!"
	fi
	
	QUIT_COMMAND=""
	read -t 5 QUIT_COMMAND

	if [ "$QUIT_COMMAND" == "q" ] ; then
		KillTail
		break;
	fi

done