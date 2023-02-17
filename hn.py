#!/usr/bin/env python3

import requests

def link(url, name):
    if url:
        esc = '\033'
        h = esc + ']8;;'
        st = esc + '\\'
        return h + url + st + name + h + st
    else:
        return name

total = 10
url = 'https://hacker-news.firebaseio.com/v0'

with requests.Session() as session:
    ids = session.get(f'{url}/topstories.json').json()
    for i, id in enumerate(ids[:total], start=1):
        item = session.get(f'{url}/item/{id}.json').json()
        print(f"{i:2}) {link(item.get('url'), item['title'])}")
        print('    ' + link(f'https://news.ycombinator.com/item?id={id}', f"{item['by']} | {item['score']}"))
