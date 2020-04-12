#!/usr/bin/env python3

import requests

total = 10
url = 'https://hacker-news.firebaseio.com/v0'
ids = requests.get(f'{url}/topstories.json').json()
for i, id in enumerate(ids[:total], 1):
    item = requests.get(f'{url}/item/{id}.json').json()
    print(f"{i:2}) {item['title']} | {item['url']}")
    print(f"    https://news.ycombinator.com/item?id={id} | {item['by']} | {item['score']}")
