#!/bin/bash

HOUR_MIN=$(date +"%H:%M")
DATE=$(date +"%d_%m_%y")

# check if jailbase folder has been modified in last 3 hours
MODIFIED=$(stat --printf "%Y" /farmshare/user_data/roesler/jailbase)
TIME=$(date +"%s")
DIFFERENCE=$(($TIME - $MODIFIED))
DIFFERENCE=$(($DIFFERENCE / 3600))
MAXDIFF=3
OUTPUT_FILE="/farmshare/user_data/roesler/check_scraping.txt"

if [ "$DIFFERENCE" -gt "$MAXDIFF" ]; then
	echo "$HOUR_MIN on $DATE: NOT scraping jailbase.com" >> $OUTPUT_FILE
	echo "STOPPED SCRAPING jailbase.com" | mail -s "$HOUR_MIN on $DATE: NOT scraping jailbase.com" katroesler@gmail.com
else
	echo "$HOUR_MIN on $DATE: Still scraping jailbase.com" >> $OUTPUT_FILE
fi