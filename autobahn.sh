#!/bin/bash
#
# autobaHN (auto bash HN)
# automatic Hacker News front page output in terminal
#
# Copyright (C) 2019 Andrew Lee (MIT LICENSE)

args=("$@")
TIMESTAMP=`date +%s`

function populate_HN () {
  # Maximum results to display
  # set with ./autobahn <num> (example: ./autobahn 5)
  if [ $# -ne 1 ]
    then
      TOTAL_ITEMS=10
    else
      TOTAL_ITEMS=${args[0]}
  fi

  # Get HN API Top Stories
  HN_ITEMS_FP=`curl -H 'Cache-Control: no-cache' -s https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty`

  # Start scope of output redirection
  {
    # Loop through top TOTAL_ITEMS stories
    COUNTER="1"
    while [ $COUNTER -le $TOTAL_ITEMS ]
    do
      # Get current item json
      HN_ITEMS_CURRENT=`echo $HN_ITEMS_FP | jq ".[]" | tr '\n' ' ' | awk -v COUNTER="$COUNTER" '{print $COUNTER}'`
      HN_ITEMS_CURRENT_DATA=`curl -H 'Cache-Control: no-cache' -s https://hacker-news.firebaseio.com/v0/item/$HN_ITEMS_CURRENT.json?print=pretty`

      # Parse current item json
      HN_ITEMS_CURRENT_DATA_TITLE=`echo $HN_ITEMS_CURRENT_DATA | jq -r '.title'`
      HN_ITEMS_CURRENT_DATA_URL=`echo $HN_ITEMS_CURRENT_DATA | jq -r '.url'`
      HN_ITEMS_CURRENT_DATA_POSTER=`echo $HN_ITEMS_CURRENT_DATA | jq -r '.by'`
      HN_ITEMS_CURRENT_DATA_SCORE=`echo $HN_ITEMS_CURRENT_DATA | jq '.score'`
      HN_ITEMS_CURRENT_DATA_TIME=`echo $HN_ITEMS_CURRENT_DATA | jq '.time'`
      HN_ITEMS_CURRENT_DATA_DESCENDANTS=`echo $HN_ITEMS_CURRENT_DATA | jq '.descendants'`
      HN_ITEMS_CURRENT_DATA_COMMENTS=`echo "https://news.ycombinator.com/item?id=$HN_ITEMS_CURRENT"`

      # Parse current item time
      HN_ITEMS_CURRENT_DATA_TIME=$[$TIMESTAMP-$HN_ITEMS_CURRENT_DATA_TIME]
      if [ $HN_ITEMS_CURRENT_DATA_TIME -lt 3600 ]
        then
          HN_ITEMS_CURRENT_DATA_TIME=$[$HN_ITEMS_CURRENT_DATA_TIME/60]
          if [ $HN_ITEMS_CURRENT_DATA_TIME -lt 2 ]
            then
              HN_ITEMS_CURRENT_DATA_TIME=`echo $HN_ITEMS_CURRENT_DATA_TIME minute ago`
            else
              HN_ITEMS_CURRENT_DATA_TIME=`echo $HN_ITEMS_CURRENT_DATA_TIME minutes ago`
          fi
        else
          HN_ITEMS_CURRENT_DATA_TIME=$[HN_ITEMS_CURRENT_DATA_TIME/60/60]
          if [ $HN_ITEMS_CURRENT_DATA_TIME -lt 2 ]
            then
              HN_ITEMS_CURRENT_DATA_TIME=`echo $HN_ITEMS_CURRENT_DATA_TIME hour ago`
            else
              HN_ITEMS_CURRENT_DATA_TIME=`echo $HN_ITEMS_CURRENT_DATA_TIME hours ago`
          fi
      fi

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
      echo -e "\e[33;1m    $HN_ITEMS_CURRENT_DATA_SCORE points by $HN_ITEMS_CURRENT_DATA_POSTER | $HN_ITEMS_CURRENT_DATA_TIME | $HN_ITEMS_CURRENT_DATA_DESCENDANTS comments: <\e[33;4m$HN_ITEMS_CURRENT_DATA_COMMENTS\e[33;0m\e[33;1m>\e[32;0m"

      # Increment Counter
      COUNTER=$[$COUNTER+1]
    done


    echo ""
    echo -e "Get all news at \e[39;4mhttps://news.ycombinator.com/\e[39;0m"
  } > ~/.autobahn.output

  # Timestamp
  {
    echo $TIMESTAMP
  } > ~/.autobahn.last
}

if [ -t 1 ]
  then
    if [ -f ~/.autobahn.last ]
      then
        LAST=`cat ~/.autobahn.last`
        DIFFERENCE=$[$TIMESTAMP-$LAST]
        if [ $DIFFERENCE -gt 600 ]
          then
            populate_HN
            cat ~/.autobahn.output
          else
            cat ~/.autobahn.output
        fi
      else
        populate_HN
        cat ~/.autobahn.output
    fi
  else
    populate_HN
fi

