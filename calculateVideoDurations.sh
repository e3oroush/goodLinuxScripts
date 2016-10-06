#!/bin/bash
# this script calculates total duration of videos and maybe audios on the current directory or given directory
if [ -z "$1" ]
then
	DIRECTORY=.
else
	if [ -d $1 ]; then
		DIRECTORY=$1
	elif [ -f $1 ]; then
		FILE=$1
	else
		echo "file or directory not exists!"
		exit 1
	fi
fi
round()
{
	echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.5)/(10^$2)" | bc))
};
if [ -z $FILE ]; then
	FILES=`find $DIRECTORY`
elif [ -z $DIRECTORY ]; then
	FILES=$FILE
fi
totalTime=0
for file in $FILES
do
	videoTime=$(ffprobe -select_streams v -show_streams $file 2>/dev/null | grep duration= | cut -d"=" -f2)
	if [ ${#videoTime} != 0 ]; then
		echo $file lasts $videoTime seconds
		totalTime=$totalTime+$videoTime
	fi
done
totalTime=${totalTime}0
totalSeconds=`echo $totalTime | bc`
totalMinutes=$(round $totalSeconds/60 2)
driftSeconds=`a=$(echo $totalMinutes | cut -d"." -f2); echo $a*60/100|bc`
totalMinutes=`echo $totalMinutes | cut -d"." -f1`
echo total time is: $totalMinutes minutes and $driftSeconds seconds
