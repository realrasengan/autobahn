#!/usr/bin/env pwsh

$total = 10
$url = 'https://hacker-news.firebaseio.com/v0'
$ids = Invoke-RestMethod "$url/topstories.json"
$i = 1
foreach ($id in $ids[0..($total - 1)]) {
    $item = Invoke-RestMethod "$url/item/$id.json"
    $n = '{0,2})' -f $i++
    Write-Host $n $item.title '|' $item.url
    Write-Host "    https://news.ycombinator.com/item?id=$id |" $item.by '|' $item.score -ForegroundColor DarkYellow
}
