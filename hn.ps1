#!/snap/bin/pwsh

$total = 25
$url = "https://hacker-news.firebaseio.com/v0"
$stories = Invoke-RestMethod "$url/topstories.json"
for ($i = 1; $i -le $total; $i++) {
    $story = $stories[$i - 1]
    $item = Invoke-RestMethod "$url/item/$story.json"
    if ($i -lt 10) {
        $n = "$i) "
    } else {
        $n = "$i)"
    }
    Write-Host $n $item.title "|" $item.url
    Write-Host "    https://news.ycombinator.com/item?id=$story |" $item.by "|" $item.score -ForegroundColor DarkYellow
}
