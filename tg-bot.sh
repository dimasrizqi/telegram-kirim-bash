#!/bin/bash

KEY="609246180:AAHfXO6i0D7PrVssTE791RA967efux5DsS8"

URL="https://api.telegram.org/bot$KEY/sendMessage"
TARGET2="287470785" #dimas id
TARGET="475602656" # Telegram ID of the conversation with the bot, get it from /getUpdates API
ippublic1=$(cat /home/pi/ippublic.txt)
ippublic2=$(cat /home/pi/ippublic2.txt)

#TEXT="User *$PAM_USER* logged in on *$HOSTNAME* at $(date '+%Y-%m-%d %H:%M:%S %Z')
TEXT=$(echo current ip public  $ippublic1 $(date '+%Y-%m-%d %H:%M:%S %Z'))

PAYLOAD="chat_id=$TARGET&text=$TEXT&parse_mode=Markdown&disable_web_page_preview=true"

PAYLOAD2="chat_id=$TARGET2&text=$TEXT&parse_mode=Markdown&disable_web_page_preview=true"
curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//' > /home/pi/ippublic.txt
if [ ! $ippublic1 == $ippublic2 ]; then
	curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//' > /home/pi/ippublic2.txt
	curl -s --max-time 10 --retry 5 --retry-delay 2 --retry-max-time 10 -d "$PAYLOAD" $URL > /dev/null 2>&1 &
	curl -s --max-time 10 --retry 5 --retry-delay 2 --retry-max-time 10 -d "$PAYLOAD2" $URL > /dev/null 2>&1 &

fi

# Run in background so the script could return immediately without 
# blocking PAM
#curl -s checkip.dyndns.org | sed -e 's/.*Current IP Address: //' -e 's/<.*$//' > ippublic2.txt
#curl -s --max-time 10 --retry 5 --retry-delay 2 --retry-max-time 10 -d "$PAYLOAD" $URL > /dev/null 2>&1 &
#curl -s --max-time 10 --retry 5 --retry-delay 2 --retry-max-time 10 -d "$PAYLOAD2" $URL > /dev/null 2>&1 &
