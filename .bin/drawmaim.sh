#!/bin/bash

function usage {
	echo "Usage: $(basename $0) <options>"
	echo "This script uploads screen regions to Imgur and returns a link."
	echo ""
	echo "Options:"
	echo "-h, --help: Show this help message."
	echo "-f: Screenshot full screen and upload."
	echo "-s: Screenshot a selection and upload."
	echo "-d: Screenshot all workspaces."
}

if [ "$1" = "-h" -o "$1" = "--help" ]; then
	usage
	exit 0
elif [ "$1" == "-f" ]; then
	maim --hidecursor /tmp/ss.png
	notify-send "Fullscreen screenshot taken."
	upload /tmp/ss.png
	exit 1
elif [ "$1" = "-s" ]; then
	maim --hidecursor -g $(slop -b 1 -c 1,1,1,1 -f "%wx%hx%xx%y ") /tmp/ss.png
	notify-send "Selective screenshot taken."
	upload /tmp/ss.png
	exit 1
elif [ "$1" = "-d" ]; then
	notify-send "Taking all-workspaces screenshot."
	deskmaim
	notify-send "All-workspace screenshot taken."
	upload /tmp/ss.png
	exit 1
fi
