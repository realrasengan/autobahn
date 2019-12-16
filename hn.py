#!/usr/bin/env python3

import requests

total = 10
url = 'https://hacker-news.firebaseio.com/v0'
stories = requests.get(f'{url}/topstories.json').json()
i = 1
for story in stories[:total]:
    item = requests.get(f'{url}/item/{story}.json').json()
    n = f'{i})'
    if i < 10:
        n += ' '
    print(f"{n} {item['title']} | {item['url']}")
    print(f"    https://news.ycombinator.com/item?id={story} | {item['by']} | {item['score']}")
    i += 1
