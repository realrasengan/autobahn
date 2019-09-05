#!/bin/bash
#
# autobaHN (auto bash HN)
# automatic Hacker News front page output in terminal
#
# Copyright (C) 2019 Andrew Lee (MIT LICENSE)

# Maximum results to display
TOTAL_ITEMS=25

# Get HN API Top Stories
HN_ITEMS_FP=`curl -H 'Cache-Control: no-cache' -s https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty`

# Loop through top TOTAL_ITEMS stories
COUNTER="1"
while [ $COUNTER -le $TOTAL_ITEMS ]
do
  # Get current item json
  HN_ITEMS_CURRENT=`echo $HN_ITEMS_FP | jq ".[]" | tr '\n' ' ' | awk -v COUNTER="$COUNTER" '{print $COUNTER}'`
  HN_ITEMS_CURRENT_DATA=`curl -H 'Cache-Control: no-cache' -s https://hacker-news.firebaseio.com/v0/item/$HN_ITEMS_CURRENT.json?print=pretty`

  # Parse current item json
  HN_ITEMS_CURRENT_DATA_TITLE=`echo $HN_ITEMS_CURRENT_DATA | jq '.title' | sed -e 's/^\"//' -e 's/\"$//'`
  HN_ITEMS_CURRENT_DATA_URL=`echo $HN_ITEMS_CURRENT_DATA | jq '.url' | sed -e 's/^\"//' -e 's/\"$//'`
  HN_ITEMS_CURRENT_DATA_POSTER=`echo $HN_ITEMS_CURRENT_DATA | jq '.by'| sed -e 's/^\"//' -e 's/\"$//'`
  HN_ITEMS_CURRENT_DATA_SCORE=`echo $HN_ITEMS_CURRENT_DATA | jq '.score'`
  HN_ITEMS_CURRENT_DATA_COMMENTS=`echo "https://news.ycombinator.com/item?id=$HN_ITEMS_CURRENT"`

  # Output data
  if [ $COUNTER -lt 10 ]
    then
      OUTPUT_COUNTER="0$COUNTER"
    else
      OUTPUT_COUNTER="$COUNTER"
  fi
  if [ $HN_ITEMS_CURRENT_DATA_URL != "null" ]
    then
      echo -e "$OUTPUT_COUNTER) \e[32;1m$HN_ITEMS_CURRENT_DATA_TITLE\e[32;0m <\e[39;4m$HN_ITEMS_CURRENT_DATA_URL\e[32;0m>"
    else
      echo -e "$OUTPUT_COUNTER) \e[32;1m$HN_ITEMS_CURRENT_DATA_TITLE\e[32;0m"
  fi
  echo -e "\e[33;1m    Discussion: <\e[33;4m$HN_ITEMS_CURRENT_DATA_COMMENTS\e[33;0m\e[33;1m> | Poster: $HN_ITEMS_CURRENT_DATA_POSTER | Score: $HN_ITEMS_CURRENT_DATA_SCORE\e[32;0m"

  # Increment Counter
  COUNTER=$[$COUNTER+1]
done


echo ""
echo -e "Get all news at \e[39;4mhttps://news.ycombinator.com/\e[39;0m"
