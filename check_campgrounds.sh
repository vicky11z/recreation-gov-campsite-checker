#!/bin/sh
source myvenv/bin/activate
found_campsite=false
found_start_date=""
found_end_date=""
# Add camp start & end date(s) 
for i in 2022-05-13,2022-05-14
    do IFS=","
    set -- $i
    available=$(python camping.py --start-date "$1" --end-date "$2" --stdin < campgrounds.txt | grep '🏕' )
    if [ -n "$available" ]
    then
        found_campsite=true
        found_start_date=$1
        found_end_date=$2
        terminal-notifier -title $available -message "$1"
    fi
done
if [ "$found_campsite" = true ]
then
    echo "$(date) - Found campsite for $found_start_date - $found_end_date:\n$available" >> cron_log.txt
else
    echo "$(date) - Did not find any campsites" >> cron_log.txt
fi
deactivate