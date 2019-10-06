# autobahn
## automatic Hacker News front page output in terminal

### Why
I wanted to have up to date HN information, and I noticed I was opening my terminal a lot.
I used to have fortune readings in my terminal, but I figured it was better if I was able
to read HN headlines.

This was made simply in bash so as to not require many dependencies. It also requires some
tools found in *NIX including tr, jq, curl, sed, awk, echo and bash.

### Installation
Clone autobahn
```
git clone https://github.com/realrasengan/autobahn
```

Copy autobahn.sh new location
```
cd autobahn
cp autobahn.sh ~/.autobahn.sh
```

Add to .bashrc
```
echo "bash ~/.autobahn.sh" >> .bashrc
```

Adding the script to crontab greatly increases the speed at which the script will run on terminal open.
```
crontab -l > .tmp.crontab.output
echo "*/10 * * * * ~/.autobahn.sh" >> .tmp.crontab.output
crontab .tmp.crontab.output
rm .tmp.crontab.output
```

You can also set the max # of stories to display (defaults at 10).  For example, this will
limit it to 5:
```
crontab -l > .tmp.crontab.output
echo "*/10 * * * * ~/.autobahn.sh 5" >> .tmp.crontab.output
crontab .tmp.crontab.output
rm .tmp.crontab.output
```
Then type `source .bashrc`

### Created Files
The script will create 2 files on each run:
```
~/.autobahn.output ~/.autobahn.last
```


### Sample Output
```
01) Stripe Capital <https://stripe.com/capital>
    166 points by jonknee | 1 hour ago | 63 comments: <https://news.ycombinator.com/item?id=20888817>
02) An Introduction to D3.js <https://wattenberger.com/blog/d3>
    231 points by slowhand09 | 2 hours ago | 36 comments: <https://news.ycombinator.com/item?id=20887708>
03) Debunking the Silly “Passive [Investing] Is a Bubble” Myth <https://awealthofcommonsense.com/2019/09/debunking-the-silly-passive-is-a-bubble-myth/>
    208 points by sharkbot | 2 hours ago | 122 comments: <https://news.ycombinator.com/item?id=20887641>
04) Don’t force allocations on the callers of your API <https://dave.cheney.net/2019/09/05/dont-force-allocations-on-the-callers-of-your-api>
    44 points by robfig | 1 hour ago | 23 comments: <https://news.ycombinator.com/item?id=20888238>
05) WeWork Parent Weighs Slashing Its Valuation in Half <https://www.wsj.com/articles/wework-parent-weighs-slashing-its-valuation-roughly-in-half-11567689174?mod=rsswn>
    215 points by jason_zig | 5 hours ago | 158 comments: <https://news.ycombinator.com/item?id=20886315>

Get all news at https://news.ycombinator.com/
```

### Deletion
Remove from .bashrc

Remove from crontab

Remove files with prefix ~/.autobahn.*

### Alternate Implementations
hn.ps1 - in MS Powershell by [gabrielsroka](https://github.com/gabrielsroka)

### License
Copyright (c) 2019 Andrew Lee (MIT License)

Copyright (c) 2019 github.com/realrasengan/autobahn Contributors (MIT License)
