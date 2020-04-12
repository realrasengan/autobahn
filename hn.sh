#!/bin/bash

item_num=0
item_ids=$(curl -s 'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty' | jq -r '.[]')

for item_id in $item_ids; do
    item_num=$((item_num + 1))
    if [[ $item_num -gt 10 ]]; then
        break
    fi

    readarray -t F < <(
        curl -s "https://hacker-news.firebaseio.com/v0/item/${item_id}.json" | \
            jq -r '"\(.title)\n\(.url)\n\(.by)\n\(.score)"')

    printf "%-3s %s | %s\n" "$item_num)" "${F[0]}" "${F[1]}"
    echo "    https://news.ycombinator.com/item?id=${item_id} | ${F[2]} | ${F[3]}"
done
