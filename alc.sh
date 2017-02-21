#!/bin/sh

# http://ssslab.wiki.fc2.com/wiki/alc%E3%81%AE%E6%A4%9C%E7%B4%A2%E7%B5%90%E6%9E%9C%E3%82%92%E4%BD%BF%E3%81%86cui%E3%81%AE%E8%8B%B1%E5%92%8C%E8%BE%9E%E6%9B%B8%E3%82%92%E3%82%B9%E3%82%AF%E3%83%AA%E3%83%97%E3%83%88%E3%81%A7
if test $# -eq 0;then
    echo "error: argument is required"
    exit
else
    KEY=$(python2 -c "import urllib;print urllib.quote_plus('$*')")
    URI='http://eow.alc.co.jp/'"$KEY"/
    wget -q -O - "$URI"|\
        sed -ne '/id="resultsList"/,/検索結果本体/p'|\
        w3m -dump -T text/html|\
        less
  fi
