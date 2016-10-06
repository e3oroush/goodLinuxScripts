#!/bin/sh
# this script calculates total duration of videos and maybe audios on the current directory or given directory
if [ -z "$1" ]
then
	DIRECTORY=*
else
	DIRECTORY=$1/*
fi
round()
{
	echo $(printf %.$2f $(echo "scale=$2;(((10^$2)*$1)+0.5)/(10^$2)" | bc))
};
totalTime=0
for file in $DIRECTORY
do
	echo $file ...
	totalTime=$totalTime+$(ffprobe -select_streams v -show_streams $file 2>/dev/null | grep duration= | cut -d"=" -f2)
done
totalTime=${totalTime}0
totalSeconds=`echo $totalTime | bc`
totalMinutes=$(round $totalSeconds/60 2)
driftSeconds=`a=$(echo $totalMinutes | cut -d"." -f2); echo $a*60/100|bc`
totalMinutes=`echo $totalMinutes | cut -d"." -f1`
echo total time is: $totalMinutes minutes and $driftSeconds seconds
