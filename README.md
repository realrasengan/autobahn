# autobahn
## automatic Hacker News front page output in terminal

### Why
I wanted to have up to date HN information, and I noticed I was opening my terminal a lot.
I used to have fortune readings in my terminal, but I figured it was better if I was able
to read HN headlines.

This was made simply in bash so as to not require many dependencies. It also requires some
tools found in *NIX including tr, jq, curl, sed, awk, echo and bash.

### Installation
Add to .bashrc

Example:
```
bash ~/path/to/autobahn.sh
```

You can also set the max # of stories to display (defaults at 10).  For example, this will
limit it to 5:
```
bash ~/path/to/autobahn.sh 5
```


Then type `source .bashrc`

### Sample Output
```
01) ESP32/ESP8266 Wi-Fi Attacks <https://github.com/Matheus-Garbelini/esp32_esp8266_attacks>
    Discussion: <https://news.ycombinator.com/item?id=20867758> | Poster: gioscarab | Score: 261
02) Go 1.13 Release Notes <https://golang.org/doc/go1.13>
    Discussion: <https://news.ycombinator.com/item?id=20869324> | Poster: 0xmohit | Score: 118
03) Mozilla’s Manifest v3 FAQ <https://blog.mozilla.org/addons/2019/09/03/mozillas-manifest-v3-faq/>
    Discussion: <https://news.ycombinator.com/item?id=20867720> | Poster: Findus23 | Score: 101
04) Android 10 <https://www.android.com/android-10/?>
    Discussion: <https://news.ycombinator.com/item?id=20868164> | Poster: Aissen | Score: 258
05) A Gambler Who Cracked the Horse-Racing Code (2018) <https://www.bloomberg.com/news/features/2018-05-03/the-gambler-who-cracked-the-horse-racing-code>
    Discussion: <https://news.ycombinator.com/item?id=20865312> | Poster: tosh | Score: 221

Get all news at https://news.ycombinator.com/
```

### Deletion
Remove from .bashrc

### License
Copyright (c) 2019 Andrew Lee (MIT License)
