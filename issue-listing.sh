#!/bin/bash -e

cd /media/daniell/Windows\ 10\ main/Users/Daniell/Desktop/Orgute/peeper-user-daniell-mesquita/.issues/open

tmp="$(ls --file-type *.json | sort -n)" #- credits: https://www.unix.com/302856521-post4.html
echo "$tmp" > tmp.txt.tmp
#echo $tmp > tmp.txt
#tmp2="$(cat tmp.txt)"
#tmp2="$(echo $tmp)"
#rm tmp.txt
#formated="${tmp2%.*}"

loopmile="0"

cd ..
#if [ "$(jq -r '.open' issues-list.json)" = "null" ] || [ "$(jq -r '.open' issues-list.json)" = "" ]; then
#   echo "Its your first time using issue-listing.sh!"
#   echo "Initializing..."
#   cat >> issues-list.json << ENDOFFILE
#{
#	"open": [{}],
#	"closed": [{}]
#}
#ENDOFFILE
#fi
if [ "$(jq -r '.open' data.json)" = "null" ] || [ "$(jq -r '.open' data.json)" = "" ]; then
   echo "Its your first time using issue-listing.sh!"
   echo "Initializing..."
   tmp="$(mktemp)"; cat data.json | jq ". += {\"open\":[{}]}" >"$tmp" && mv "$tmp" data.json
   tmp="$(mktemp)"; cat data.json | jq ". += {\"closed\":[{}]}" >"$tmp" && mv "$tmp" data.json
fi
cd open

while IFS="" read -r p || [ -n "$p" ]
do
  cd ..
  formated="${p%.*}"
  echo "$formated"
  #tmp="$(mktemp)"; cat issues-list.json | jq ".open[] += {\"$loopmile\":[{\"id\": \"\",\"metadata\":\"\",\"name\":\"\",\"description\":\"\",\"image\":\"\",\"blockchain\":\"\"}]}" >"$tmp" && mv "$tmp" issues-list.json
  tmp="$(mktemp)"; cat data.json | jq ".open[] += {\"$loopmile\":\"$formated\"}" >"$tmp" && mv "$tmp" data.json
  #printf '%s\n' "$p"
  loopmile="$(($loopmile + 1))"
  echo "Loop: $loopmile"
  cd open
done < tmp.txt.tmp
#- credits: https://stackoverflow.com/a/1521498/5623661

rm tmp.txt.tmp

#echo "$formated"
