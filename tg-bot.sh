
#!/bin/bash

KEY="609246180:AAHfXO6i0D7PrVssTE791RA967efux5DsS8"

URL="https://api.telegram.org/bot$KEY/sendMessage"
TARGET2="287470785" #dimas id
TARGET="475602656" # Telegram ID of the conversation with the bot, get it from /getUpdates API
curl -s ipecho.net/plain >  /home/pi/ippublic.txt
ippublic1=$(cat /home/pi/ippublic.txt)
ippublic2=$(cat /home/pi/ippublic2.txt)

TEXT=$(echo current ip public  $ippublic1 $(date '+%Y-%m-%d %H:%M:%S %Z'))

PAYLOAD="chat_id=$TARGET&text=$TEXT&parse_mode=Markdown&disable_web_page_preview=true"

PAYLOAD2="chat_id=$TARGET2&text=$TEXT&parse_mode=Markdown&disable_web_page_preview=true"
if [ ! $ippublic1 == $ippublic2 ]; then
        curl -s ipecho.net/plain  > /home/pi/ippublic2.txt
        curl -s --max-time 10 --retry 5 --retry-delay 2 --retry-max-time 10 -d "$PAYLOAD" $URL > /dev/null 2>&1 &
        curl -s --max-time 10 --retry 5 --retry-delay 2 --retry-max-time 10 -d "$PAYLOAD2" $URL > /dev/null 2>&1 &

fi
